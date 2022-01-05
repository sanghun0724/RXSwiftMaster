//
//  protocol_orientated_programmingTests.swift
//  protocol-orientated-programmingTests
//
//  Created by sangheon on 2022/01/05.
//

import XCTest
@testable import protocol_orientated_programming

class protocol_orientated_programmingTests: XCTestCase {
    
    private var sut:UserViewModel! // 로직단 타입 가져오고
    private var userService:MockUserService! // protocol impl
    private var output: MockUserViewOutput! //mock들

    override func setUpWithError() throws {
        output = MockUserViewOutput()
        userService = MockUserService()
        sut = UserViewModel(userService: userService)
        sut.output = output
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        sut = nil
        userService = nil
        try super.tearDownWithError()
    }

    func testUpdateView_whenAPISuccess_showsImageAndEamil() {
    //given (가진것들 (변수같은))
        let user = User(id: 1, email: "me@gamil.com", avatar: "https://www.picsum.com/2")
        userService.fetchUserMockResult = .success(user)
    //when (something happens)
        sut.fetchUser()
    //then(what is expected result)
        XCTAssertEqual(output.updateViewArray.count, 1)
        XCTAssertEqual(output.updateViewArray[0].email, "me@gamil.com")
        XCTAssertEqual(output.updateViewArray[0].imageUrl, "https://www.picsum.com/2")
    }
    
    func testUpdateView_onAPIFailiure_showsErrorImageAndDefaultNoUserFoundText() {
        //given
        userService.fetchUserMockResult = .failure(NSError())
        //when
        sut.fetchUser()
        //then
        XCTAssertEqual(output.updateViewArray.count, 1)
        XCTAssertEqual(output.updateViewArray[0].email, "No User Found")
        XCTAssertEqual(output.updateViewArray[0].imageUrl, "https://cdn1.iconfinder.com/data/icons/user-fill-icons-set/144/User003_Error-1024 .jpg")
    }

    
}


class MockUserService:UserService {
    var fetchUserMockResult:Result<User, Error>? //테스트할때 위에서 success , failure 나누려고
    
    func fetchUser(completion: @escaping (Result<User, Error>) -> Void) {
        if let result = fetchUserMockResult {
            completion(result)
        }
    }
}

class MockUserViewOutput: UserViewModelOutput { //차피 앱실행될때 뷰컨에서 뷰딛로드에서 실행되니.. 업데이트뷰 func가
    var updateViewArray:[(imageUrl:String,email:String)] = []
    // i want read image url ,email <- Func 할떄마다
    func updateView(imageUrl: String, email: String) {
        updateViewArray.append((imageUrl,email))
    }
}
//breakPoint 걸어보기 (뭔값들어있는지 홗인가능)
