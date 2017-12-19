import XCTest

class UserServiceTests: TestCase {
    
    var userService: UserService!
    
    override func setUp() {
        super.setUp()
        
        userService = UserServiceImpl(userDataStorage: MockUserDataStorageImpl())
    }
    
    func testInitialUser() {
        // Given
        let callbackCalled = expectation(description: "callback is called")
        
        // When
        var expectedUser: User?
        userService.currentUser { user in
            expectedUser = user
            callbackCalled.fulfill()
        }
        
        // then
        waitForExpectations(timeout: timeout) { _ in
            if let eurWallet = expectedUser?.wallet(with: .EUR) {
                XCTAssertTrue(eurWallet.currency.currencyType == .EUR)
                XCTAssertTrue(eurWallet.amount == 100)
            } else {
                XCTFail()
            }
            
            if let usdWallet = expectedUser?.wallet(with: .USD) {
                XCTAssertTrue(usdWallet.currency.currencyType == .USD)
                XCTAssertTrue(usdWallet.amount == 100)
            } else {
                XCTFail()
            }
            
            if let gbpWallet = expectedUser?.wallet(with: .GBP) {
                XCTAssertTrue(gbpWallet.currency.currencyType == .GBP)
                XCTAssertTrue(gbpWallet.amount == 100)
            } else {
                XCTFail()
            }
        }
    }
}
