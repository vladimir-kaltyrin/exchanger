import XCTest

class BalanceFormatterTests: TestCase {
    
    var formatter: BalanceFormatter!
    
    override func setUp() {
        super.setUp()
        
        let locale = Locale(identifier: "en_US")
        
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = locale
        
        let numberFilterFormatter = NumberFilterFormatterImpl(
            numberFormatter: numberFormatter
        )
        
        formatter = BalanceFormatterImpl(
            primaryPart: nil,
            secondaryPart: nil,
            formatterStyle: .hundredths,
            numberFilterFormatter: numberFilterFormatter,
            locale: locale
        )
    }

    func testPlusFormatWithZeroIsCorrect() {
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
    
    func testMinusFormatWithZeroIsCorrect() {
        // Given
        let number = NSNumber(value: 0.0)
        let sign = BalanceFormatterSign.minus
        // When
        let data = formatter.formatNumber(number, sign: sign)
        // Then
        XCTAssertTrue(data?.number.floatValue == 0)
        XCTAssertTrue(data?.formattedString.string == "0")
        XCTAssertTrue(data?.string == "0")
    }
    
    func testMinusFormatWithoutSignIsCorrect() {
        // Given
        let number = NSNumber(value: 0.0)
        let sign = BalanceFormatterSign.none
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
    
    func testPlusFormatWithPositiveIntegerNumberIsCorrect() {
        // Given
        let number = NSNumber(value: 25)
        let sign = BalanceFormatterSign.plus
        // When
        let data = formatter.formatNumber(number, sign: sign)
        // Then
        XCTAssertTrue(data?.number.floatValue == 25)
        XCTAssertTrue(data?.formattedString.string == "+25")
        XCTAssertTrue(data?.string == "+25")
    }
    
    func testPlusFormatWithPositiveFloatNumberIsCorrect() {
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
    
    func testPlusFormatWithNegativeIntegerNumberIsCorrect() {
        // Given
        let number = NSNumber(value: 25)
        let sign = BalanceFormatterSign.minus
        // When
        let data = formatter.formatNumber(number, sign: sign)
        // Then
        XCTAssertTrue(data?.number.floatValue == 25)
        XCTAssertTrue(data?.formattedString.string == "-25")
        XCTAssertTrue(data?.string == "-25")
    }
    
    func testPlusFormatWithNegativeFloatNumberIsCorrect() {
        // Given
        let number = NSNumber(value: 25.5)
        let sign = BalanceFormatterSign.minus
        // When
        let data = formatter.formatNumber(number, sign: sign)
        // Then
        XCTAssertTrue(data?.number.floatValue == 25.5)
        XCTAssertTrue(data?.formattedString.string == "-25.5")
        XCTAssertTrue(data?.string == "-25.5")
    }
    
    func testMinusFormatWithNegativeIntegerNumberIsCorrect() {
        // Given
        let number = NSNumber(value: -25)
        let sign = BalanceFormatterSign.minus
        // When
        let data = formatter.formatNumber(number, sign: sign)
        // Then
        XCTAssertTrue(data?.number.floatValue == 25)
        XCTAssertTrue(data?.formattedString.string == "-25")
        XCTAssertTrue(data?.string == "-25")
    }
    
    func testMinusFormatWithNegativeFloatNumberIsCorrect() {
        // Given
        let number = NSNumber(value: -25.5)
        let sign = BalanceFormatterSign.minus
        // When
        let data = formatter.formatNumber(number, sign: sign)
        // Then
        XCTAssertTrue(data?.number.floatValue == 25.5)
        XCTAssertTrue(data?.formattedString.string == "-25.5")
        XCTAssertTrue(data?.string == "-25.5")
    }
    
    func testMinusFormatWithPositiveIntegerNumberIsCorrect() {
        // Given
        let number = NSNumber(value: 25)
        let sign = BalanceFormatterSign.minus
        // When
        let data = formatter.formatNumber(number, sign: sign)
        // Then
        XCTAssertTrue(data?.number.floatValue == 25)
        XCTAssertTrue(data?.formattedString.string == "-25")
        XCTAssertTrue(data?.string == "-25")
    }
    
    func testMinusFormatWithPositiveFloatNumberIsCorrect() {
        // Given
        let number = NSNumber(value: 25.5)
        let sign = BalanceFormatterSign.minus
        // When
        let data = formatter.formatNumber(number, sign: sign)
        // Then
        XCTAssertTrue(data?.number.floatValue == 25.5)
        XCTAssertTrue(data?.formattedString.string == "-25.5")
        XCTAssertTrue(data?.string == "-25.5")
    }
}
