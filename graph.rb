class Graph
  attr_reader :nodes, :graph
  attr_accessor :end, :start
  def initialize
    @nodes = []
    @graph = {}
    @start = nil
    @end = nil
  end

  def add_node(node)
    @nodes << node
    @graph[node.value] = node
  end

  def get_node(value)
    @graph[value]
  end

  def set_start(value)
    @start = @graph[value]
  end

  def set_end(value)
    @end = @graph[value]
  end
end
