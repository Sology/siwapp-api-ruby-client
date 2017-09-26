require 'zip'
require 'httparty'

gemName = "siwapp-client"
gemHomepage = "https://github.com/Sology/siwapp-api-ruby-client"
gemAuthor = "Sology"
gemAuthorEmail = "wojtek@sology.eu"
gemVersion = "1.0.1"

spec = File.open("./siwapp_api.json", "rb")

codegen_response = HTTParty.post(
  'https://generator.swagger.io/api/gen/clients/ruby',
  verify: false,
  headers: {
   'Content-Type' => 'application/json',
   'Accept' => 'application/json'
  },
  body: {
    options: {
      "gemName" => gemName,
      "gemHomepage" => gemHomepage,
      "gemAuthor" => gemAuthor,
      "gemAuthorEmail" => gemAuthorEmail,
      "gemVersion" => gemVersion
      },
    spec: JSON.parse(spec.read)
  }.to_json
)
puts codegen_response

link = codegen_response.parsed_response["link"]
if link
  puts "Downloading from #{link}"
  zip_filename = "zipped_gem_#{Time.now.to_i}.gz"
  File.open("/tmp/#{zip_filename}", "w") do |file|
    response = HTTParty.get(link, verify: false, stream_body: true) do |fragment|
      print "."
      file.write(fragment.force_encoding('UTF-8'))
    end
  end

  puts "\nExtracting from #{zip_filename}"
  Zip::File.open("/tmp/#{zip_filename}") do |zip_file|
    zip_file.each do |f|
      f_path = File.join("./", f.name)
        FileUtils.mkdir_p(File.dirname(f_path))
        puts "Extracting #{f.name}"
        zip_file.extract(f, f_path) unless File.exist? f_path
      end
  end
end
