class Cell
  attr_reader :neighbors, :row, :col
  attr_accessor :f, :g, :h, :previous, :wall
  def initialize(row, col)
    @row = row
    @col = col
    @f = 0
    @g = 0
    @h = 0
    @neighbors = []
    @previous = nil

    if rand < 0.3
      @wall = true
    else
      @wall = false
    end
  end

  def show
    puts "Row: #{@row}, Col: #{@col}, Wall: #{@wall}, f:#{@f}, g:#{@g}, h:#{@h}"
  end

  def add_neighbors(grid)
    @neighbors << grid[@row + 1, @col] if @row < grid.row_count - 1
    @neighbors << grid[@row - 1, @col] if @row > 0
    @neighbors << grid[@row, @col + 1] if @col < grid.column_count - 1
    @neighbors << grid[@row, @col - 1] if @col > 0
    @neighbors << grid[@row - 1, @col - 1] if @col > 0 && @row > 0
    @neighbors << grid[@row + 1, @col - 1] if @row < grid.row_count - 1 && @col > 0
    @neighbors << grid[@row - 1, @col + 1] if @row > 0 && @col < grid.column_count - 1
    @neighbors << grid[@row + 1, @col + 1] if @row < grid.row_count - 1 && @col < grid.column_count - 1
  end
end
