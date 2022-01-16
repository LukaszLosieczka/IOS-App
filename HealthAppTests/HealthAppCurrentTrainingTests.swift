//
//  HealthAppCurrentTrainingTests.swift
//  HealthAppTests
//
//  Created by Łukasz on 16/01/2022.
//

import XCTest
@testable import HealthApp

class HealthAppCurrentTrainingTests: XCTestCase {

    var currentTraining: CurrentTraining!

    override func setUpWithError() throws {
        try super.setUpWithError()
        currentTraining = CurrentTraining()
    }

    override func tearDownWithError() throws {
        currentTraining = nil
        try super.tearDownWithError()
    }

    func testSetParameters() throws {
        //given
        let currentName = currentTraining.name
        let currentExercisesNum = currentTraining.numberOfExercises
        let currentExercisesMinutes = currentTraining.minutesOfExercises
        let currentRestingMinutes = currentTraining.minutesOfResting
        let currentCalories = currentTraining.caloriesBurned
        let currentImage = currentTraining.image
        
        //when
        currentTraining.setParameters(name: currentName + "Test",
                                      numberOfExercises: currentExercisesNum + 100,
                                      minutesOfExercises: currentExercisesMinutes + 100,
                                      minutesOfResting: currentRestingMinutes + 100,
                                      caloriesBurned: currentCalories + 100,
                                      image: currentImage + "Test")
        
        //then
        XCTAssertTrue(currentTraining.name == currentName + "Test")
        XCTAssertTrue(currentTraining.numberOfExercises == currentExercisesNum + 100)
        XCTAssertTrue(currentTraining.minutesOfExercises == currentExercisesMinutes + 100)
        XCTAssertTrue(currentTraining.minutesOfResting == currentRestingMinutes + 100)
        XCTAssertTrue(currentTraining.caloriesBurned == currentCalories + 100)
        XCTAssertTrue(currentTraining.image == currentImage + "Test")
    }
    
    func testPauseToggle() throws {
        //given
        let previouseState = currentTraining.paused
        
        //when
        currentTraining.pauseToggle()
        
        //then
        XCTAssertFalse(previouseState == currentTraining.paused)
    }

}
