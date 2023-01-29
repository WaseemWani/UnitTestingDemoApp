//
//  UnitTestinDemoAppUnitTests.swift
//  UnitTestinDemoAppUnitTests
//
//  Created by Waseem Wani on 25/01/23.
//

import XCTest
@testable import UnitTestingDemoApp

class LoginViewModelUnitTests: XCTestCase {
    
    var loginViewModel: LoginViewModel! = nil
    
    override func setUp() {
        loginViewModel = LoginViewModel()
    }
    
    override func tearDown() {
        loginViewModel = nil
    }
    
    func test_if_entered_email_and_password_isValid_should_allow_login_successfully() {
        
        //ARRANGE
        let email = "waseem@gmail.com", password = "Abcd@123"
        
        //ACT
        let result = loginViewModel.login(email: email, password: password)
        
        //ASSERT
        XCTAssertTrue(result.shouldAllowLogin)
        XCTAssertNil(result.errorMessage)
    }
    
    func test_if_entered_email_isValid_should_not_allow_login() {
        
        //ARRANGE
        let email = "waseem@gmail", password = "Abcd@123"
        
        //ACT
        let result = loginViewModel.login(email: email, password: password)
        
        //ASSERT
        XCTAssertFalse(result.shouldAllowLogin)
        XCTAssertEqual(result.errorMessage , "Invalid email")
    }
    
    func test_if_entered_password_isValid_should_not_allow_login() {
        
        //ARRANGE
        let email = "waseem@gmail.com", password = "Abcd$12"
        
        //ACT
        let result = loginViewModel.login(email: email, password: password)
        
        //ASSERT
        XCTAssertFalse(result.shouldAllowLogin)
        XCTAssertEqual(result.errorMessage , "Invalid passsword")
    }
    
    func test_if_email_password_is_empty_should_not_allow_login() {
        //ARRANGE
        let email = "", password = ""
        
        //ACT
        let result  = loginViewModel.login(email: email, password: password)
        
        //ASSERT
        XCTAssertFalse(result.shouldAllowLogin)
        XCTAssertEqual(result.shouldAllowLogin, false)
        XCTAssertNotNil(result.errorMessage)
    }
}
