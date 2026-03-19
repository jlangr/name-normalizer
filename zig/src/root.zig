//! By convention, root.zig is the root source file when making a library.
const std = @import("std");

const NameNormalizationError = error{
    MultipleCommas,
    OutOfMemory,
};

fn normalize(allocator: std.mem.Allocator, name: []const u8) NameNormalizationError![]const u8 {
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();
    const scratch = arena.allocator();

    var list = std.ArrayList([]const u8).empty;
    defer list.deinit(scratch);

    if (std.mem.count(u8, name, ",") > 1) {
        return NameNormalizationError.MultipleCommas;
    }

    const trimmed_name = std.mem.trim(u8, name, " \t");

    var left: []const u8 = trimmed_name;
    var right: []const u8 = "";
    if (std.mem.indexOf(u8, trimmed_name, ", ")) |idx| {
        left = trimmed_name[0..idx];
        right = trimmed_name[idx..];
    }

    var iter = std.mem.splitScalar(u8, left, ' ');
    while (iter.next()) |e| {
        if (e.len > 0) {
            try list.append(scratch, e);
        }
    }

    if (list.items.len > 1) {
        var result_list = std.ArrayList([]const u8).empty;
        defer result_list.deinit(scratch);

        try result_list.append(scratch, list.items[list.items.len - 1]);
        try result_list.append(scratch, ", ");
        try result_list.append(scratch, list.items[0]);

        const start = 1;
        const end = list.items.len - 1;
        for (start..end) |i| {
            try result_list.append(scratch, " ");
            try result_list.append(scratch, try initialize(scratch, list.items[i]));
        }

        try result_list.append(scratch, right);

        return try std.mem.join(allocator, "", result_list.items);
    }

    return trimmed_name;
}

fn initialize(allocator: std.mem.Allocator, name: []const u8) ![]const u8 {
    if (name.len == 0) return name;
    if (name.len == 1) return name;

    var result = try allocator.alloc(u8, 2);
    result[0] = name[0];
    result[1] = '.';

    return result;
}

test "returns empty string when empty" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    const actual = try normalize(allocator, "");

    try std.testing.expectEqualStrings("", actual);
}

test "returns single word name" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    const actual = try normalize(allocator, "Plato");

    try std.testing.expectEqualStrings("Plato", actual);
}

test "swaps first and last names" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    const actual = try normalize(allocator, "Haruki Murakami");

    try std.testing.expectEqualStrings("Murakami, Haruki", actual);
}

test "trims leading and trailing whitespaces" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    const actual = try normalize(allocator, "  Big Boi   ");

    try std.testing.expectEqualStrings("Boi, Big", actual);
}

test "initializes middle name" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    const actual = try normalize(allocator, "Henry David Thoreau");

    try std.testing.expectEqualStrings("Thoreau, Henry D.", actual);
}

test "does not initialize one letter middle name" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    const actual = try normalize(allocator, "Harry S Truman");

    try std.testing.expectEqualStrings("Truman, Harry S", actual);
}

test "initializes each of multiple middle names" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    const actual = try normalize(allocator, "Julia Scarlett Elizabeth Louis-Dreyfus");

    try std.testing.expectEqualStrings("Louis-Dreyfus, Julia S. E.", actual);
}

test "appends suffixes to end" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    const actual = try normalize(allocator, "Martin Luther King, Jr.");

    try std.testing.expectEqualStrings("King, Martin L., Jr.", actual);
}

test "returns an error when name contains two commas" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    const actual = normalize(allocator, "Thurston, Howell, III");

    try std.testing.expectError(NameNormalizationError.MultipleCommas, actual);
}
