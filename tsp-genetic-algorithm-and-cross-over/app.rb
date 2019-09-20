require_relative 'algorithm'
require_relative 'travel_matrix'
require 'geocoder'

# Places you want to visit
places = ['Brandenburg Gate', 'Deutsches Technikmuseum',
          'Berlin Wall', 'Tiergarten']

coords = []
places.each { |e| coords << Geocoder.search(e).first.coordinates }

# Put your travel mode, options are [driving, walking, bicycling, transit]
travel_mode = 'driving'

travel_matrix = TravelMatrix.generate(coords, travel_mode)
results = GeneticAlgorithm.run(coords, travel_matrix)

# Best overall time
puts "You travel mode is #{travel_mode}"
puts "The fastest time you can travel this route is: #{results[:record_distance]}s"

# Best order of coordinates
places_in_order = []
results[:best_ever].each { |e| places_in_order << places[e] }
print "In the following order: #{places_in_order}"
