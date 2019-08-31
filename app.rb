require_relative 'algorithm'
require_relative 'travel_matrix'

require 'pry-byebug'

coords = [[52.516266, 13.377775], [52.518623, 13.376198], [52.535152, 13.390206], [52.518898, 13.401797]]

# options are [driving, walking, bicycling, transit]
travel_mode = "driving"

travel_matrix = TravelMatrix.generate(coords, travel_mode)
results = GeneticAlgorithm.run(coords, travel_matrix)

# Best overall time
puts "The fastest time you can travel this route is: #{results[:record_distance]}"

# Best order of coordinates
print "In the following order: #{results[:best_ever]}"
