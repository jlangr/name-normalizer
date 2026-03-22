//! By convention, root.zig is the root source file when making a library.
const std = @import("std");

// Increment this when all currently running tests are passing successfully.
// Max tests: 9
const run_tests = 1;

const NameNormalizationError = error{
    MultipleCommas,
};

fn normalize(allocator: std.mem.Allocator, name: []const u8) ![]const u8 {
    // First things first: If the format is invalid, we are out ...
    if (std.mem.count(u8, name, ",") > 1) {
        return NameNormalizationError.MultipleCommas;
    }

    var scratch_arena = std.heap.ArenaAllocator.init(allocator);
    defer scratch_arena.deinit();
    const scratch_space = scratch_arena.allocator();

    const trimmed_name = std.mem.trim(u8, name, " \t");

    var actual_name: []const u8 = trimmed_name;
    var name_suffix: []const u8 = "";
    if (std.mem.indexOf(u8, trimmed_name, ", ")) |idx| {
        actual_name = trimmed_name[0..idx];
        name_suffix = trimmed_name[idx..];
    }

    // Split the name into its individual parts
    var name_parts = try std.ArrayList([]const u8).initCapacity(scratch_space, 8);
    defer name_parts.deinit(scratch_space);

    var iter = std.mem.splitScalar(u8, actual_name, ' ');
    while (iter.next()) |e| {
        if (e.len > 0) {
            try name_parts.append(scratch_space, e);
        }
    }

    if (name_parts.items.len <= 1) {
        return trimmed_name;
    }

    // We need space for all name parts plus the spacing inbetween plus the suffix, so basically len(name_parts)*2
    var resulting_name_parts = try std.ArrayList([]const u8).initCapacity(scratch_space, name_parts.items.len * 2);
    defer resulting_name_parts.deinit(scratch_space);

    // Input name format: <first_name> <middle_name>... <last_name>
    // Wanted result format: <last_name>, <first_name> <initialized_middle_name>...

    // Collect the last name and the first name
    try resulting_name_parts.append(scratch_space, name_parts.items[name_parts.items.len - 1]);
    try resulting_name_parts.append(scratch_space, ", ");
    try resulting_name_parts.append(scratch_space, name_parts.items[0]);

    // Collect and transform the middle names
    for (1..name_parts.items.len - 1) |i| {
        try resulting_name_parts.append(scratch_space, " ");
        try resulting_name_parts.append(scratch_space, try initialize(scratch_space, name_parts.items[i]));
    }

    // Don't forget the suffix
    if (name_suffix.len > 0) {
        try resulting_name_parts.append(scratch_space, name_suffix);
    }

    return try std.mem.join(allocator, "", resulting_name_parts.items);
}

fn initialize(allocator: std.mem.Allocator, name: []const u8) ![]const u8 {
    if (name.len < 2) return name;

    var result = try allocator.alloc(u8, 2);
    result[0] = name[0];
    result[1] = '.';

    return result;
}

test "returns empty string when empty" {
    if (run_tests < 1) return error.SkipZigTest;

    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    const actual = try normalize(allocator, "");

    try std.testing.expectEqualStrings("", actual);
}

test "returns single word name" {
    if (run_tests < 2) return error.SkipZigTest;

    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    const actual = try normalize(allocator, "Plato");

    try std.testing.expectEqualStrings("Plato", actual);
}

test "swaps first and last names" {
    if (run_tests < 3) return error.SkipZigTest;

    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    const actual = try normalize(allocator, "Haruki Murakami");

    try std.testing.expectEqualStrings("Murakami, Haruki", actual);
}

test "trims leading and trailing whitespaces" {
    if (run_tests < 4) return error.SkipZigTest;

    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    const actual = try normalize(allocator, "  Big Boi   ");

    try std.testing.expectEqualStrings("Boi, Big", actual);
}

test "initializes middle name" {
    if (run_tests < 5) return error.SkipZigTest;

    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    const actual = try normalize(allocator, "Henry David Thoreau");

    try std.testing.expectEqualStrings("Thoreau, Henry D.", actual);
}

test "does not initialize one letter middle name" {
    if (run_tests < 6) return error.SkipZigTest;

    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    const actual = try normalize(allocator, "Harry S Truman");

    try std.testing.expectEqualStrings("Truman, Harry S", actual);
}

test "initializes each of multiple middle names" {
    if (run_tests < 7) return error.SkipZigTest;

    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    const actual = try normalize(allocator, "Julia Scarlett Elizabeth Louis-Dreyfus");

    try std.testing.expectEqualStrings("Louis-Dreyfus, Julia S. E.", actual);
}

test "appends suffixes to end" {
    if (run_tests < 8) return error.SkipZigTest;

    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    const actual = try normalize(allocator, "Martin Luther King, Jr.");

    try std.testing.expectEqualStrings("King, Martin L., Jr.", actual);
}

test "returns an error when name contains two commas" {
    if (run_tests < 9) return error.SkipZigTest;

    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    const actual = normalize(allocator, "Thurston, Howell, III");

    try std.testing.expectError(NameNormalizationError.MultipleCommas, actual);
}
