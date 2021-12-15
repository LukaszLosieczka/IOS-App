//
//  SymptomsMenuModel.swift
//  HealthApp
//
//  Created by Łukasz on 12/12/2021.
//

import Foundation
import Firebase


class CurrentSymptom: ObservableObject{
    @Published var name: String = ""
    @Published var depiction: String = ""
    @Published var treatment: String = ""
    
    func setParameters(name: String, depiction: String, treatment: String){
        self.name = name
        self.depiction = depiction
        self.treatment = treatment
    }
}


class SymptomsList: ObservableObject {
    
    @Published var symptomsList: [Symptom] = []
    
    init(){
        loadData()
    }
    
    func loadData(){
        do {
            let jsonData = try JSONSerialization.loadJSON(withFilename: "symptoms")
            let decodedSymptoms = try JSONDecoder().decode([Symptom].self, from: jsonData as! Data)
            self.symptomsList = decodedSymptoms
            sortData()
        }catch {
            print("Error while loading symptoms data from file")
        }
    }
    
    private func saveData(){
        do{
            let jsonObject = try JSONEncoder().encode(symptomsList)
            let result = try JSONSerialization.save(jsonObject: jsonObject, toFilename: "symptoms")
            
            if !result{
                print("Error while saving symptoms data to file")
            }
        }catch {
            print("Error while saving symptoms data to file")
        }
    }
    
    private func areListsSame(list1: [Symptom], list2: [Symptom]) -> Bool{
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
            if list1[i].depiction != list2[i].depiction {
                return false
            }
            if list1[i].treatment != list2[i].treatment {
                return false
            }
        }
        
        return true
    }
    
    private func sortData(){
        self.symptomsList.sort{
            $0.name < $1.name
        }
    }
    
    func updateData(){
        
        let db = Firestore.firestore()
        
        db.collection("symptoms").getDocuments { snapshot, error in
            
            if error == nil {
                
                if let snapshot = snapshot {
                    
                    DispatchQueue.main.async {
                        
                        let updatedList = snapshot.documents.map { d in
                            
                            return Symptom(id: d.documentID,
                                            name: d["name"] as? String ?? "",
                                            depiction: d["depiction"] as? String ?? "",
                                            treatment: d["treatment"] as? String ?? "")
                        }
                        
                        if !self.areListsSame(list1: updatedList, list2: self.symptomsList){
                            self.symptomsList = updatedList
                            self.sortData()
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
