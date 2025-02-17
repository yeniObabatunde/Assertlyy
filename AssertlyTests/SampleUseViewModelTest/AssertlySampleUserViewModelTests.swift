//
//  AssertlySampleUserViewModelTests.swift
//  AssertlyTests
//
//  Created by Sharon Omoyeni Babatunde on 06/02/2023.
//

import XCTest
import Assertly
@testable import AssertlyInUse

final class AssertlySampleUserViewModelTests: AssertlyViewModelTests<MockViewModel> {
    
    override func createDependencies() -> MockViewModel {
        return MockViewModel()
    }
    
    func testFetchUser() {
        let mockUser = User(id: 1, name: "John Doe")
        sut?.setMockResult(mockUser, for: "fetchUser")
        
        testAction("fetchUser", expectedResult: mockUser)
    }
    
    func testFetchUsers() {
        let mockUsers = [User(id: 1, name: "John"), User(id: 2, name: "Jane")]
        (sut)?.setMockArrayResult(mockUsers, for: "fetchUsers")
        
        testArrayAction("fetchUsers", expectedResult: mockUsers)
    }
    
    func testFetchUserDict() {
        let mockUserDict = [1: User(id: 1, name: "John"), 2: User(id: 2, name: "Jane")]
        (sut)?.setMockDictionaryResult(mockUserDict, for: "fetchUserDict")
        
        testDictionaryAction("fetchUserDict", expectedResult: mockUserDict)
    }
    
    func testFetchUserError() {
        let mockError = NSError(domain: "UserError", code: 404, userInfo: [NSLocalizedDescriptionKey: "User not found"])
        (sut)?.setMockError(mockError, for: "fetchUser")
        
        testActionError("fetchUser", expectedError: mockError, as: NSError.self)
    }
    
    func testFetchUserFailure() {
        //MARK: This should fail because expected result doesn't equal actual result
        let expectedUser = User(id: 1, name: "John Doe")
        let actualUser = User(id: 2, name: "Jane Smith") // Different user
        sut?.setMockResult(actualUser, for: "fetchUser")
        assertNotEqual(actualUser, expectedUser)
    }
}

