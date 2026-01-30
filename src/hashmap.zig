const std = @import("std");

// This algorithm was translated to Zig from the York University hash functions page.
// http://www.cse.yorku.ca/~oz/hash.html
//
// NOTE: In Zig a string doesn't have a special type but are just byte slices.
pub fn djb2(key: []const u8) u32 {
    var hash: u32 = 5381;
    var c: u8 = 0;
    var i: usize = 0;
    while (i < key.len) : (i += 1) {
        c = key[i];
        hash = ((hash << 5) +% hash) + c;
    }
    return hash;
}

// The entry struct, it represents each node in our bucket.
const Entry = struct {
    key: []const u8,
    value: []const u8,
    next: ?*Entry,
};

// The HashMap struct, holds the data we need.
const HashMap = struct {
    buckets: []?*Entry, // pointer to the bucket head
    capacity: usize, // amount of buckets
    size: usize, // amount of entries
    allocator: std.mem.Allocator, // needed to change the capacity
};
