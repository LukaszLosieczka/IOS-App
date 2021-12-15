//
//  TrainingMenuModel.swift
//  HealthApp
//
//  Created by Łukasz on 09/12/2021.
//

import Foundation
import Firebase


class CurrentTraining: ObservableObject{
    @Published var name = ""
    @Published var numberOfExercises: Int = 0
    @Published var minutesOfExercises: Int = 0
    @Published var minutesOfResting: Int = 0
    @Published var caloriesBurned: Double = 0
    @Published var image = ""
    @Published var paused = false
    
    func setParameters(name: String, numberOfExercises: Int, minutesOfExercises: Int, minutesOfResting: Int, caloriesBurned: Double, image: String){
        self.name = name
        self.numberOfExercises = numberOfExercises
        self.minutesOfExercises = minutesOfExercises
        self.minutesOfResting = minutesOfResting
        self.caloriesBurned = caloriesBurned
        self.image = image
    }
    
    func pauseToggle(){
        self.paused.toggle()
    }
}

class TrainingsList: ObservableObject {
    
    @Published var trainingList: [Training] = []
    
    init(){
        loadData()
    }
    
    func loadData(){
        do {
            let jsonData = try JSONSerialization.loadJSON(withFilename: "trainings")
            let decodedTrainings = try JSONDecoder().decode([Training].self, from: jsonData as! Data)
            self.trainingList = decodedTrainings
        }catch {
            print("Error while loading trainings data from file")
        }
    }
    
    private func saveData(){
        do{
            let jsonObject = try JSONEncoder().encode(trainingList)
            let result = try JSONSerialization.save(jsonObject: jsonObject, toFilename: "trainings")
            
            if !result{
                print("Error while saving trainings data to file")
            }
        }catch {
            print("Error while saving trainings data to file")
        }
    }
    
    private func areListsSame(list1: [Training], list2: [Training]) -> Bool{
        if list1.count != list2.count{
            return false
        }
        for i in 0...(list1.count-1){
            if list1[i].id != list2[i].id {
                return false
            }
            if list1[i].name != list2[i].name {
                return false
            }
            if list1[i].numberOfExercises != list2[i].numberOfExercises {
                return false
            }
            if list1[i].minutesOfResting != list2[i].minutesOfResting {
                return false
            }
            if list1[i].minutesOfExercises != list2[i].minutesOfExercises {
                return false
            }
            if list1[i].caloriesBurned != list2[i].caloriesBurned {
                return false
            }
            if list1[i].image != list2[i].image {
                return false
            }
        }
        
        return true
    }
    
    func updateData(){
        
        let db = Firestore.firestore()
        
        db.collection("trainings").getDocuments { snapshot, error in
            
            if error == nil {
                
                if let snapshot = snapshot {
                    
                    DispatchQueue.main.async {
                        
                        let updatedList = snapshot.documents.map { d in
                            
                            return Training(id: d.documentID,
                                            name: d["name"] as? String ?? "",
                                            numberOfExercises: d["numberOfExercises"] as? Int ?? 0,
                                            minutesOfExercises: d["minutesOfExercises"] as? Int ?? 0,
                                            minutesOfResting: d["minutesOfResting"] as? Int ?? 0,
                                            caloriesBurned: d["caloriesBurned"] as? Double ?? 0,
                                            image: d["image"] as? String ?? "")
                        }
                        
                        if !self.areListsSame(list1: updatedList, list2: self.trainingList){
                            self.trainingList = updatedList
                            self.saveData()
                        }
                    }
                }
            }
            else{
                print("Error while updating trainings data from firebase")
            }
            
        }
    }
}
