**Assertly:** Simplifying Swift Unit Testing
Assertly is an open-source Swift framework designed to streamline and enhance unit testing in iOS applications. It provides a set of powerful, easy-to-use assertion methods and testing utilities that simplify the process of writing and maintaining unit tests for controllers, view models, and network classes.
Key Benefits

Simplified Syntax: Assertly offers a more intuitive and readable syntax for common assertions, reducing boilerplate code and making tests easier to write and understand.
Improved Error Messages: Custom assertions provide more detailed and context-specific error messages, making it easier to identify and fix issues.
Support for Asynchronous Testing: Built-in utilities for testing asynchronous operations, reducing the complexity of testing network calls and other async processes.
Type-Safe Assertions: Leverages Swift's type system to catch potential errors at compile-time, reducing runtime errors.
Consistency: Promotes a consistent testing style across your project, improving maintainability and readability.

****Installation****

**Swift Package Manager (SPM)**
To install AssertlySwift package via Xcode

Go to File -> Swift Packages -> Add Package Dependency...
Then search for https://github.com/yeniObabatunde/Assertly.git
And Add the package to **your unit Test folder** only

**Core Features
Custom Assertions**
Assertly provides a suite of custom assertion methods that extend XCTest's functionality:

```assertEqual``` and ```assertEqualOptional```: For comparing equatable values.
```assertTrue``` and ```assertFalse```: For boolean checks.
```assertNotEqual```: For ensuring values are different.
```assertNotIdentical```: For checking object instances.
```assertNoThrow```: For verifying that code doesn't throw errors.
```assertNotNil``` and ```assertNotNilAndUnwrap```: For optional value checks.

```AssertlyViewModelTests``` **ViewModelTests Base Class**
A powerful base class for testing view models, providing:

Automatic setup and teardown of dependencies.
Methods for testing actions, array actions, and dictionary actions.
Utilities for testing error scenarios.

**Asynchronous Testing Support**
Built-in support for testing asynchronous operations, including:

**Expectation management.**
Convenient methods for delayed assertions.

**Usage Examples
Testing a View Controller**

```
class YourViewControllerClassTests: AssertlyViewModelTests<MockViewModel> {
    var viewController: MyViewController!

override func createDependencies() -> MockViewModel {
        return MockViewModel()
    }

    override func setUp() {
        super.setUp()
        viewController = MockSampleViewController()
        viewController.loadViewIfNeeded()
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
```

**Testing a ViewModel**

```
class YourViewModelTestsClass: AssertlyViewModelTests<MockViewModel> {
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

```

Testing Network Calls
```
class YourNetworkServiceTests: BaseTestCase<NetworkingTests>, UnitTestable{
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
```
**Why Assertly?**
Assertly was developed to address common pain points in iOS unit testing:

**Verbosity:** Standard XCTest assertions often require verbose syntax. Assertly's custom assertions are more concise and expressive.
Asynchronous Testing Complexity: Testing async code with XCTest can be cumbersome. Assertly provides utilities to simplify this process.
Inconsistent Testing Patterns: Teams often develop inconsistent testing styles. Assertly encourages a unified approach to writing tests.
Limited Error Information: XCTest's default error messages can be vague. Assertly's assertions provide more context when tests fail.
Repetitive Setup Code: The ViewModelTests base class reduces the amount of boilerplate needed for testing view models.

**Implementation**
A sample project demonstrating the implementation of Assertly is included in the repository. This project showcases:

**How to integrate Assertly into your Xcode project.**
Examples of testing various components (ViewControllers, ViewModels, NetworkServices) using Assertly.
Best practices for structuring your tests with Assertly.

**Conclusion**
Assertly aims to make unit testing in Swift more accessible, efficient, and enjoyable. By providing a robust set of tools and promoting best practices, it helps developers write more reliable and maintainable tests, ultimately leading to higher quality iOS applications.
We encourage contributions and feedback from the community to continue improving and expanding Assertly's capabilities.

**Future Development and Contributions**
We are actively working on expanding Assertly's capabilities and are particularly focused on developing support for UI testing. Our goal is to bring the same level of simplification and efficiency to UI testing that we've achieved with unit testing.
We warmly welcome contributions from the community in various areas:

**UI Testing Support:** Help us develop and refine tools for streamlining UI tests.
**Additional Assertion Methods: **Propose and implement new assertion methods that could benefit the iOS testing community.
**Performance Improvements:** Optimize existing code for better performance.
**Documentation and Examples:** Enhance our documentation or provide additional usage examples.
**Integration with Other Tools:** Develop integrations with popular iOS development and testing tools.
B**ug Fixes and Refinements:** Help identify and fix any issues in the existing codebase.

Whether you're an experienced developer or just starting out, your input is valuable. Feel free to submit pull requests, open issues for discussion, or share your ideas on how we can make Assertly even better.

**How to Contribute
**
We appreciate your interest in contributing to Assertly! Here's how you can get started:

Fork the repository
Clone your fork to your local machine
Create a new branch from the feature/Contribute branch, following this naming convention:
```
git checkout -b feature/Contribute/"NewChanges"
```
Replace "NewChanges" with a brief description of your contribution. For example:
```
git checkout -b feature/Contribute/UITestSupport **OR** git checkout -b feature/Contribute/NewAssertionMethod
```
Commit your changes:
```
git commit -m 'Add some AmazingFeature'
```
Push to the branch:
```
git push origin feature/Contribute/"NewChanges"
```
Open a Pull Request from your new branch to our feature/Contribute branch:

Please ensure your code adheres to our coding standards and includes appropriate tests and documentation for new features.
We review all pull requests and appreciate your patience during this process. We may suggest some changes or improvements.
Thank you for helping make Assertly better for everyone in the iOS development community!
