module Importer
  class Organizer
    include Interactor::Organizer

    organize CalcDate, # determines what date to fetch for the currency
             Import    # fetches data from fixer.io and saves to the db
  end
end
