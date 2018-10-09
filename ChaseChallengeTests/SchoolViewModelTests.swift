//
//  SchoolViewModelTests.swift
//  ChaseChallengeTests
//
//  Created by Ty Schultz on 10/9/18.
//  Copyright © 2018 Ty Schultz. All rights reserved.
//

import XCTest
@testable import ChaseChallenge
class SchoolViewModelTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLocationPrettyPrint() {
        let school = School(academicopportunities: "",
                            academicopportunitiesSecond: "",
                            attendance_rate: "",
                            borough: "",
                            city: "",
                            extracurricular_activities: "",
                            dbn: "1",
                            latitude: "",
                            location: "123 Main Street, Columbus Ohio (latitude, Longitude)",
                            longitude: "",
                            neighborhood: "",
                            overview_paragraph: "",
                            phone_number: "",
                            primary_address_line_1: "",
                            school_email: "",
                            school_name: "",
                            school_sports: "",
                            state_code: "",
                            subway: "",
                            total_students: "",
                            website: "",
                            zip: "")
        
        let schoolViewModel = SchoolViewModel(school: school, width: 100)
        
        XCTAssertTrue(schoolViewModel.location == "123 Main Street, Columbus Ohio ")
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
