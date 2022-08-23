const std = @import("std");

const mem = std.mem;
const print = std.debug.print;

const input_file = @embedFile("../resources/8_input.txt");

const gpa = std.heap.GeneralPurposeAllocator(.{}){};
const allocator = gpa.allocator();

pub fn main() !void {
    var lines = mem.tokenize(u8, input_file, "\n");

    var count: u32 = 0;

    while (lines.next()) |line| {
        var line_it = mem.split(u8, line, " | ");
        _ = line_it.next();
        var output = mem.tokenize(u8, line_it.next().?, " \n");

        // print("output: {s}\n", .{output});

        while (output.next()) |v| {
            // print("v: {s}\n", .{v});
            if (v.len < 5 or v.len == 7) {
                count += 1;
            }
        }
    }

    print("{}", .{count});
}
