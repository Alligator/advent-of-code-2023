def parse_section(section)
  return section.split("\n")[1..].map { |x| x.split.map(&:to_i) }
end

def find(ranges, id)
  ranges.each do |range|
    dst_start, src_start, len = range
    if id >= src_start and id < src_start + len then
      return dst_start + (id - src_start)
    end
  end
  return id
end

def part1(input)
  sections = input.split("\n\n")
  seeds = sections[0].scan(/\d+/).map(&:to_i)
  range_groups = sections[1..].map { |x| parse_section(x) }

  locations = []
  seeds.each do |seed_id|
    id = seed_id
    range_groups.each do |ranges|
      id = find(ranges, id)
    end
    locations.push(id)
  end

  puts "part 1: #{locations.min}\n"
end

def part2(input)
  sections = input.split("\n\n")
  @seed_groups = sections[0].scan(/\d+/).map(&:to_i).each_slice(2).to_a
  range_groups = sections[1..].map { |x| parse_section(x) }

  def seed?(n)
    @seed_groups.any? { |seed_group| n >= seed_group[0] and n < (seed_group[0] + seed_group[1]) }
  end

  (0..1_000_000_000).each do |loc|
    current_id = loc
    range_groups.reverse_each do |ranges|
      ranges.each do |range|
        dst_start, src_start, len = range
        if current_id >= dst_start and current_id < dst_start + len then
          current_id = (current_id - dst_start) + src_start
          break
        end
      end
    end
    if seed?(current_id)
      puts "part 2: #{loc}\n"
      return
    end
  end

  puts "uh oh"
end

testInput = "seeds: 79 14 55 13

seed-to-soil map:
50 98 2
52 50 48

soil-to-fertilizer map:
0 15 37
37 52 2
39 0 15

fertilizer-to-water map:
49 53 8
0 11 42
42 0 7
57 7 4

water-to-light map:
88 18 7
18 25 70

light-to-temperature map:
45 77 23
81 45 19
68 64 13

temperature-to-humidity map:
0 69 1
1 0 69

humidity-to-location map:
60 56 37
56 93 4"

part1(testInput)
part1(File.read("day5.txt"))

part2(testInput)
part2(File.read("day5.txt"))
