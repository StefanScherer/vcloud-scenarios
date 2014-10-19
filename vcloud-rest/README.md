# vcloud-rest

This is a sandbox to play a little with [vcloud-rest](https://github.com/astratto/vcloud-rest).

## Installation

Installed on a Mac with

```bash
sudo gem install vcloud-rest
sudo gem install awesome_print
```

## SSL Verification

Our shitty cloud does not have a correct SSL certificate. So you have to ignore SSL verification on client side.

```bash
sudo vi 
sudo vi /Library/Ruby/Gems/2.0.0/gems/vcloud-rest-1.3.0/lib/vcloud-rest/connection.rb
```

In line 139 insert `:verify_ssl => false,` as shown here:

```ruby
        invocation_params = {:method => params['method'],
                             :headers => headers,
                             :url => "#{@api_url}#{params['command']}",
                             :verify_ssl => false,
                             :payload => payload}
 ```

 