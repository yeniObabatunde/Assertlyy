//
//  ErrorHandlingTests.swift
//  AssertlyTests
//
//  Created by Sharon Omoyeni Babatunde on 29/07/2024.
//

import XCTest
import Assertly

final class ErrorHandlingTests: BaseTestCase<ErrorHandlingTests>, UnitTestable {
    var networking: MockNetworking!
    
    required init(dependencies: MockNetworking) {
        super.init()
        self.networking = dependencies
    }
    
    override func setUp() {
        super.setUp()
        // Additional setup if needed
    }
    
    override func tearDown() {
        // Additional teardown if needed
        super.tearDown()
    }
    
    override func createDependencies() -> MockNetworking {
        return MockNetworking()
    }
    
    func testInvalidURLError() {
        networking.mockResult = .failure(NetworkError.invalidURL)
        
        waitForAsyncOperation { done in
            self.networking.request("invalidEndpoint") { (result: Result<[String: String], Error>) in
                switch result {
                case .success:
                    XCTFail("Expected failure, got success")
                case .failure(let error):
                    XCTAssertEqual(error as? NetworkError, .invalidURL)
                }
                done()
            }
        }
    }
}
