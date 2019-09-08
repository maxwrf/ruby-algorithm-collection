require 'matrix'
require_relative 'cell'
require 'pry-byebug'

class Grid
  def self.generate
    grid = Matrix.build(5, 5) { |row, col| Cell.new(row, col) }
  end
end
