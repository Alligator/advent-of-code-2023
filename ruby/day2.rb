def read_game(line)
  # trim off "Game "
  l = line[5..]

  # grab the id
  m = l.match(/\d+/)
  id = m[0].to_i
  l = m.post_match

  # trim off ": "
  l = l[2..]

  # read each thingy
  sets = l.split(';').map{|s| s.strip}

  all_draws = []
  sets.each do |set|
    draws = set.scan(/(\d+) (blue|red|green)/)
    draws.each do |draw|
      count = draw[0].to_i
      colour = draw[1].to_sym
      all_draws.push([count, colour])
    end
  end

  return id, all_draws
end

def part1(input)
  sum = 0

  input.each_line do |line|
    max_colour_count = {red: 0, green: 0, blue: 0}

    id, draws = read_game(line)
    draws.each do |(count, colour)|
      if count > max_colour_count[colour] then
        max_colour_count[colour] = count
      end
    end

    game_possible = case
      when max_colour_count[:red] > 12
        false
      when max_colour_count[:green] > 13
        false
      when max_colour_count[:blue] > 14
        false
      else true
    end

    if game_possible then
      sum += id
    end
  end

  puts "part 1: #{sum}"
end

def part2(input)
  sum = 0

  input.each_line do |line|
    max_colour_count = {red: 0, green: 0, blue: 0}

    id, draws = read_game(line)
    draws.each do |(count, colour)|
      if count > max_colour_count[colour] then
        max_colour_count[colour] = count
      end
    end

    sum += max_colour_count.values.inject(:*)
  end

  puts "part 2: #{sum}"
end

testInput = "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green"

part1(testInput)
part1(File.read("day2.txt"))

part2(testInput)
part2(File.read("day2.txt"))
