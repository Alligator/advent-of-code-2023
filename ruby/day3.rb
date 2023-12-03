def part1(input)
  width = input.lines[0].chomp.length + 1
  height = input.lines.length

  symbol_positions = input
    .to_enum(:scan, /[^0-9\.\n]/)
    .map {
      pos = Regexp.last_match.begin(0)
      line_start = (pos / width) * width
      line_end = line_start + (width - 1)

      coords = []
      if pos > line_start then
        coords.push(pos - 1)         # left
        coords.push(pos - 1 - width) # top left
        coords.push(pos - 1 + width) # bottom left
      end

      if pos < line_end then
        coords.push(pos + 1)         # right
        coords.push(pos + 1 - width) # top right
        coords.push(pos + 1 + width) # bottom right
      end

      coords.push(pos - width) # top
      coords.push(pos + width) # bottom
    }
    .flatten

  numbers = input
    .to_enum(:scan, /\d+/)
    .map { {num: Regexp.last_match[0], pos: Regexp.last_match.offset(0)} }

  sum = 0
  numbers.each do |num|
    matching = symbol_positions
      .any? { |pos| pos >= num[:pos][0] and pos < num[:pos][1] }
    if matching then
      sum += num[:num].to_i
    end
  end

  puts "part 1: #{sum}\n"
end

def part2(input)
  width = input.lines[0].chomp.length + 1
  height = input.lines.length

  gear_positions = input
    .to_enum(:scan, /\*/)
    .map {
      pos = Regexp.last_match.begin(0)
      line_start = (pos / width) * width
      line_end = line_start + (width - 1)

      coords = []
      if pos > line_start then
        coords.push(pos - 1)         # left
        coords.push(pos - 1 - width) # top left
        coords.push(pos - 1 + width) # bottom left
      end

      if pos < line_end then
        coords.push(pos + 1)         # right
        coords.push(pos + 1 - width) # top right
        coords.push(pos + 1 + width) # bottom right
      end

      coords.push(pos - width) # top
      coords.push(pos + width) # bottom
    }

  numbers = input
    .to_enum(:scan, /\d+/)
    .map { {num: Regexp.last_match[0], pos: Regexp.last_match.offset(0)} }

  sum = 0
  gear_positions.each do |gear|
    matching_numbers = numbers.filter do |num|
      matches = gear
        .filter { |pos| pos >= num[:pos][0] and pos < num[:pos][1] }
      matches.length > 0
    end

    if matching_numbers.length > 1 then
      sum += matching_numbers
        .map { |x| x[:num].to_i }
        .inject(:*)
    end

  end
  puts "part 2: #{sum}\n"
end

testInput = <<EOS
467..114..
...*......
..35..633.
......#...
617*......
.....+.58.
..592.....
......755.
...$.*....
.664.598..
EOS

part1(testInput)
part1(File.read("day3.txt"))

part2(testInput)
part2(File.read("day3.txt"))
