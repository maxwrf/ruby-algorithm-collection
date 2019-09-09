require 'pry-byebug'
require_relative 'matrix'
require_relative 'astar'

rows = 5
cols = 5

grid = Grid.generate(rows, cols)
grid.each { |cell| cell.add_neighbors(grid) }

# default start shhould be start = [0, 0]
start = [0, 0]
# default ending should be ending = grid[grid.row_count - 1, grid.column_count - 1]
ending = grid[3, 2]

puts 'A*'
# prints out the shortest path
Astar.run(grid, start, ending)
