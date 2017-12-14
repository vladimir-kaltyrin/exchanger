// ObjectiveSugar

#import <ObjectiveSugar/ObjectiveSugar.h>

// @weakify, @strongify

#import "EXTScope.h"

// Safe block syntax

#define safeBlock(block, ...) if (block != nil) { block(__VA_ARGS__); }

// Type Inference

#define let __auto_type const
#define var __auto_type
