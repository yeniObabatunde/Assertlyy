//
//  AssertlySampleViewControllerTest.swift
//  Assertly
//
//  Created by Sharon Omoyeni Babatunde on 06/07/2024.
//

import XCTest
import Assertly
@testable import AssertlyInUse

class AssertlySampleViewControllerTest: AssertlyViewModelTests<MockViewModel> {
    
    var viewController: MockSampleViewController!
    
    override func createDependencies() -> MockViewModel {
        return MockViewModel()
    }
    
    override func setUp() {
        super.setUp()
        viewController = MockSampleViewController()
        viewController.loadViewIfNeeded()
    }
    
    override func tearDown() {
        viewController = nil
        super.tearDown()
    }
    
    func testUpdateUI_WithValidUser() {
        //MARK: Given
        let expectation = self.expectation(description: "Fetch User Success")
        let expectedUser = UserListDatum(id: 1, email: "john@example.com", firstName: "John", lastName: "Doe", avatar: "avatar_url")
        sut?.setMockResult(expectedUser, for: "getUser")
        
        //MARK: When
        viewController.fetchUser()
        
        //MARK: Then
        self.assertTrue(self.viewController.fetchUserCalled)
        assertNotEqual(expectedUser.email, "johnexample@gmail.com")
        expectation.fulfill()
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testFetchUser_Failure() {
        //MARK: Given
        let expectedError = NSError(domain: "TestError", code: 404, userInfo: [NSLocalizedDescriptionKey: "User not found"])
        sut?.setMockError(expectedError, for: "getUser")
        
        //MARK: When
        viewController.fetchUser()
        
        //MARK: Then
        assertTrue(viewController.fetchUserCalled)
        if let alert = viewController.presentedAlert {
            assertEqual(alert.title, "Error", "Alert title should be 'Error'")
            assertEqual(alert.message, "User not found", "Alert message should match the error description")
        }
    }
    
    func testUpdateUI_WithNilID() {
        //MARK: Given
        let user = UserListDatum(id: nil, email: "no-id@example.com", firstName: "No", lastName: "ID", avatar: "avatar_url")
        
        //MARK: When
        viewController.updateUI(with: user)
        
        //MARK: Then
        assertEqual(viewController.idLabel.text, "ID: 0", "ID label should display default ID when nil")
    }
    
    func testHandleError_DisplaysAlert() {
        //MARK: Given
        let error = NSError(domain: "TestError", code: 500, userInfo: [NSLocalizedDescriptionKey: "Server error"])
        
        //MARK: When
        viewController.handle(error: error)
        
        //MARK: Then
        if let alert = assertNotNilAndUnwrap(viewController.presentedAlert, "Error alert should be presented") {
            assertEqual(alert.title, "Error", "Alert title should be 'Error'")
            assertEqual(alert.message, "Server error", "Alert message should match the error description")
        }
    }
    
}
