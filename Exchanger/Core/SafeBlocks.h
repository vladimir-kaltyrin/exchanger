#define executeIfNotNil(block, ...) if (block != nil) { block(__VA_ARGS__); }
