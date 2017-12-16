import XCTest

class NumbersFormatterTests: XCTestCase {
    
    var formatter: NumbersFormatter!
    
    override func setUp() {
        super.setUp()

        formatter = FormatterFactoryImpl.instance().numbersFormatter()
        formatter.setLocale(Locale(identifier: "en_US"))
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testInputIsEmptyString() {
        // Given
        let input = ""
        // When
        let output = formatter.format(input)
        // Then
        XCTAssert(output.string == "0")
        XCTAssert(output.number == 0)
    }
    
    func testInputIsAlphanumericString() {
        // Given
        let input = "qwertyuiopad12.54asdfghjkl.7.s.9zxcvbnm."
        // When
        let output = formatter.format(input)
        // Then
        XCTAssert(output.string == "12.5479")
        XCTAssert(output.number == 12.5479)
    }
    
    func testInputIsNumberWithSeparator() {
        // Given
        let input = "1."
        // When
        let output = formatter.format(input)
        // Then
        XCTAssert(output.string == input)
        XCTAssert(output.number == 1)
    }
    
    func testInputDoesNotContainDigits() {
        // Given
        let input = "...qwertyuiopasdfghjklzxcvbnm..."
        // When
        let output = formatter.format(input)
        // Then
        XCTAssert(output.string == "0")
        XCTAssert(output.number == 0)
    }
    
    func testInputContainsoOnlyLeadingZerosAtBeginning() {
        // Given
        let input = "000"
        // When
        let output = formatter.format(input)
        // Then
        XCTAssert(output.string == "0")
        XCTAssert(output.number == 0)
    }
    
    func testInputContainsLeadingZerosAtBeginning() {
        // Given
        let input = "0057.7"
        // When
        let output = formatter.format(input)
        // Then
        XCTAssert(output.string == "57.7")
        XCTAssert(output.number == 57.7)
    }
    
}
