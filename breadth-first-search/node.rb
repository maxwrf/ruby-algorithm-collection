class Node
  attr_reader :value
  attr_accessor :edges, :searched, :parent
  def initialize(value)
    @value = value
    @edges = []
    @searched = false
    @parent = nil
  end

  def add_edge(node)
    @edges.push(node)
    node.edges.push(self)
  end
end
