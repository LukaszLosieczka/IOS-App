//
//  HealthAppApp.swift
//  HealthApp
//
//  Created by Łukasz on 04/11/2021.
//

import SwiftUI
import Firebase
import AVFoundation
import AudioToolbox


class AppDelegate: NSObject, UIApplicationDelegate{
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:[UIApplication.LaunchOptionsKey:Any]?=nil)->Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct HealthAppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            AppContentView()
        }
    }
}


extension JSONSerialization {
    
    static func loadJSON(withFilename filename: String) throws -> Any? {
        let fm = FileManager.default
        let urls = fm.urls(for: .documentDirectory, in: .userDomainMask)
        if let url = urls.first{
            var fileURL = url.appendingPathComponent(filename)
            fileURL = fileURL.appendingPathExtension("json")
            let data = try Data(contentsOf: fileURL)
//            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [.mutableContainers, .mutableLeaves])
//            return jsonObject
            return data
        }
        return nil
    }
    
    static func save(jsonObject: Any, toFilename filename: String) throws -> Bool{
        let fm = FileManager.default
        let urls = fm.urls(for: .documentDirectory, in: .userDomainMask)
        if let url = urls.first{
            var fileURL = url.appendingPathComponent(filename)
            fileURL = fileURL.appendingPathExtension("json")
            let data = jsonObject as AnyObject
            try data.write(to: fileURL, options: [.atomicWrite])
            return true
        }
        
        return false
    }
}

class AudioPlayer{
    private var player: AVAudioPlayer?
    
    func playMusic(name: String, type: String, loops: Int) {
        guard let url = Bundle.main.url(forResource: name, withExtension: type) else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url)
            
            
            guard let player = player else { return }
            
            player.numberOfLoops = loops
            
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func playSystemSound(soundId: Int){
        AudioServicesPlaySystemSound(SystemSoundID(soundId))
    }
    
    func stopPlaying(){
        player?.stop()
    }
    
}

extension Date {
    var dayBefore: Date{
        return Calendar.current.date(byAdding: .day, value: -1, to: self)!
    }
}


//if let path = Bundle.main.path(forResource: "products", ofType: "json") {
//    do {
//          let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
//          let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
//          if let jsonResult = jsonResult as? [Dictionary<String, AnyObject>] {
//              for product in jsonResult {
//                  addData(name: product["Food"] as! String, carboHydrates: product["Carbohydrate"] as! NSNumber, energy: product["Energy"] as! NSNumber, protein: product["Protein"] as! NSNumber, sugars: product["Sugars"] as! NSNumber, fat: product["Fat"] as! NSNumber, water: product["Water"] as! NSNumber)
//              }
//              print("Success")
//          }
//      } catch {}
//}

//func addData(name: String, carboHydrates: NSNumber, energy: NSNumber, protein: NSNumber, sugars: NSNumber, fat: NSNumber, water: NSNumber){
//    let db = Firestore.firestore()
//
//    db.collection("products").addDocument(data: ["name": name, "carbohydrates": carboHydrates, "energy": energy, "protein": protein, "sugars": sugars, "fat": fat, "water": water]){
//        error in
//
//        if error == nil{
//            //print("Success")
//        }
//    }
//}


//if let path = Bundle.main.path(forResource: "trainings", ofType: "json") {
//    do {
//          let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
//          let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
//          if let jsonResult = jsonResult as? [Dictionary<String, AnyObject>] {
//              for training in jsonResult {
//                  addData(name: training["name"] as! String, numberOfExercises: training["numberOfExercises"] as! NSNumber, minutesOfExercises: training["minutesOfExercises"] as! NSNumber, minutesOfResting: training["minutesOfResting"] as! NSNumber, caloriesBurned: training["caloriesBurned"] as! NSNumber, image: training["image"] as! String)
//              }
//              print("Success")
//          }
//      } catch {}
//}
//
//func addData(name: String, numberOfExercises: NSNumber, minutesOfExercises: NSNumber, minutesOfResting: NSNumber, caloriesBurned: NSNumber,
//             image: String){
//    let db = Firestore.firestore()
//
//    db.collection("trainings").addDocument(data: ["name": name, "numberOfExercises": numberOfExercises, "minutesOfExercises": minutesOfExercises, "minutesOfResting": minutesOfResting, "caloriesBurned": caloriesBurned, "image": image]){error in
//
//        if error == nil{
//            //print("Success")
//        }
//    }
//}



//if let path = Bundle.main.path(forResource: "symptoms", ofType: "json") {
//    do {
//          let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
//          let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
//          if let jsonResult = jsonResult as? [Dictionary<String, AnyObject>] {
//              for symptom in jsonResult {
//                  addData(name: symptom["name"] as! String, depiction: symptom["depiction"] as! String, treatment: symptom["treatment"] as! String)
//              }
//              print("Success")
//          }
//      } catch {}
//}
//func addData(name: String, depiction: String, treatment: String){
//    let db = Firestore.firestore()
//
//    db.collection("symptoms").addDocument(data: ["name": name, "depiction": depiction, "treatment": treatment]){error in
//
//        if error == nil{
//            //print("Success")
//        }
//        else{
//            print(error)
//        }
//    }
//}
