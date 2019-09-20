class GeneticAlgorithm
  def self.run(sights, travel_matrix)
    record_distance = Float::INFINITY
    best_ever = []
    order = sights.each_with_index.map { |_e, i| i }
    population = []
    population_size = 500
    fitness = []

    population_size.times do
      population << order.shuffle
    end

    100.times do
      results = calc_fitness(population, record_distance,
                             fitness, best_ever, travel_matrix)
      fitness = results[:fitness]
      if results[:record_distance] < record_distance
        best_ever = results[:best_ever]
        record_distance = results[:record_distance]
      end

      fitness = normalize_fitness(population, fitness)
      population = next_generation(population, fitness)
    end

    { record_distance: record_distance, best_ever: best_ever }
  end

  private

  def self.calc_fitness(population, record_distance,
                        fitness, best_ever, travel_matrix)
    current_record = Float::INFINITY
    current_best = []
    population.each_with_index do |orderpop, index|
      d = calc_distance(orderpop, travel_matrix)
      if d < record_distance
        record_distance = d
        best_ever = orderpop
      elsif d < current_record
        current_record = d
        current_best = population[index]
      end
      fitness[index] = 1 / (d**8 + 1).to_f
    end
    { fitness: fitness, record_distance: record_distance, best_ever: best_ever,
      current_record: current_record, current_best: current_best }
  end

  def self.normalize_fitness(population, fitness)
    sum = 0
    population.each_with_index do |_orderpop, index|
      sum += fitness[index]
    end
    fitness.each_with_index do |score, index|
      fitness[index] = score / sum
    end
  end

  def self.next_generation(population, fitness)
    new_population = []
    population.each_with_index do |_orderpop, index|
      order_a = pick_one(population, fitness)
      order_b = pick_one(population, fitness)
      order = cross_over(order_a, order_b)
      new_population[index] = order
      mutate(order, 0.01)
    end
    new_population
  end

  def self.cross_over(order_a, order_b)
    start = rand(order_a.length)
    ending = rand((start + 1)..order_a.length)
    new_order = order_a.slice(start..ending)
    order_b.each do |i|
      sight = i
      new_order.push(sight) if new_order.include?(sight) == false
    end
    new_order
  end

  def self.pick_one(population, fitness)
    index = 0
    r = rand

    while r.positive?
      r -= fitness[index]
      index += 1
    end
    index -= 1
    population[index]
  end

  def self.mutate(order, mutation_rate)
    order.length.times do
      if rand < mutation_rate
        index_a = rand(order.length)
        index_b = rand(order.length)
        order = swap(order, index_a, index_b)
      end
    end
  end

  def self.calc_distance(order, travel_matrix)
    sum = 0
    order.each_with_index do |i, index|
      break if index == order.length - 1

      d = travel_matrix[i, order[index + 1]]
      sum += d
    end
    sum
  end

  def self.swap(order, index_a, index_b)
    save = order[index_a]
    order[index_a] = order[index_b]
    order[index_b] = save
    order
  end

  private_class_method :swap, :calc_distance, :mutate, :pick_one, :cross_over,
                       :next_generation, :normalize_fitness, :calc_fitness
end
