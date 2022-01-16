//
//  HealthAppMenuUITests.swift
//  HealthAppUITests
//
//  Created by Łukasz on 14/01/2022.
//

import XCTest

class HealthAppMenuUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    let testEmail = "user1@wp.pl"
    let testPassword = "123456"

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launchArguments = ["-loggedOut"]
        app.launch()
        
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

    override func tearDownWithError() throws {
    }

    func testNavigateToProfile() throws {
        XCTAssertTrue(app.staticTexts["Menu"].exists)
        
        app.buttons["ProfileButton"].tap()
        
        XCTAssertTrue(app.staticTexts["Profile"].exists)
    }
    
    func testNavigateToMeasurements() throws {
        XCTAssertTrue(app.staticTexts["Menu"].exists)
        
        app.buttons["Pomiary ciała"].tap()
        
        XCTAssertTrue(app.navigationBars["Pomiary ciała"].exists)
    }
    
    func testNavigateToFoodStats() throws {
        XCTAssertTrue(app.staticTexts["Menu"].exists)
        
        app.buttons["Odżywianie"].tap()
        
        XCTAssertTrue(app.navigationBars["Odżywianie"].exists)
    }
    
    func testNavigateToWaterStats() throws {
        XCTAssertTrue(app.staticTexts["Menu"].exists)
        
        app.buttons["Spożycie wody"].tap()
        
        XCTAssertTrue(app.navigationBars["Spożycie wody"].exists)
    }
    
    func testNavigateToProducts() throws {
        XCTAssertTrue(app.staticTexts["Menu"].exists)
        
        app.buttons["Produkty"].tap()
        
        XCTAssertTrue(app.navigationBars["Produkty"].exists)
    }
    
    func testNavigateToTraining() throws {
        XCTAssertTrue(app.staticTexts["Menu"].exists)
        
        app.buttons["Trening"].tap()
        
        XCTAssertTrue(app.navigationBars["Trening"].exists)
    }
    
    func testNavigateToSymptoms() throws {
        XCTAssertTrue(app.staticTexts["Menu"].exists)
        
        app.buttons["Objawy"].tap()
        
        XCTAssertTrue(app.navigationBars["Objawy"].exists)
    }

}
