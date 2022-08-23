const std = @import("std");

const mem = std.mem;
const print = std.debug.print;
const expect = std.testing.expect;

const input_file = @embedFile("../resources/8_input.txt");

var gpa = std.heap.GeneralPurposeAllocator(.{}){};
const allocator = gpa.allocator();

pub fn main() !void {
    var lines = mem.tokenize(u8, input_file, "\n");

    var count: u32 = 0;
    _ = count;

    var line = lines.next().?;

    var line_it = mem.split(u8, line, " | ");
    var input_it = mem.tokenize(u8, line_it.next().?, " ");
    var output_it = mem.tokenize(u8, line_it.next().?, " \n");
    _ = output_it;

    var input = std.ArrayList(Set).init(allocator);

    while (input_it.next()) |code| {
        // print("\n", .{});
        var item = Set.init(allocator);
        for (code) |segment| {
            // print("{}, ", .{segment});
            put(&item, segment);
        }
        input.append(item) catch unreachable;
    }

    // while (lines.next()) |line| {
    //     var line_it = mem.split(u8, line, " | ");
    //     var input_it = mem.tokenize(u8, line_it.next().?, " ");
    //     var output_it = mem.tokenize(u8, line_it.next().?, " \n");

    // print("output: {s}\n", .{output});

    // while (output.next()) |v| {
    //     // print("v: {s}\n", .{v});
    //     if (v.len < 5 or v.len == 7) {
    //         count += 1;
    //     }
    // }
    // }

    for (input.items) |item| {
        var it = item.keyIterator();
        while (it.next()) |v| {
            print("{}\n", .{v.*});
        }
        print("\n", .{});
    }
}

const Set = std.AutoHashMap(u8, void);

fn put(hm: *Set, v: u8) void {
    hm.put(v, {}) catch unreachable;
}

fn difference(left: *Set, right: *Set) Set {
    var result = Set.init(allocator);
    var left_it = left.keyIterator();
    while (left_it.next()) |v| {
        if (right.contains(v.*)) continue;

        put(&result, v.*);
    }

    return result;
}

test "difference" {
    var s1 = Set.init(allocator);
    put(&s1, 42);
    put(&s1, 69);

    var s2 = Set.init(allocator);
    put(&s2, 69);
    put(&s2, 99);

    const res = difference(&s1, &s2);
    try expect(res.contains(42));
    try expect(!res.contains(69));
    try expect(!res.contains(99));
}

// const Set = struct {
//     items: std.AutoHashMap(u8, void) = std.AutoHashMap(u8, void).init(allocator),

//     pub const Iterator = struct {
//         // hm_it: *const std.AutoHashMap(u8, void).KeyIterator,
//         items: *const []u8,

//         pub fn init(items: *std.HashMap) Iterator {
//             var _items = [*]u8 = .{};
//             for (items.)
//             return Iterator{};
//         }

//         pub fn next(it: *Iterator) ?u8 {
//             return it.*.hm_it.next();
//         }
//     };

//     pub fn iterator(self: *Set) Iterator {
//         var it = self.items.keyIterator();
//         return Iterator{ .hm_it = it };
//     }

//     pub fn add(self: *Set, item: u8) void {
//         self.*.items.put(item, {}) catch unreachable;
//     }

//     pub fn contains(self: *const Set, item: u8) bool {
//         return self.*.items.contains(item);
//     }

//     pub fn difference(self: *Set, other: *Set) Set {
//         var it = self.*.items.keyIterator();
//         var next = Set{};

//         while (it.next()) |item| {
//             if (!other.contains(item.*)) {
//                 next.add(item.*);
//             }
//         }

//         return next;
//     }
// };

// test "set add" {
//     var s: Set = Set{};
//     s.add(0);
//     s.add(1);
//     try expect(s.items.contains(0) and s.items.contains(1));
// }

// test "set contains" {
//     var s = Set{};
//     s.add(10);
//     s.add(42);
//     try expect(s.contains(10) and s.contains(42));
// }

// test "set difference" {
//     var s1 = Set{};
//     s1.add(42);
//     s1.add(69);

//     var s2 = Set{};
//     s2.add(69);
//     s2.add(99);

//     const res = s1.difference(&s2);
//     try expect(res.contains(42));
//     try expect(!res.contains(69));
//     try expect(!res.contains(99));
// }
