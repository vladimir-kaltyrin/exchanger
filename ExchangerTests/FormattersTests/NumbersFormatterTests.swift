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
    
    func testEmptyInput() {
        // Given
        let input = ""
        // When
        let output = formatter.format(input)
        // Then
        XCTAssert(output == "")
    }
    
    func testInvalidInput() {
        // Given
        let input = "qwertyuiopad12.54asdfghjkl.5..s.4zxcvbnm."
        // When
        let output = formatter.format(input)
        // Then
        XCTAssert(output == "12.5454")
    }
    
}
