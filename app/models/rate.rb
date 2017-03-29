class Rate
  include ActiveModel::Model

  attr_accessor :base, :quoted, :price, :date
end
