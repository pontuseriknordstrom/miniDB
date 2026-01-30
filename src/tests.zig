const std = @import("std");
const expect = std.testing.expect;

// Importing local files
const hash = @import("hashmap.zig");

//--- Hashing function tests ---
test "empty string returns 5381 bytes" {
    const result = hash.djb2("");
    try expect(result == 5381);
}

test "hashing returns expected value" {
    const result = hash.djb2("thisisastring");
    try expect(result == 4073834321);
}

test "hashing works for all symbols" {
    const result = hash.djb2("%%189sja-");
    try expect(result == 812350556);
}

test "hashing is deterministic" {
    const result1 = hash.djb2("teststring");
    const result2 = hash.djb2("teststring");
    try expect(result1 == result2);
}

test "does it wrap correctly with long strings" {
    const result = hash.djb2("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
    try expect(result == 4255775019);
}
