//
//  NetworkingTests.swift
//  AssertlyTests
//
//  Created by Sharon Omoyeni Babatunde on 29/07/2024.
//

import XCTest
import Assertly
@testable import AssertlyInUse

class NetworkingTests: BaseTestCase<NetworkingTests>, UnitTestable {
    
    var networking: MockNetworking!
    
    required init(dependencies: MockNetworking) {
        super.init()
        self.networking = dependencies
    }
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    override func createDependencies() -> MockNetworking {
        return MockNetworking()
    }
    
    func testSuccessfulRequest() {
        let expectation = self.expectation(description: "Successful request")
        let mockData = ["key": "value"]
        networking.mockResult = .success(mockData)
        
        networking.request("testEndpoint") { (result: Result<[String: String], Error>) in
            switch result {
            case .success(let data):
                XCTAssertEqual(data, mockData)
            case .failure:
                XCTFail("Expected success, got failure")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
}
