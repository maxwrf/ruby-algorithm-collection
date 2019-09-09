require 'pry-byebug'
require_relative 'matrix'

def heuristic(a, b)
  (a.row - b.row).abs + (a.col - b.col).abs
end

grid = Grid.generate
grid.each { |cell| cell.add_neighbors(grid) }

path = []
open_set = []
closed_set = []
start = grid[0, 0]
ending = grid[grid.row_count - 1, grid.column_count - 1]
open_set << start

while open_set.empty? == false
  winner = 0
  # grid.each_with_index do |cell, row, col|
  #   cell.show
  # end

  open_set.each_with_index do |cell, index|
    cell.show
    winner = index if cell.f < open_set[winner].f
  end

  current = open_set[winner]

  break if current == ending

  closed_set << current
  open_set.delete(current)

  current.neighbors.each do |neighbor|
    unless closed_set.include?(neighbor)
      temp_g = current.g + 1
      if open_set.include?(neighbor)
        neighbor.g = temp_g if temp_g < neighbor.g
      else
        neighbor.g = temp_g
        open_set << neighbor
      end
      neighbor.h = heuristic(neighbor, ending)
      neighbor.f = neighbor.g + neighbor.h
      neighbor.previous = current
    end
  end

  # closed_set.each do |cell|
  #   cell.show
  # end
end

puts "DONE"
temp = current
path << temp
while temp.previous.nil? == false
  path << temp.previous
  temp = temp.previous
end

path.each(&:show)
