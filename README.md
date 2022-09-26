# ANAF WebServices API [UNOFFICIAL]

![Build](https://github.com/siklodi-mariusz/anaf-web_services/actions/workflows/main.yml/badge.svg)

Unofficial Ruby client library for some of the Web API Services provided by Romanian ANAF.

ANAF is an acronym for *"Agenția Națională de Administrare Fiscală"* which translates to *National Agency of Fiscal Administration*.

You get the idea, ANAF is the Romanian governmental institution that makes sure everybody is paying their taxes.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'anaf-web_services'
```

Install the gem and add to the application's Gemfile by executing:

```bash
bundle add anaf-web_services
```

If bundler is not being used to manage dependencies, install the gem by executing:

```bash
gem install anaf-web_services
```

## Usage

Some terminology clarifications.

ANAF identifies companies by a number called **CUI**, again an acronym for *"Cod Unic de Inregistrare/Identificare"* = "Unique identification code"

The APIs operate based on this **CUI** number.

### VAT Registry API

This API returns some information about the companies but is mainly focused on the VAT status of the company, if it's VAT liable or not.

For more details about the underlying API see [here](https://static.anaf.ro/static/10/Anaf/Informatii_R/doc_WS_V6.txt) the official documentation but it's only in Romanian.

#### Get a company by CUI

```ruby
ANAF.get_company(123456)
=>
{"cui"=>123456, "data"=>"2022-09-26", "denumire"=>"Example 123456", ... }
```

#### Get multiple companies

```ruby
ANAF.get_companies([123456, 654321])
=>
[
    {"cui"=>123456, "data"=>"2022-09-26", "denumire"=>"Example 123456", ... },
    {"cui"=>654321, "data"=>"2022-09-26", "denumire"=>"Example 654321", ... }
]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/siklodi-mariusz/anaf-web_services. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/siklodi-mariusz/anaf-web_services/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ANAF::WebServices project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/siklodi-mariusz/anaf-web_services/blob/main/CODE_OF_CONDUCT.md).
