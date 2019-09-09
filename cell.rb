class Cell
  attr_reader :neighbors, :row, :col
  attr_accessor :f, :g, :h, :previous
  def initialize(row, col)
    @row = row
    @col = col
    @f = 0
    @g = 0
    @h = 0
    @neighbors = []
    @previous = nil
  end

  def show
    puts "Row: #{@row}, Col: #{@col}"
  end

  def add_neighbors(grid)
    @neighbors << grid[@row + 1, @col] if @row < grid.row_count - 1
    @neighbors << grid[@row - 1, @col] if @row > 0
    @neighbors << grid[@row, @col + 1] if @col < grid.column_count - 1
    @neighbors << grid[@row, @col - 1] if @col > 0
  end
end
