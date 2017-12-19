import XCTest
import OHHTTPStubs

class ExchangeRatesServiceTests: TestCase {
    
    private let urlString = "/stats/eurofxref/eurofxref-daily.xml"
    
    var service: ExchangeRatesService!
    
    override func setUp() {
        super.setUp()
        
        service = ServiceFactoryImpl.instance().exchangeRatesService()
    }
    
    func testFetchRatesRequestAndParsing() {
        // Given
        stub(condition: isPath(urlString)) { _ in
            return OHHTTPStubsResponse(
                fileAtPath: OHPathForFile("rates.xml", type(of: self))!,
                statusCode: 200,
                headers: ["Content-Type":"application/xml"]
            )
        }
        
        let callbackCalled = expectation(description: "callback is called")
        
        // When
        var expectedData: ExchangeRatesData?
        service.fetchRates ({ data in
            
            expectedData = data
            
            callbackCalled.fulfill()
            
        }, onError: { _ in })
        
        // Then
        waitForExpectations(timeout: timeout) { _ in
            if let expectedData = expectedData {
                let currencies = expectedData.currencies
                let usd = currencies?.first(where: { currency in
                    return currency.currencyType == .USD
                })
                XCTAssertTrue(usd?.rate.floatValue == 1.1806)
                
                let gbp = currencies?.first(where: { currency in
                    return currency.currencyType == .GBP
                })
                XCTAssertTrue(gbp?.rate.floatValue == 0.88253)
                
            } else {
                XCTFail()
            }
        }
    }
}
