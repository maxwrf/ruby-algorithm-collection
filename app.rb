require_relative 'breadth_first_search'

data = JSON.parse(File.read('data.json'))

actors = []
data['movies'].each do |movie|
  movie['cast'].each { |actor| actors << actor }
end

puts 'Pick two actors and see through what movies and actors they are connected!'
actors.each_with_index { |actor, index| puts "#{index + 1}. #{actor}" }
puts 'Provide index of actor 1'
print '>'
actor1 = actors[gets.chomp.to_i - 1]
puts 'Provide index of actor 2'
print '>'
actor2 = actors[gets.chomp.to_i - 1]

breadth_first_search(data, actor1, actor2)
