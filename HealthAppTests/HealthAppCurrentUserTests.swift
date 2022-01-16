//
//  HealthAppTests.swift
//  HealthAppTests
//
//  Created by Łukasz on 04/11/2021.
//

import XCTest
@testable import HealthApp

class HealthAppCurrentUserTests: XCTestCase {
    
    let testEmail = "user1@wp.pl"
    let testPassword = "123456"
    
    let timeout:UInt32 = 2
    
    var currentUser: CurrentUser!

    override func setUpWithError() throws {
        try super.setUpWithError()
        currentUser = CurrentUser(testing: true)
    }

    override func tearDownWithError() throws {
        currentUser = nil
        try super.tearDownWithError()
    }
    

    func testSigningIn() async throws {
        //given
        XCTAssertFalse(currentUser.sigingInSuccess)
        
        //when
        currentUser.signIn(email: testEmail, password: testPassword)
        
        sleep(timeout)
        
        //then
        XCTAssertTrue(currentUser.sigingInSuccess)
    }
    
    func testSigningOut() async throws {
        //given
        currentUser.signIn(email: testEmail, password: testPassword)
        sleep(timeout)
        XCTAssertTrue(currentUser.sigingInSuccess)
        
        //when
        currentUser.signOut()
        
        //then
        XCTAssertFalse(currentUser.sigingInSuccess)
    }
    
    func testUpdateUser() async throws {
        //given
        currentUser.signIn(email: testEmail, password: testPassword)
        sleep(timeout)
        XCTAssertTrue(currentUser.sigingInSuccess)
        currentUser.user = nil
        XCTAssertTrue(currentUser.user == nil)
        
        //when
        currentUser.update()
        sleep(timeout)
        
        //then
        XCTAssertTrue(currentUser.user != nil)
    }
    
    func testAddStatsValue() async throws {
        //given
        currentUser.signIn(email: testEmail, password: testPassword)
        sleep(timeout)
        XCTAssertTrue(currentUser.sigingInSuccess)
        let lastValue = (currentUser.user?.lastDay().water)!
        
        //when
        currentUser.addValue(name:"water", value: 1)
        currentUser.update()
        sleep(timeout)
        
        XCTAssertTrue(currentUser.user?.lastDay().water == lastValue + 1)
    }
    
    func testChangeGoal() async throws {
        //given
        currentUser.signIn(email: testEmail, password: testPassword)
        sleep(timeout)
        XCTAssertTrue(currentUser.sigingInSuccess)
        let lastValue = (currentUser.user?.proteinGoal)!
        
        //when
        currentUser.changeGoal(name: "proteinGoal", value: lastValue + 1)
        currentUser.update()
        sleep(timeout)
        
        XCTAssertTrue(currentUser.user?.proteinGoal == lastValue + 1)
    }
}
