def part1(input)
  lines = input.split("\n")
  dirs = lines[0]
  elements = lines[2..]
    .map { |x| x.scan(/[A-Z]+/) }
    .to_h { |x| [x[0], x[1..]] }

  current = 'AAA'
  steps = 0
  dirs.chars.cycle.each do |dir|
    steps += 1
    el = elements[current]
    current = dir == 'L' ? el[0] : el[1]
    if current == 'ZZZ' then
      break
    end
  end

  puts "part 1: #{steps}\n"
end

def gcd(a, b)
  rem = 1
  while rem != 0 do
    rem = a % b
    a = b
    b = rem
  end
  return a
end

def lcm(a, b)
  if a == 0 or b == 0 then
    return 0
  end
  return (a * b) / gcd(a, b)
end

def part2(input)
  lines = input.split("\n")
  dirs = lines[0]
  elements = lines[2..]
    .map { |x| x.scan(/[A-Z0-9]+/) }
    .to_h { |x| [x[0], x[1..]] }

  nodes = elements.keys
    .filter { |x| x.end_with?("A") }
    .map { |x| [x, 0] }

  done_nodes = []

  steps = 0
  dirs.chars.cycle.each do |dir|
    # steps += 1
    nodes.map! do |node|
      el = elements[node[0]]
      [dir == 'L' ? el[0] : el[1], node[1] + 1]
    end

    d, nodes = nodes.partition { |node| node[0].end_with?("Z") }
    if !d.empty?
      done_nodes.concat(d)
    end

    if nodes.empty? then
      break
    end
  end

  lcm = done_nodes
    .map { |x| x[1] }
    .reduce { |sum, x| lcm(x, sum) }

  puts "part 2: #{lcm}\n"
end

testInput = "\
LLR

AAA = (BBB, BBB)
BBB = (AAA, ZZZ)
ZZZ = (ZZZ, ZZZ)"

part1(testInput)
part1(File.read("day8.txt"))

testInput = "\
LR

11A = (11B, XXX)
11B = (XXX, 11Z)
11Z = (11B, XXX)
22A = (22B, XXX)
22B = (22C, 22C)
22C = (22Z, 22Z)
22Z = (22B, 22B)
XXX = (XXX, XXX)"

part2(testInput)
part2(File.read("day8.txt"))
