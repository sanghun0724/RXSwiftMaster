//
//  RootViewModelTest.swift
//  protocol-orientated-programmingTests
//
//  Created by sangheon on 2022/01/07.
//

import XCTest
@testable import protocol_orientated_programming

class RootViewModelTest: XCTestCase {
    
    private var sut:RootViewModel!  // sut?  <- what we test for
    private var userService:MockUserService!
    private var loginStorageService:MockLoginStorageService!
    private var output:MockRootViewModelOutput!
    
    override func setUpWithError() throws {
        
        userService = MockUserService()
        loginStorageService = MockLoginStorageService()
        output = MockRootViewModelOutput()
        
        
        sut = RootViewModel(loginStorageService: loginStorageService,
                            userService: userService)
        
        sut.output = output
        try super.setUpWithError()
        
    }

    override func tearDownWithError() throws {
        sut = nil
        userService = nil
        loginStorageService = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testShowLogin_whenLoginStorageReturnsEmptyUserToken() throws {
     //given
        loginStorageService.dict = [:]
     //when
        sut.startFlow()
     //then
        XCTAssertEqual(output.flow.count, 1)
        XCTAssertEqual(output.flow[0], .login)
    }
    
    func testShowMainApp_whenLoginStorageReturnUserToken_isCalled() {
        //given
        loginStorageService.dict["ACCESS_TOKEN"] = UUID().uuidString
        //when
        sut.startFlow()
        //then
        XCTAssertEqual(output.flow.count, 1)
        XCTAssertEqual(output.flow[0], .mainApp)
    }
    
    func testShowMainApp_whenLoginStorageReturnEmptyStringUserToken_isCalled() {
        //given
        loginStorageService.dict["ACCESS_TOKEN"] = "" //empty!
        //when
        sut.startFlow()
        //then
        XCTAssertEqual(output.flow.count, 1)
        XCTAssertEqual(output.flow[0], .login) //so login
    }
    
}

class MockLoginStorageService:LoginStorageService {
    
    var accessTokenKey: String {
        return "ACCESS_TOKEN"
    }
    
    var dict:[String:String] = [:]
    
    var setUserAccessTokenArray:[String] = []
    func setUserAccessToken(value: String) {
        dict[accessTokenKey] = value
    }
    
    var getUserAccessTokenMock:String?
    func getUserAccessToken() -> String? {
        return dict[accessTokenKey]
    }
    
        
}

class MockRootViewModelOutput:RootViewModelOutput {
    
    enum Flow {
        case login
        case mainApp
    }
    
    var flow:[Flow] = []
    
    func showLogin() {
        flow.append(.login)
    }
    
    func showMainApp(userService: UserService) {
        flow.append(.mainApp)
    }
    
    
}




