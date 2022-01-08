//
//  HealthAppUITests.swift
//  HealthAppUITests
//
//  Created by Łukasz on 04/11/2021.
//

import XCTest

class HealthAppUITestsSignInTests: XCTestCase {
    
    let app = XCUIApplication()
    
    let testEmail = "user1@wp.pl"
    let testPassword = "123456"

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launchArguments = ["-loggedOut"]
        app.launch()
    }

    override func tearDownWithError() throws {
    }

    func testSigningInSuccess() throws {
        app.buttons["SignInNavButton"].tap()
        
        app.textFields["EmailTextField"].tap()
        app.textFields["EmailTextField"].typeText(testEmail)
        
        app.secureTextFields["PasswordTextField"].tap()
        app.secureTextFields["PasswordTextField"].typeText(testPassword)
        
        
        app.buttons["SignInButton"].tap()
        
        let label = app.staticTexts["Menu"]
        let exists = NSPredicate(format: "exists == 1")
        
        expectation(for: exists, evaluatedWith: label, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testSigningInFail() throws {
        app.buttons["SignInNavButton"].tap()
        
        app.textFields["EmailTextField"].tap()
        app.textFields["EmailTextField"].typeText(testEmail)
        
        app.secureTextFields["PasswordTextField"].tap()
        app.secureTextFields["PasswordTextField"].typeText("wrongpassword")
        
        
        app.buttons["SignInButton"].tap()
        
        let label = app.alerts["Email lub hasło są niepoprawne"]
        let exists = NSPredicate(format: "exists == 1")
        
        expectation(for: exists, evaluatedWith: label, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        
        //dismiss alert
        sleep(1)
        label.buttons["OK"].tap()
        sleep(1)
        
        XCTAssertFalse(label.exists)
    }
    
    func testSigningOut() throws {
        //sign in first
        try testSigningInSuccess()
        
        app.buttons["ProfileButton"].tap()
        
        app.buttons["SignOutButton"].tap()
        
        let label = app.staticTexts["Menu"]
        let exists = NSPredicate(format: "exists == 0")
        
        expectation(for: exists, evaluatedWith: label, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
