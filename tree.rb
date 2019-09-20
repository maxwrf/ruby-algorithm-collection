require_relative 'node'

class Tree
  attr_reader :root
  def initialize
    @root = nil
  end

  def add_value(value)
    node = Node.new(value)
    if @root.nil?
      @root = node
    else
      @root.add_node(node)
    end
  end

  def traverse
    @root.visit
  end

  def search(value)
    @root.search(value)
  end
end
