# Booletania

[![Build Status](https://travis-ci.org/ryoff/booletania.svg?branch=master)](https://travis-ci.org/ryoff/booletania)

Translate ActiveRecord's boolean column

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

migration

```ruby
create_table(:invitations) do |t|
  t.boolean :accepted
end
```

model

```ruby
class Invitation < ActiveRecord::Base
  include Booletania
end
```

i18n

```ruby
ja:
  booletania:
    invitation:
      accepted:
        'true': 承諾
        'false': 拒否
```

- why need to quote?
  - [see also]
  - http://yaml.org/type/bool.html
  - https://groups.google.com/forum/#!topic/rails-i18n/aL-Ed1Y1KGo

### #xxx_text
```ruby
invitation.accepted = true
invitation.accepted_text # => "承諾"

invitation.accepted = false
invitation.accepted_text # => "拒否"

I18n.locale = :en
invitation.accepted_text # => "deny"

invitation.accepted = true
invitation.accepted_text # => "accept"
```

### .xxx_options
```ruby
Invitation.accepted_options # => [['accept', true], ['deny', false]]

I18n.locale = :ja
Invitation.accepted_options # => [["承諾", true], ["拒否", false]]
```

for use in form
```ruby
f.collection_radio_buttons :accepted, Invitation.accepted_options, :last, :first
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/booletania/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
