#import <XCTest/XCTest.h>
#import "CurrencyFormatter.h"

@interface CurrencyFormatterTests : XCTestCase

@end

@implementation CurrencyFormatterTests

- (void)testMappingCurrencyTypeUSDtoString {
    // Given
    CurrencyType type = CurrencyTypeUSD;
    // When
    NSString *string = [CurrencyFormatter toString:type];
    // Then
    XCTAssertEqual(string, @"USD");
}

- (void)testMappingCurrencyTypeJPYtoString {
    // Given
    CurrencyType type = CurrencyTypeJPY;
    // When
    NSString *string = [CurrencyFormatter toString:type];
    // Then
    XCTAssertEqual(string, @"JPY");
}

@end
