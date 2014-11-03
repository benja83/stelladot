Stella&dot
=====

##Config Setting Model

###Instructions:

* Write a model (ActiveRecord-based) for storing global configuration settings.

* It must be possible to store values of these 4 types: string, integer, float and boolean. The model should come with a unit test and a migration.

* Add caching within the model so that values are cached in regular Rails cache to minimize db load.

##Install that repository

```bash
$ git clone https://github.com/benja83/stelladot.git

$ bundle install

$ rake db:create

$ rake db:migrate
```

##To check the features of this model

```bash
$ rake spec
```

##Getting started

* Create a new setting

```ruby
ConfigSetting.create name: "setting_name",data_type: "data_type", value: "value"
```

* Get converted value

```ruby
ConfigSetting.find(1).get_value
```

##Methodologies used for building this model

#### - TDD

I have used TDD methodology, building before the test and after the code.

#### - REFACTORING

After building each functionality and having all the test in green giving an Object-oriented programming approach.

#### - OPP

* Active record model:

Is the class responsible to connect the app with the database, make the validations and to call the other classes.

* Validator:


Is the class responsible to validate the value that the active record model want to store in the database depending of the datatype of the setting.

* Converter:

Is the class responsible to convert the value that the active record model have to return.

#### - SCALABILITY

The config setting model is very easy to extend. For adding new data type for settings, you just have to add two line:

* in `Validator.rb`:

```ruby
  @@data_type_rules = {/\A[0-9]*\z/ => "integer",
                      /\A[0-9]*\.[0-9]*\z/ => "float",
                      "true" => "boolean",
                      "false" => "boolean"
                      # add the regex => "new data_type"
                      }
```
* in `Converter.rb`:

```ruby
    @@conversion_rules = {"integer" => :to_i,
                        "float" => :to_f,
                        "string" => :to_s
                        # add data_type => method as a symbol to apply on the string store in data base
                        }
```

## Caching

There is a branch with caching using `ActiveSupport::Cache::MemoryStore`. It's not fully tested that's why it's not merged.