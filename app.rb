require_relative 'tree'
require_relative 'node'
require 'pry-byebug'

# create
tree = Tree.new

# we can add as many values / nodes to the tree as we want
# (if a value already exists it is not added)
10.times do
  tree.add_value(rand(100))
end

# the tree can be traversed (all values are printed in ascending order)
tree.traverse

# we can search for a specific value / node in the tree
# returns node object if found
puts tree.search(2)
