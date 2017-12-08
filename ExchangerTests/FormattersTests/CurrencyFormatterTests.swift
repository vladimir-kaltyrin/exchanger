import XCTest

class CurrencyFormatterTests: XCTestCase {
    
    var formatter: CurrencyFormatter!
    
    override func setUp() {
        super.setUp()
        
        formatter = FormatterFactoryImpl.instance().currencyFormatter()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testUSDIsConvertedCorrectly() {
        checkCurrencyStringIsConvertedCorrectly(string: "USD", expectedType: .USD)
    }
    
    func testEURIsConvertedCorrectly() {
        checkCurrencyStringIsConvertedCorrectly(string: "EUR", expectedType: .EUR)
    }
    
    func testGBPIsConvertedCorrectly() {
        checkCurrencyStringIsConvertedCorrectly(string: "GBP", expectedType: .GBP)
    }
    
    func testInvalidCurrencyStringIsConvertedCorrectly() {
        checkCurrencyStringIsConvertedCorrectly(string: "RUB", expectedType: .notFound)
    }
    
    func testUSDSignIsConvertedCorrectly() {
        checkCurrencySignIsConvertedCorrectly(type: .USD, expectedString: "$")
    }
    
    func testEURSignIsConvertedCorrectly() {
        checkCurrencySignIsConvertedCorrectly(type: .EUR, expectedString: "€")
    }
    
    func testGBPSignIsConvertedCorrectly() {
        checkCurrencySignIsConvertedCorrectly(type: .GBP, expectedString: "£")
    }
    
    func testUSDCodeIsConvertedCorrectly() {
        checkCurrencyCodeIsConvertedCorrectly(type: .USD, expectedString: "USD")
    }
    
    func testEURCodeIsConvertedCorrectly() {
        checkCurrencyCodeIsConvertedCorrectly(type: .EUR, expectedString: "EUR")
    }
    
    func testGBPCodeIsConvertedCorrectly() {
        checkCurrencyCodeIsConvertedCorrectly(type: .GBP, expectedString: "GBP")
    }
    
    // MARK: - Private
    
    private func checkCurrencyStringIsConvertedCorrectly(string: String, expectedType: CurrencyType) {
        // Given
        let currencyString = string
        // When
        let type = formatter.currencyType(from: currencyString)
        // Then
        if case type = expectedType {
            XCTAssertTrue(true)
        } else {
            XCTFail()
        }
    }
    
    private func checkCurrencySignIsConvertedCorrectly(type: CurrencyType, expectedString: String) {
        // Given
        let currencyType = type
        // When
        let sign = formatter.toSignString(currencyType)
        // Then
        XCTAssertTrue(sign == expectedString)
    }
    
    private func checkCurrencyCodeIsConvertedCorrectly(type: CurrencyType, expectedString: String) {
        // Given
        let currencyType = type
        // When
        let code = formatter.toCodeString(currencyType)
        // Then
        XCTAssertTrue(code == expectedString)
    }

}
