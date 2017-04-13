class Route < ActiveRecord::Base
  has_many(
    :buses,
    class_name: "Bus",
    foreign_key: :route_id,
    primary_key: :id
  )

  def n_plus_one_drivers
    buses = self.buses

    all_drivers = {}
    buses.each do |bus|
      drivers = []
      bus.drivers.each do |driver|
        drivers << driver.name
      end
      all_drivers[bus.id] = drivers
    end

    all_drivers
  end

  def better_drivers_query
    # Create a hash with bus id's as keys and an
    # array of bus drivers as the corresponding value.
    buses = self.buses.includes(:drivers)

    bus_and_drivers = {}
    buses.each do |bus|
      bus_drivers = []
      bus.drivers.each { |driver| bus_drivers << driver.name }
      bus_and_drivers[bus.id] = bus_drivers
    end

    bus_and_drivers
  end
end
