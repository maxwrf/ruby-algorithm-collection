class Node
  attr_reader :value, :left, :right
  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end

  def add_node(node)
    if node.value < @value
      if @left.nil?
        @left = node
      else
        @left.add_node(node)
      end
    elsif node.value > @value
      if @right.nil?
        @right = node
      else
        @right.add_node(node)
      end
    end
  end

  def search(value)
    if value == @value
      return self
    elsif value < @value && @left.nil? == false
      return @left.search(value)
    elsif value > @value && @right.nil? == false
      return @right.search(value)
    end

    nil
  end

  def visit
    @left.visit unless @left.nil?
    puts value
    @right.visit unless @right.nil?
  end
end
