module Importer
  class Organizer
    include Interactor::Organizer

    organize Import # fetches data from fixer.io and saves to the db
  end
end
