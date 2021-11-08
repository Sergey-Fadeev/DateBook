//
//  DateBookTests.swift
//  DateBookTests
//
//  Created by Sergey on 13.10.2021.
//

import XCTest
import RealmSwift

@testable import DateBook

class DateBookTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    
    func test_contains(){
        let selectedDate = Date()
        let anotherDate = CalendarHelper().plusMonth(date: selectedDate)
        
        let containsForSelectedDate: Bool = DataProvider().contains(_selectedDate: selectedDate)
        let containsForAnotherDate: Bool = DataProvider().contains(_selectedDate: anotherDate)
        print(containsForSelectedDate)
        print(containsForAnotherDate)
    }

    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
