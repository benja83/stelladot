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

##Methodologies used for building this model

#### - TDD

I have used TDD metodologies, building before the test and after the code.

#### - REFACTORING

After building each funcionality and having all the test in green giving an Object-oriented programming approch.

#### - OPP

* Active record model:

Is the class responsible to connect the app with the database, make the validations and to call the other classes.

* Validator:


Is the class responsible to validate the value that the active record model want to store in the database depending of the datatype of the setting.

* Converter:

Is the class responsible to convert the value that the active record model have to return.

## Caching

There is a branch with caching using `ActiveSupport::Cache::MemoryStore`. It's not fully tested that's why it's not merged.