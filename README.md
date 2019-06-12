# AhcaCoreq
Gem to connect to AHCA's CoreQ exchange API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ahca_coreq', git: 'https://github.com/GitHubAdmin/ahca_coreq'
```

And then execute:

    $ bundle

## Configuration

Set your api keys via a loaded config as such:
```
AhcaCoreq.configure do |config|
  config.access_key  = 'your_access_key'
  config.secret_key  = 'your_secret_key'
end
```

## API Usage
The AhcaCoreq API has private endpoints. The below examples describe how to use them.

### Private
#####
```
ob = ::AhcaCoreq::Client.new.private.method1
```

