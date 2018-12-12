//
//  DashboardInteractorTests.swift
//  incredibleMovieTests
//
//  Created by Sergio Garre on 12/12/2018.
//  Copyright © 2018 Sergio Garre. All rights reserved.
//

import XCTest
@testable import incredibleMovie

class DashboardInteractorTests: XCTestCase {

    var dashboardInteractor: DashboardInteractor!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        dashboardInteractor = DashboardInteractor()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        dashboardInteractor = nil
    }
    
    func testDatesFromServerAreCorrect() {
        // 1. Test that the service is returning data and there is no error
        let page = 3
        var popularMoviesResults: [Result]?
        var popularMoviesError: Error?
        
        let expectation = self.expectation(description: "Loading")
        
        dashboardInteractor.popularMovies(page: page) { (popularMovies, error) in
            
            popularMoviesResults = popularMovies?.results
            popularMoviesError = error
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 3, handler: nil)
        XCTAssertNil(popularMoviesError)
        XCTAssertNotNil(popularMoviesResults)
        
        // 2. Test that the format of the dates is correct
        if let popularMoviesResults = popularMoviesResults {
            let stringDatesAreValid = popularMoviesResults.allSatisfy({dashboardInteractor.isStringDateFormatValid($0.firstAirDate) == true})
            XCTAssertTrue(stringDatesAreValid)
        }
    }

    func testStringDatesHaveCorrectFormat() {
        // 1. Test if the function returns an invalid state given a unexpected string date format
        var unexpectedStringDateFormat = "2018-12-12T19:57:35.000Z" // "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        XCTAssertFalse(dashboardInteractor.isStringDateFormatValid(unexpectedStringDateFormat))
        unexpectedStringDateFormat = "12/12/18" // "dd/MM/yy"
        XCTAssertFalse(dashboardInteractor.isStringDateFormatValid(unexpectedStringDateFormat))
        unexpectedStringDateFormat = "12.12.18" // "dd.MM.yy"
        XCTAssertFalse(dashboardInteractor.isStringDateFormatValid(unexpectedStringDateFormat))
        unexpectedStringDateFormat = "12-Dec-2018" // "dd-MMM-yyyy"
        XCTAssertFalse(dashboardInteractor.isStringDateFormatValid(unexpectedStringDateFormat))
        unexpectedStringDateFormat = "Dec 12,2018" // MMM dd,yyyy"
        XCTAssertFalse(dashboardInteractor.isStringDateFormatValid(unexpectedStringDateFormat))
        
        // 2. Test if the function returns a valid state given an expected string date format
        let expectedStringDateFormat = "2018-12-12" // yyyy-MM-dd"
        XCTAssertTrue(dashboardInteractor.isStringDateFormatValid(expectedStringDateFormat))
    }
    
    func testDateRangeIsValid() {
        // 1. Test if the function returns an invalid state given a unexpected date range
        var unexpectedDateRange = DateRange(minimumYearDate: "2017", maximumYearDate: "1977")
        XCTAssertFalse(dashboardInteractor.isDateRangeValid(unexpectedDateRange))
        unexpectedDateRange = DateRange(minimumYearDate: "20177", maximumYearDate: "19777")
        XCTAssertFalse(dashboardInteractor.isDateRangeValid(unexpectedDateRange))
        unexpectedDateRange = DateRange(minimumYearDate: "10", maximumYearDate: "20")
        XCTAssertFalse(dashboardInteractor.isDateRangeValid(unexpectedDateRange))
        
        // 2. Test if the function returns a valid state given an expected date range
        let expectedDateRange = DateRange(minimumYearDate: "1964", maximumYearDate: "2018")
        XCTAssertTrue(dashboardInteractor.isDateRangeValid(expectedDateRange))
    }
    
    func testFilterStringDates() {
        // 1. Test if the function returns a nil state given a unexpected array of dates
        let unexpectedStringDateFormatArray = ["11/08/17", "2018-12-12T19:57:35.000Z", "05-Jan-2015", "Dec 12,2018"]
        let expectedDateRange = DateRange(minimumYearDate: "1930", maximumYearDate: "2018")
        var dateRangeResult = dashboardInteractor.filterStringDates(unexpectedStringDateFormatArray, byDateRange: expectedDateRange)
        XCTAssertNil(dateRangeResult)
        
        // 2. Test if the function returns not nil state given an expected array of dates
        let expectedStringDateFormatArray = ["2017-11-08", "1988-10-05", "2018-07-04", "2003-01-01"]
        dateRangeResult = dashboardInteractor.filterStringDates(expectedStringDateFormatArray, byDateRange: expectedDateRange)
        XCTAssertNotNil(dateRangeResult)
    }
    
    func testDateRange() {
        let defaultDateRangeType = (minDate: FilterResources.minimumYearNumberString, maxDate: FilterResources.maximumYearNumberString)
        
        // 1. Test if the function returns a default state given a unexpected array of dates
        let unexpectedStringDateFormatArray = ["11/08/17", "2018-12-12T19:57:35.000Z", "05-Jan-2015", "Dec 12,2018"]
        var dateRangeTypeResult = dashboardInteractor.getDateRange(from: unexpectedStringDateFormatArray)
        XCTAssertTrue(dateRangeTypeResult == defaultDateRangeType)
        
        // 2. Test if the function returns not default state given an expected array of dates
        var expectedStringDateFormatArray = ["2017-11-08", "1988-10-05", "2018-07-04", "2003-01-01"]
        dateRangeTypeResult = dashboardInteractor.getDateRange(from: expectedStringDateFormatArray)
        XCTAssertFalse(dateRangeTypeResult == defaultDateRangeType)
        
        // 3. Test if the function returns not default state given an expected array of dates and the range is correct
        // The years are equals
        expectedStringDateFormatArray = ["2018-11-08", "2018-10-05", "2018-07-04", "2018-01-01"]
        dateRangeTypeResult = dashboardInteractor.getDateRange(from: expectedStringDateFormatArray)
        XCTAssertFalse(dateRangeTypeResult == defaultDateRangeType)
        
        
        // 4. Test if the function returns not default state given an expected array of dates and the range is correct
        // The years are not equals
        expectedStringDateFormatArray = ["2017-11-08", "1988-10-05", "2018-07-04", "2003-01-01"]
        dateRangeTypeResult = dashboardInteractor.getDateRange(from: expectedStringDateFormatArray)
        XCTAssertFalse(dateRangeTypeResult == defaultDateRangeType)
    }
}
