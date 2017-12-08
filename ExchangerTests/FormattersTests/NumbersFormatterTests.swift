import XCTest

class NumbersFormatterTests: XCTestCase {
    
    var formatter: NumbersFormatter!
    
    override func setUp() {
        super.setUp()
        
        formatter = FormatterFactoryImpl.instance().numbersFormatter()
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
        XCTAssert(output == "")
    }
    
    func testInputIsAlphanumericString() {
        // Given
        let input = "qwertyuiopad12.54asdfghjkl.7.s.9zxcvbnm."
        // When
        let output = formatter.format(input)
        // Then
        XCTAssert(output == "12.5479")
    }
    
    func testInputIsNumberWithSeparator() {
        // Given
        let input = "1."
        // When
        let output = formatter.format(input)
        // Then
        XCTAssert(output == input)
    }
    
    func testInputDoesNotContainDigits() {
        // Given
        let input = "...qwertyuiopasdfghjklzxcvbnm..."
        // When
        let output = formatter.format(input)
        // Then
        XCTAssert(output == "")
    }
    
}
