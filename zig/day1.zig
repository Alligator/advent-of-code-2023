const std = @import("std");

fn part1(input: []const u8) u64 {
    var split = std.mem.splitScalar(u8, input, '\n');
    var sum: u64 = 0;
    while (split.next()) |line| {
        var first: ?u8 = null;
        var last: ?u8 = null;
        for (line) |chr| {
            if (std.ascii.isDigit(chr)) {
                if (first == null) {
                    first = chr;
                }
                last = chr;
            }
        }
        if (first == null or last == null) {
            continue;
        }
        sum += (first.? - 48) * 10 + (last.? - 48);
    }
    return sum;
}

pub fn main() !void {
    // const testInput =
    //     \\1abc2
    //     \\pqr3stu8vwx
    //     \\a1b2c3d4e5f
    //     \\treb7uchet
    // ;

    // std.debug.print("part1 test: {d}\n", .{part1(testInput)});

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const alloc = gpa.allocator();

    var realInput = try std.fs.cwd().readFileAlloc(alloc, "day1.txt", 100000);
    defer alloc.free(realInput);

    std.debug.print("part1: {d}\n", .{part1(realInput)});
}
