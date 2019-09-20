require 'geocoder'

def tsm
  sights = [[50.71, -50.23], [100.714, -100.234], [90.6, -90.9], [15.6, -4.9], [20.6, -20.9], [25.6, -30.9], [75.6, -40.9], [21.6, -20.9]]
  record_distance = Float::INFINITY
  best_ever = []
  order = sights.each_with_index.map { |_e, i| i }
  permutations = (1..sights.length).inject(:*) || 1
  count = 0

  loop do
    # looping over permutations!
    # result is going to be in miles!

    d = calc_distance(sights, order)
    if d < record_distance
      record_distance = d
      best_ever = order.clone
    end
    order = next_order(order)
    break if order == "STOP"

    count += 1
    percent = 100 * count / permutations.to_f
    puts "#{percent}% completed"
  end

  best_ever_dist = calc_distance(sights, best_ever)
  puts best_ever_dist
end

  private

  def calc_distance(sights, order)
    sum = 0

    order.each_with_index do |i, index|
      break if index == order.length - 1

      city_a = sights[i]
      city_b = sights[order[index + 1]]
      d = Geocoder::Calculations.distance_between(city_a, city_b)
      sum += d
    end
    return sum
  end

  def next_order(order)
    # lexicographic algorith
    # https://www.nayuki.io/page/next-lexicographical-permutation-algorithm
    # Step 1: Find the largest x such that P[x]<P[x+1]
    largest_i = -1
    order.each_with_index do |i, index|
      break if index == order.length - 1

      largest_i = i if i < order[index + 1]
    end
    return "STOP" if largest_i == -1

    # Step 2: Find the largest y such that P[x]<P[y]
    largest_j = -1
    order.each do |j|
      largest_j = j if largest_i < j
    end

    # Step 3: Swap P[x] and P[y]
    order = swap(order, largest_i, largest_j)

    # Step 4: Reverse P[x+1 .. n]
    end_array = order.slice!(order.index(largest_j) + 1..order.length - 1)
    end_array.reverse!
    order = order.concat(end_array)
  end

  def swap(order, largest_i, largest_j)
    save = order.index(largest_j)
    order[order.index(largest_i)] = largest_j
    order[save] = largest_i
    return order
  end

tsm()
