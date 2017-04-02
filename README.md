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

I but together this application to showcase my programming styles for prospective clients, since most of the code I work on is proprietary and can't be shared.

## Prerequisites

* Ruby 2.4.0 (you can try other version by changing .ruby-version)
* Postgresql
* [Foreman](https://github.com/ddollar/foreman) to up from the Procfile
* [yarn](https://yarnpkg.com/en/) to install npm/node packages

## Setup

Run `bin/setup`, this will create a new database `rates-dev`, install the gems to `vendor/bundle`, install node modules to `node_modules` and migrate the database, and run the specs.

**DISCLAIMER:** This assumes your account has permissions to drop/create new postgresql databases. `bin/setup` will first try and drop `rates-dev`, so make sure you don't have a db with that name.  You can change the name in `.env.development`.

## Starting Up

Once you have issued the `bin/setup` command, you can issue `foreman start` (assuming you have `foreman` installed). Then you can visit [the App](http://localhost:9494).

**NOTE:** The [Fixer API](http://fixer.io/) is sometimes slow to respond, so it may take awhile to get some rates data imported.  You can check the STDOUT from the `foreman start` to see what the job/workers are doing.
