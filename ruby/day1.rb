def part1(input)
  sum = 0
  input.each_line {|line|
    matches = line.scan(/\d/)
    num = (matches.first + matches.last).to_i
    sum += num
  }
  puts "part 1: #{sum}"
end

def part2(input)
  sum = 0
  i = 0
  input.each_line {|line|
    i += 1
    line = line
      .gsub("one", "o1ne")
      .gsub("two", "t2wo")
      .gsub("three", "t3hree")
      .gsub("four", "f4our")
      .gsub("five", "f5ive")
      .gsub("six", "s6ix")
      .gsub("seven", "s7even")
      .gsub("eight", "e8ight")
      .gsub("nine", "n9ine")

    matches = line.scan(/\d/)
    num = (matches.first + matches.last).to_i
    sum += num
  }
  puts "part 2: #{sum}"
end

testInput = "1abc2
pqr3stu8vwx
a1b2c3d4e5f
treb7uchet"

part1(testInput)
part1(File.read("day1.txt"))

part2("two1nine
eightwothree
abcone2threexyz
xtwone3four
4nineeightseven2
zoneight234
7pqrstsixteen")
part2(File.read("day1.txt"))
