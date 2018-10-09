//
//  MasterViewControllerTests.swift
//  ChaseChallengeTests
//
//  Created by Ty Schultz on 10/9/18.
//  Copyright © 2018 Ty Schultz. All rights reserved.
//

import XCTest
@testable import ChaseChallenge

class MockNavigationController: UINavigationController {
    var pushedViewController: UIViewController?
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushedViewController = viewController
        super.pushViewController(viewController, animated: true)
    }
}
class MasterViewControllerTests: XCTestCase {

    var masterViewController : MasterViewController?
    var mockNav : MockNavigationController?
    
    override func setUp() {
        self.masterViewController = MasterViewController()
        if let masterViewController = self.masterViewController {
            mockNav = MockNavigationController(rootViewController: masterViewController)
        }
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWithoutSATMatching() {
        guard let mockNav = self.mockNav else { return }
        guard let masterViewController = self.masterViewController else { return }
        
        UIApplication.shared.keyWindow?.rootViewController = mockNav

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
        masterViewController.didSelect(SchoolSectionController: SchoolSectionController(delegate: masterViewController), viewModel: SchoolViewModel(school: school, width: 375))
        
        
        //It will stay on the MasterViewController as we will not present to the detailView without an SAT score 
        XCTAssertTrue(mockNav.pushedViewController is MasterViewController)
    }


    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
