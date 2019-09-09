require 'matrix'
require_relative 'cell'
require 'pry-byebug'

class Grid
  def self.generate(rows, cols)
    grid = Matrix.build(rows, cols) { |row, col| Cell.new(row, col) }
  end
end
