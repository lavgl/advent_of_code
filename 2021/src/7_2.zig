const std = @import("std");

const fmt = std.fmt;
const mem = std.mem;
const math = std.math;
const expect = std.testing.expect;
const print = std.debug.print;

const input_file = @embedFile("../resources/7_input.txt");

var gpa = std.heap.GeneralPurposeAllocator(.{}){};
const allocator = gpa.allocator();

pub fn main() !void {
    var it = std.mem.tokenize(u8, input_file, ",\n");

    var input = std.ArrayList(u32).init(allocator);
    defer input.deinit();

    while (it.next()) |v| {
        input.append(try fmt.parseInt(u32, v, 10)) catch unreachable;
    }

    const min = mem.min(u32, input.items[0..]);
    const max = mem.max(u32, input.items[0..]);

    var density = std.AutoHashMap(u32, u64).init(allocator);

    for (input.items) |item| {
        var res = try density.getOrPut(item);
        if (res.found_existing) {
            res.value_ptr.* += 1;
        } else {
            res.value_ptr.* = 1;
        }
    }

    var minFuel: u64 = math.maxInt(u64);
    var i: u32 = min;
    while (i <= max) : (i += 1) {
        const fuel = try calculateFuel(&density, i);
        if (fuel < minFuel) {
            minFuel = fuel;
        }
    }

    print("{}\n", .{minFuel});
}

fn calculateFuel(density: anytype, i: u32) !u64 {
    var res: u64 = 0;
    var it = density.*.iterator();

    while (it.next()) |v| {
        if (v.key_ptr.* == i) continue;
        const left = math.min(v.key_ptr.*, i);
        const right = math.max(v.key_ptr.*, i);
        const dist = right - left;

        res += series(dist) * v.value_ptr.*;
    }

    return res;
}

fn series(n: u64) u64 {
    if (n == 0) {
        return 0;
    }
    return n + series(n - 1);
}

test "series" {
    try expect(series(0) == 0);
    try expect(series(1) == 1);
    try expect(series(2) == 3);
    try expect(series(5) == 15);
}
