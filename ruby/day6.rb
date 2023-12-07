def part1(input)
  lines = input.each_line.to_a
  times = lines[0].scan(/\d+/).map(&:to_i)
  distances = lines[1].scan(/\d+/).map(&:to_i)

  total = 1

  times.each_index do |race|
    time = times[race]
    dist = distances[race]
    ways_to_win = 0
    (0..time).each do |hold_time|
      traveled = hold_time * (time - hold_time)
      if traveled > dist then
        ways_to_win += 1
      end
    end
    total *= ways_to_win
  end

  puts "part 1: #{total}\n"
end

def part2(input)
  lines = input.each_line.to_a
  time = lines[0].scan(/\d+/).join.to_i
  dist = lines[1].scan(/\d+/).join.to_i

  ways_to_win = 0
  (0..time/2).each do |hold_time|
    traveled = hold_time * (time - hold_time)
    if traveled > dist then
      ways_to_win += 2
    end
  end

  if time.even? then
    ways_to_win -= 1
  end

  puts "part 2: #{ways_to_win}\n"
end

testInput = "Time:      7  15   30
Distance:  9  40  200"

part1(testInput)
part1(File.read("day6.txt"))

part2(testInput)
part2(File.read("day6.txt"))
