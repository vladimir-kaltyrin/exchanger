import XCTest

class BalanceFormatterTests: TestCase {
    
    var formatter: BalanceFormatter!
    
    override func setUp() {
        super.setUp()
        
        formatter = FormatterFactoryImpl.instance().exchangeCurrencyInputFormatter()
    }

    func testFormatZero() {
        // Given
        let number = NSNumber(value: 0.0)
        let sign = BalanceFormatterSign.plus
        // When
        let data = formatter.formatNumber(number, sign: sign)
        // Then
        XCTAssertTrue(data?.number.floatValue == 0)
        XCTAssertTrue(data?.formattedString.string == "0")
        XCTAssertTrue(data?.string == "0")
    }
    
    func testWrongInput() {
        // Given
        let number = NSNumber(value: -25.5)
        let sign = BalanceFormatterSign.plus
        // When
        let data = formatter.formatNumber(number, sign: sign)
        // Then
        XCTAssertNil(data?.number)
        XCTAssertNil(data?.formattedString)
        XCTAssertNil(data?.string)
    }
    
    func testFormatPositiveNumber() {
        // Given
        let number = NSNumber(value: 25.5)
        let sign = BalanceFormatterSign.plus
        // When
        let data = formatter.formatNumber(number, sign: sign)
        // Then
        XCTAssertTrue(data?.number.floatValue == 25.5)
        XCTAssertTrue(data?.formattedString.string == "+25.5")
        XCTAssertTrue(data?.string == "+25.5")
    }

}
