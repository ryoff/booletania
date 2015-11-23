# Booletania

translating AR booleans in I18n files

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'booletania'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install booletania

## Usage

model

````ruby
class Invitation < ActiveRecord::Base
  include Booletania
end
```

i18n

````ruby
ja:
  booletania:
    invitation:
      accepted:
        'true': 承諾
        'false': 拒否
```

- why text must need to quote?
  - [see also]
  - http://yaml.org/type/bool.html
  - https://groups.google.com/forum/#!topic/rails-i18n/aL-Ed1Y1KGo

view. if slim

````ruby
= @post.accepted_text # => 承諾

# same as
if @post.accepted?
  | 承諾
else
  | 拒否

= @post.accepted? ? '承諾' : '拒否'
```


## Contributing

1. Fork it ( https://github.com/[my-github-username]/booletania/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
