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
    
    func testImputIsEmptyString() {
        // Given
        let input = ""
        // When
        let output = formatter.format(input)
        // Then
        XCTAssert(output == "")
    }
    
    func testImputIsAlphanumericString() {
        // Given
        let input = "qwertyuiopad12.54asdfghjkl.7..s.9zxcvbnm."
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
    
    func testInputIsOnlySeparator() {
        // Given
        let input = "..."
        // When
        let output = formatter.format(input)
        // Then
        XCTAssert(output == "")
    }
    
}
