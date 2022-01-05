//
//  protocol_orientated_programmingTests.swift
//  protocol-orientated-programmingTests
//
//  Created by sangheon on 2022/01/05.
//

import XCTest
@testable import protocol_orientated_programming

class protocol_orientated_programmingTests: XCTestCase {
    
    private var sut:UserViewModel!
    private var userService:MockUserService!

    override func setUpWithError() throws {
        
        userService = MockUserService()
        
        sut = UserViewModel(userService: userService)       
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    
}


class MockUserService:UserService {
    var fetchUserMockResult:Result<User, Error>?
    
    func fetchUser(completion: @escaping (Result<User, Error>) -> Void) {
        if let result = fetchUserMockResult {
            completion(result)
        }
    }
    
    
}
