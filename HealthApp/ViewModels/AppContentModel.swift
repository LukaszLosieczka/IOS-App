//
//  AppContentModel.swift
//  HealthApp
//
//  Created by Łukasz on 09/12/2021.
//

import Foundation
import Firebase
import FirebaseAuth
import SwiftUI
import SwiftUICharts

class CurrentUser: ObservableObject{
    
    let auth = Auth.auth()
        
    @Published var error = false
    @Published var sigingInSuccess = false
    
    //user
    @Published var user: User? = nil
    
    init(testing: Bool = false){
        if auth.currentUser != nil && !CommandLine.arguments.contains("-loggedOut") && testing == false{
            loadUser()
            print("AKTUALNY UŻYTKOWNIK ID:")
            print(self.auth.currentUser!.uid)
            self.sigingInSuccess = true
        }
    }
    
    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email, password: password){
            [weak self] result, error in
            if error != nil{
                DispatchQueue.main.async {
                    self?.error = true
                }
                print(error?.localizedDescription ?? "")
            }
            else{
                DispatchQueue.main.async {
                    self?.error = false
                    self?.loadUser()
                    self?.sigingInSuccess = true
                }
                print("Successfull sign in")
            }
        }
    }
    
    func signOut(){
        try? auth.signOut()
        self.sigingInSuccess = false
        print("Successfull sign out")
    }
    
    
    func loadUser(){
        update()
    }
    
    func addNewDay(day: Day){
        let db = Firestore.firestore()
        
        db.collection("users").document(auth.currentUser!.uid).collection("days").addDocument(data: [ "Date": day.date,
                                                                                                      "Energy": day.energy,
                                                                                                      "Carbohydrates": day.carbo,
                                                                                                      "Fat": 0,
                                                                                                      "Protein": 0,
                                                                                                      "SleepTime": 0,
                                                                                                      "Sugars": 0,
                                                                                                      "Water": day.water,
                                                                                                      "EnergyBurned": 0
                                                                                                    ])
        { error in
            
            if error != nil{
                print(error.debugDescription)
            }
        }
    }
    
    func addValue(name: String, value: Double){
        let n = name.lowercased()
        var newValue:Double = 0
        var fbName = ""
        if n == "water"{
            newValue = (user?.days[0].water)! + value
            fbName = "Water"
        }
        else if n == "energy"{
            newValue = (user?.days[0].energy)! + value
            fbName = "Energy"
        }
        else if n == "carbo"{
            newValue = (user?.days[0].carbo)! + value
            fbName = "Carbohydrates"
        }
        else if n == "training"{
            newValue = (user?.days[0].training)! + value
            fbName = "EnergyBurned"
        }
        else if n == "fat"{
            newValue = (user?.days[0].fat)! + value
            fbName = "Fat"
        }
        else if n == "protein"{
            newValue = (user?.days[0].protein)! + value
            fbName = "Protein"
        }
        else if n == "sugars"{
            newValue = (user?.days[0].sugars)! + value
            fbName = "Sugars"
        }
        
        let db = Firestore.firestore()
        db.collection("users").document(self.auth.currentUser!.uid).collection("days").document((user?.days[0].id)!)
            .setData([fbName:newValue], merge: true)
    }
    
    func changeGoal(name: String, value: Double){
        let db = Firestore.firestore()
        db.collection("users").document(self.auth.currentUser!.uid).setData([name:value], merge: true)
    }
    
    func changeMeasurement(name: String, value: Double){
        var measurements = user?.getMeasurement(name: name)
        measurements![getDate()] = value
        
        let db = Firestore.firestore()
        db.collection("users").document(self.auth.currentUser!.uid).setData([name:measurements as Any], merge: true)
    }
    
    func update(){
        let db = Firestore.firestore()
        db.collection("users").document(auth.currentUser!.uid).getDocument(){ snapshot, error in
            
            if error == nil {
                
                if let snapshot = snapshot {
                    db.collection("users").document(self.auth.currentUser!.uid).collection("days").getDocuments(){ snapshot2, error2 in
                        if error2 == nil{
                            if let snapshot2 = snapshot2{
                                let days = snapshot2.documents.map { d in
                                    return Day(dict: d.data(), dayId: d.documentID)
                                }
                                self.user = User(dict: snapshot.data()!, userId: snapshot.documentID, userDays: days)
                            }
                        }
                    }
                }
                else{
                    print("snapshot error")
                }
            }
            else{
                print("error:" + error.debugDescription)
            }

        }
    }
}
