# notes

whoops i only started writing these on day 7.

before this i had written maybe 20 lines of ruby ever.

## day 1

`string.scan` made part 1 very easy. very useful method

part 2 was surprisingly tricky for day 1. at first i replaced the numbers-as-strings with numbers, but if two numbers are mashed together (e.g. "eightwo") the "t" gets eaten by the first number and the "two" is never found. i fixed that by leaving the letters, but sneaking a number in there and using the code from part 1.

## day 2

the trickiest part of this was the parsing, mostly because i'm new to ruby.

## day 3

did this by making an array of co-ords around each symbol and, for each number, checking if any part of it matches one.

part 2 wasn't bad, i just limited which symbols are looked for and flipped the loop: for each symbol, check if two numbers are around it.

## day 4

another one where most of the effort was parsing. part 1 was basically `winning_numbers.intersection(numbers)` then count the points.

part 2 felt like it was taunting you to do the dumb thing and actually copy the scratchcards. i kept a hashmap of which cards are copied and sum the values to get the total.

## day 5

oh.

even part 1 took me a while to write. the numbers being `[destination, source, length]` instead of `[source, destination, length]` really got me in knots.

my desk has 3 pieces of paper covered in scrawl about part 2 and yet, i couldn't figure out the smart solution. i'm pretty sure you have to collapse all the ranges together, splitting them where necessary. 

the naive solution would be to iterate over every seed, which is too slow. instead i iterate through the first billion locations walking backwards through the layers and checking if the resulting seed is valid. it takes about three minutes, whatever.

## day 6

clearly part 2 is trying to break your part 1 solution. my part 2 is still quite naive (it checks every answer) but i noticed you only have to check up to time/2. after that, the distances are the same in reverse order.

## day 7

i enjoyed this one.

i wanted to find a single ranking that handled both the hand type and the highest card. i did that by mapping each card to a hex digit, then adding the type (four of a kind etc) to the front, so it took precedence.

part 2 was pretty nice too. i could just count the jokers and add them in for each case (e.g. three cards + two jokers = five of a kind).
