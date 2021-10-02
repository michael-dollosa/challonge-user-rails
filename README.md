# Challonge API for user

This gem is for educational use only. I have created this to have a practice on how to create an API wrapper for Rails and create it in a ruby gem.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'challonge_user_rails'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install challonge_user_rails

## Usage

### Get an API Token from Challonge site
Create an account on [Challonge Website](https://challonge.com) and get an API via Settings - Developer API.

### Configure
Instance of the client must be done first before being able to use the API. You may check Rails [docs](https://guides.rubyonrails.org/security.html#custom-credentials) to setup your API key via credentials.yml.

```ruby
client = ChallongeUserRails::Client.new(api_key: [YOUR API KEY])
```

### Get all Tournaments

```ruby
client.tournaments
```

### Get specific Tournament
Tournament URL is the URL parameter (not the address) of the tournament when you create it.

```ruby
client.tournament(tournament_url)
```

### Delete Tournament
```ruby
client.delete_tournament(tournament_url)
```

### Create Tournament
Challonge API expects a json data with attributes related to creation of a tournament. You may refer to their [docs](https://api.challonge.com/v2/api_docs/single_swagger_doc#!/Tournament/createTournament) for an example json value.
```ruby
client.create_tournament(data)
```

### Get All Matches of a Tournament
```ruby
client.matches(tournament_url)
```

### Get a specific Tournament Match
```ruby
client.match(tournament_url, match_id)
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/michael-dollosa/challonge_user_rails. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/michael-dollosa/challonge_user_rails/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ChallongeUserRails project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/michael-dollosa/challonge_user_rails/blob/master/CODE_OF_CONDUCT.md).
