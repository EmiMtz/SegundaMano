//
//  MarketPriceTests.swift
//  MarketPriceTests
//
//  Created by Emiliano Alfredo Martinez Vazquez on 06/04/21.
//

import XCTest
@testable import MarketPrice

class MarketPriceTests: XCTestCase {
    let prueba = HistoricalPresenter()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let expectedResult = Float(1.218)
        
        let parametros = HistoricalParameters()
        parametros.symbol = "EUR,USD"
        
        prueba.loadHistorical(parametros: parametros)
        
        XCTAssertEqual(1.218, expectedResult)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
