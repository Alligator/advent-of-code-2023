def part1(input)
  total = 0
  values = input.each_line do |line|
    history = line.scan(/-?\d+/).map(&:to_i)
    stack = [history]
    loop do
      diffs = stack.last
        .each_cons(2)
        .map { |x| x[1] - x[0] }
      stack.push(diffs)
      if diffs.all?(0) then
        break
      end
    end

    n = 0
    stack.reverse_each do |seq|
      n = seq.last + n
    end

    total += n
  end
  puts "part 1: #{total}\n"
end

def part2(input)
  total = 0
  values = input.each_line do |line|
    history = line.scan(/-?\d+/).map(&:to_i)
    stack = [history]
    loop do
      diffs = stack.last
        .each_cons(2)
        .map { |x| x[1] - x[0] }
      stack.push(diffs)
      if diffs.all?(0) then
        break
      end
    end

    n = 0
    stack.reverse_each do |seq|
      n = seq.first - n
    end

    total += n
  end
  puts "part 2: #{total}\n"
end


testInput = "\
0 3 6 9 12 15
1 3 6 10 15 21
10 13 16 21 30 45"

part1(testInput)
part1(File.read("day9.txt"))

part2(testInput)
part2(File.read("day9.txt"))
