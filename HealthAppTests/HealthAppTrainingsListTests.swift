//
//  HealthAppTrainingListTests.swift
//  HealthAppTests
//
//  Created by Łukasz on 16/01/2022.
//

import XCTest
@testable import HealthApp

class HealthAppTrainingsListTests: XCTestCase {
    
    var trainingsList: TrainingsList!
    
    let timeout:UInt32 = 2

    override func setUpWithError() throws {
        try super.setUpWithError()
        trainingsList = TrainingsList()
    }

    override func tearDownWithError() throws {
        trainingsList = nil
        try super.tearDownWithError()
    }
    
    func testAreListsSameTrue() throws {
        //given
        let list1 = [Training(id: "Test1"), Training(id: "Test2")]
        
        let list2 = [Training(id: "Test1"), Training(id: "Test2")]
        
        //when
        let result = trainingsList.areListsSame(list1: list1, list2: list2)
        
        //then
        XCTAssertTrue(result)
    }
    
    func testAreListsSameFalse() throws {
        //given
        let list1 = [Training(id: "Test1"), Training(id: "Test2")]
        
        let list2 = [Training(id: "Test3"), Training(id: "Test4")]
        
        //when
        let result = trainingsList.areListsSame(list1: list1, list2: list2)
        
        //then
        XCTAssertFalse(result)
    }

    func testLoadData() throws {
        //given
        trainingsList.trainingList.append(Training(id: "Test"))
        let newList = trainingsList.trainingList
        
        //when
        trainingsList.loadData()
        
        //then
        XCTAssertFalse(trainingsList.areListsSame(list1: newList, list2: trainingsList.trainingList))
    }
    
    func testUpdateTrainings() async throws {
        //given
        trainingsList.trainingList.append(Training(id: "Test"))
        let newList = trainingsList.trainingList
        
        //when
        trainingsList.updateData()
        
        sleep(timeout)
        
        //then
        XCTAssertFalse(trainingsList.areListsSame(list1: newList, list2: trainingsList.trainingList))
    }
}
