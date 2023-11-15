# Irp
Short description and motivation.

## creation
```sh
$ rails plugin new policies/irp --mountable --skip-test --dummy-path=spec/dummy
```

## Usage
How to use my plugin.

## Installation
Add this line to your application's Gemfile:

```ruby
gem "irp"
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install irp
```


Add `config/initializers/irp_policy.rb` to link claim, task clasess.
```ruby
Irp.config_class = "PolicyConfiguration"
Irp.claim_class = "Claim"
Irp.task_class = "Task"
Irp.school_class = "School"
```

Copy the migrations
```bash
$ rails irp:install:migrations
$ rails db:migrate
```




## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
