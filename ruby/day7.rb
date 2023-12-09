@order = {
  'A' => 0xE, 'K' => 0xD, 'Q' => 0xC, 'J' => 0xB, 'T' => 0xA,
  '9' => 9,  '8' => 8,  '7' => 7,  '6' => 6,
  '5' => 5,  '4' => 4,  '3' => 3,  '2' => 2,
}

def rank(hand)
  sorted_chars = hand.chars.sort_by { |c| @order[c] }
  tally = sorted_chars.tally.to_a.sort_by { |x| x[1] }.reverse
  sorted_sum = hand.chars
    .map { |x| @order[x].to_s(16) }
    .join

  # five of a kind
  if tally[0][1] == 5 then
    return "7" + sorted_sum
  end

  # four of a kind
  if tally[0][1] == 4 then
    return "6" + sorted_sum
  end

  # full house
  if tally[0][1] == 3 and tally[1][1] == 2 then
    return "5" + sorted_sum
  end

  # three of a kind
  if tally[0][1] == 3 then
    return "4" + sorted_sum
  end

  # two pair
  if tally[0][1] == 2 and tally[1][1] == 2 then
    return "3" + sorted_sum
  end

  # one pair
  if tally[0][1] == 2 then
    return "2" + sorted_sum
  end

  # high car
  return "1" + sorted_sum
end

def part1(input)
  lines = input.each_line.map(&:split)
  hands, bids = lines.transpose
  bids = bids.map(&:to_i)
  sorted_hands = hands.each_with_index.sort_by { |h, i| rank(h) }

  winnings = 0
  sorted_hands.each_with_index do |hand, i|
    winnings += bids[hand[1]] * (i + 1)
  end
  puts "part 1: #{winnings}\n"
end

def rank_with_jokers(hand)
  sorted_chars = hand.chars.sort_by { |c| @order[c] }

  tally = sorted_chars
    .filter { |x| x != "J" }
    .tally.to_a
    .sort_by { |x| x[1] }
    .reverse

  sorted_sum = hand.chars
    .map { |x| x == "J" ? "1" : @order[x].to_s(16) }
    .join

  jokers = hand.count("J")
  first_count = tally.empty? ? 0 : tally[0][1]
  second_count = tally.length < 2 ? 0: tally[1][1]

  # five of a kind
  if first_count + jokers == 5 then
    return "7" + sorted_sum
  end

  # four of a kind
  if first_count + jokers == 4 then
    return "6" + sorted_sum
  end

  # full house
  if first_count + jokers == 3 and second_count == 2 then
    return "5" + sorted_sum
  end

  # three of a kind
  if first_count + jokers == 3 then
    return "4" + sorted_sum
  end

  # two pair
  if first_count == 2 and second_count == 2 then
    return "3" + sorted_sum
  end

  # one pair
  if first_count + jokers == 2 then
    return "2" + sorted_sum
  end

  # high car
  return "1" + sorted_sum
end

def part2(input)
  lines = input.each_line.map(&:split)
  hands, bids = lines.transpose
  bids = bids.map(&:to_i)
  sorted_hands = hands.each_with_index.sort_by { |h, i| rank_with_jokers(h) }
  # p sorted_hands

  winnings = 0
  sorted_hands.each_with_index do |hand, i|
    winnings += bids[hand[1]] * (i + 1)
  end
  puts "part 2: #{winnings}\n"
end

testInput = "32T3K 765
T55J5 684
KK677 28
KTJJT 220
QQQJA 483"

part1(testInput)
part1(File.read("day7.txt"))

part2(testInput)
part2(File.read("day7.txt"))
