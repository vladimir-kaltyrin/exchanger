//
//  ExchangeMoneyServiceTests.swift
//  ExchangerTests
//
//  Created by Калтырин Владимир on 07.12.17.
//  Copyright © 2017 Vladimir Kaltyrin. All rights reserved.
//

import XCTest

class ExchangeMoneyServiceTests: XCTestCase {
    
    var serviceFactory: ServiceFactory!
    
    override func setUp() {
        super.setUp()
        
        self.serviceFactory = ServiceFactoryImpl()
        
        let service = serviceFactory.exchangeMoneyService()
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
