import XCTest

class ExchangeMoneyServiceTests: TestCase {
    
    var service: ExchangeMoneyService!
    
    override func setUp() {
        super.setUp()
        
        service = ServiceFactoryImpl.instance().exchangeMoneyService()
    }
    
    func testExchangeWithUserIsCorrect() {
        // Given
        let currency = Currency(type: .GBP)
        currency?.rate = NSNumber(value: 0.88)
        
        let amount = NSNumber(value: 100)
        
        let wallet = Wallet(currency: currency, amount: amount) as Wallet
        
        let user = User(wallets: [wallet])
        
        let moneyAmount = NSNumber(value: 50)
        
        let sourceCurrency = Currency(type: .USD)
        sourceCurrency?.rate = NSNumber(value: 1.13)
        
        let targetCurrency = Currency(type: .EUR)
        targetCurrency?.rate = NSNumber(value: 1.0)
        
        let callbackCalled = expectation(description: "callback is called")
        
        // When
        var resultData: ExchangeMoneyData?
        
        service.exchange(with: user, moneyAmount: moneyAmount, sourceCurrency: sourceCurrency, targetCurrency: targetCurrency) { data in
            resultData = data
            callbackCalled.fulfill()
        }
        
        // Then
        waitForExpectations(timeout: timeout) { _ in
            if let resultData = resultData {
                XCTAssertTrue(resultData.sourceWallet.amount.doubleValue == -50.0)
                XCTAssertTrue(resultData.sourceWallet.currency.currencyType == .USD)
                XCTAssertTrue(resultData.sourceWallet.currency.rate.doubleValue == 1.1299999999999999)
                
                XCTAssertTrue(resultData.targetWallet.amount.doubleValue == 44.247787475585938)
                XCTAssertTrue(resultData.targetWallet.currency.currencyType == .EUR)
                XCTAssertTrue(resultData.targetWallet.currency.rate.doubleValue == 1.0)
            } else {
                XCTFail()
            }
        }
    }
    
    func testExchangeWalletIsCorrect() {
        // Given
        let currency = Currency(type: .GBP)
        currency?.rate = NSNumber(value: 0.88)
        
        let amount = NSNumber(value: 100)
        
        let wallet = Wallet(
            currency: currency,
            amount: amount
        )
        
        let targetCurrency = Currency(type: .EUR)
        targetCurrency?.rate = NSNumber(value: 1)
        
        let callbackCalled = expectation(description: "callback is called")
        
        // When
        var resultWallet: Wallet?
        
        service.exchangeWallet(wallet, targetCurrency: targetCurrency) { wallet in
            resultWallet = wallet
            callbackCalled.fulfill()
        }
        
        // Then
        waitForExpectations(timeout: timeout) { _ in
            if let resultWallet = resultWallet {
                XCTAssertTrue(resultWallet.amount.doubleValue == 113.63636016845703)
                XCTAssertTrue(resultWallet.currency.currencyType == .EUR)
                XCTAssertTrue(resultWallet.currency.rate.doubleValue == 1.1363636255264282)
            } else {
                XCTFail()
            }
        }
    }
    
    func testCurrencyConvertingIsCorrect() {
        // Given
        let sourceCurrency = Currency(type: .USD)
        sourceCurrency?.rate = NSNumber(value: 1.23)
        
        let targetCurrency = Currency(type: .GBP)
        targetCurrency?.rate = NSNumber(value: 0.74)
        
        let callbackCalled = expectation(description: "callback is called")
        
        // When
        var resultCurrency: Currency?
        
        service.convertedCurrency(
            withSourceCurrency: sourceCurrency,
            targetCurrency: targetCurrency) { currency in
                resultCurrency = currency
                callbackCalled.fulfill()
        }
        
        // Then
        waitForExpectations(timeout: timeout) { _ in
            if let resultCurrency = resultCurrency {
                XCTAssertTrue(resultCurrency.rate.doubleValue == 0.60162603855133057)
                XCTAssertTrue(resultCurrency.currencyType == targetCurrency?.currencyType)
            } else {
                XCTFail()
            }
        }
        
    }
    
}
