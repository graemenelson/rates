require 'spec_helper'

describe Importer::Organizer do
  subject { Importer::Organizer }

  it 'calls expected interactors' do
    subject.organized.must_equal [
      Importer::Import
    ]
  end
end
