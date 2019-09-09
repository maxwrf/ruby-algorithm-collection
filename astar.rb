class Astar
  def self.run(grid, start, ending)
    open_set = []
    closed_set = []
    open_set << start

    while open_set.empty? == false
      winner = 0

      open_set.each_with_index do |cell, index|
        winner = index if cell.f < open_set[winner].f
      end

      current = open_set[winner]

      break if current == ending

      closed_set << current
      open_set.delete(current)

      current.neighbors.each do |neighbor|
        current.show
        if !closed_set.include?(neighbor) && !neighbor.wall
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
    end
    if current == ending
      evaluate(current)
    else
      puts 'No solution'
    end
  end

  def self.heuristic(cell_a, cell_b)
    (cell_a.row - cell_b.row).abs + (cell_a.col - cell_b.col).abs
  end

  def self.evaluate(current)
    puts 'DONE'
    path = []
    temp = current
    path << temp
    while temp.previous.nil? == false
      path << temp.previous
      temp = temp.previous
    end

    path.each(&:show)
    puts path.length
  end
end
