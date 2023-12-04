def part1(input)
  total = 0

  input.each_line do |line|
    matches = line.match(/Card\s+(?<id>\d+): (?<winning_numbers>[^|]+) \| (?<numbers>.*)/)
    winning_numbers = matches[:winning_numbers].split().map(&:to_i)
    numbers = matches[:numbers].split().map(&:to_i)
    wins = winning_numbers.intersection(numbers)
    if wins.length > 0 then
      total += 2 ** (wins.length - 1)
    end
  end

  puts "part 1: #{total}"
end

def part2(input)
  total = 0
  copies = Hash.new(1)

  input.each_line do |line|
    matches = line.match(/Card\s+(?<id>\d+): (?<winning_numbers>[^|]+) \| (?<numbers>.*)/)

    id = matches[:id].to_i
    winning_numbers = matches[:winning_numbers].split().map(&:to_i)
    numbers = matches[:numbers].split().map(&:to_i)

    if !copies.has_key?(id) then
      copies[id] = 1
    end

    wins = winning_numbers.intersection(numbers)
    win_mul = copies[id]
    if wins.length > 0 then
      (id+1..id+wins.length).each do |n|
        copies[n] += 1 * win_mul
      end
    end
  end

  puts "part 2: #{copies.values.sum()}"
end

testInput = "Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11"

part1(testInput)
part1(File.read("day4.txt"))

part2(testInput)
part2(File.read("day4.txt"))
