# siwapp-api-ruby-client
Siwapp (online invoice management) API Ruby client

## Getting started
`git clone https://github.com/Sology/siwapp-api-ruby-client.git`

Change `host` to your Siwapp application in `siwapp_api.json` file.

Assuming you have ruby 2.2.1, just run:

``` bash
gem install bundler
bundle
ruby generate_ruby_client.rb
```

This will generate ruby client from Swagger json file. It will include documentation also.

## Included requests

### Invoices
* create
* get pdf file
