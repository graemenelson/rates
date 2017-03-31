# Rates

A sample application that display daily currency rate information from the 8 major currencies:

* USD
* CAD
* EUR
* GBP
* CHF
* AUD
* NZD
* JPY

I but together this application to showcase my programming styles for prospect clients, since most of the code I work on is proprietary and can't be shared.

## Prerequisites

* Ruby 2.4.0 (you can try other version by changing .ruby-version)
* Postgresql
* [Foreman](https://github.com/ddollar/foreman) to up from the Procfile

## Setup

Run `bin/setup`, this will create a new database `rates-dev`, install the gems to `vendor/bundle`, and migrate the database.

**DISCLAIMER:** This assumes your account has permissions to drop/create new postgresql databases. `bin/setup` will first try and drop `rates-dev`, so make sure you don't have a db with that name.  You can change the name in `.env.development`.

## Notes

* Application relies on `delegate` from  `ActiveSupport` instead of using the `Forwardable` module, only because the `Forwardable` modal does not work well with `Interactor` library.
* Applications also uses `try` from `ActiveSupport`.
