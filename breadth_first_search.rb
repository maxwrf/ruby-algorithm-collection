require 'json'
require_relative 'node'
require_relative 'graph'
require 'pry-byebug'

def breadth_first_search
  graph = Graph.new
  data = JSON.parse(File.read('data.json'))
  data["movies"].each do |movie|
    movie_node = Node.new(movie['title'])
    graph.add_node(movie_node)
    movie["cast"].each do |actor|
      actor_node = graph.get_node(actor)
      if actor_node.nil?
        actor_node = Node.new(actor)
        graph.add_node(actor_node)
      end
      movie_node.add_edge(actor_node)
    end
  end

  graph.set_end("Kevin Bacon")
  ending = graph.end

  graph.set_start("Rachel McAdams")
  start = graph.start

  queue = []

  start.searched = true

  queue << start

  while queue.length.positive?
    current = queue.shift
    if current == ending
      puts "Found: #{current.value}"
      break
    end
    current.edges.each do |neighbor|
      unless neighbor.searched
        neighbor.searched = true
        neighbor.parent = current
        queue << neighbor
      end
    end
  end

  path = []
  path << ending
  parent = ending.parent
  while parent.nil? == false
    path << parent
    parent = parent.parent
  end

  path.each_with_index do |node, index|
    if index == path.length - 1
      puts node.value
    else
      puts "#{node.value} -->"
    end
  end
end
