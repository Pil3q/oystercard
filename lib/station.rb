class Station

  DEFAULT_ZONE = 1
  DEFAULT_NAME = :forgot_to_name_it

  attr_reader :zone, :name

  def initialize(zone = DEFAULT_ZONE, name = DEFAULT_NAME)
    @zone = zone
    @name = name
  end
end
