//
//  ProductsMenuModel.swift
//  HealthApp
//
//  Created by Łukasz on 26/12/2021.
//

import Foundation
import Firebase

class CurrentProduct: ObservableObject{
    @Published var name: String = ""
    @Published var carbohydrates: Double = 0
    @Published var energy: Double = 0
    @Published var fat: Double = 0
    @Published var protein: Double = 0
    @Published var sugars: Double = 0
    @Published var water: Double = 0
    
    func setParameters(name: String, carbohydrates: Double, energy: Double, fat: Double, protein: Double, sugars: Double, water: Double){
        self.name = name
        self.carbohydrates = carbohydrates
        self.energy = energy
        self.fat = fat
        self.protein = protein
        self.sugars = sugars
        self.water = water
    }
    
    func getValue(namePL: String) -> String {
        var result: String = ""
        if namePL == "Węglowodany"{
            result = String(carbohydrates) + "g"
        }
        else if namePL == "Kalorie"{
            result = String(energy) + "kcal"
        }
        else if namePL == "Tłuszcze"{
            result = String(fat) + "g"
        }
        else if namePL == "Białko"{
            result = String(protein) + "g"
        }
        else if namePL == "Cukry"{
            result = String(sugars) + "g"
        }
        else if namePL == "Woda"{
            result = String(water)  + "ml"
        }
        
        return result
    }
}



class ProductsList: ObservableObject {
    
    @Published var productsList: [Product] = []
    
    init(){
        loadData()
    }
    
    func loadData(){
        do {
            let jsonData = try JSONSerialization.loadJSON(withFilename: "products")
            let decodedProducts = try JSONDecoder().decode([Product].self, from: jsonData as! Data)
            self.productsList = decodedProducts
            sortData()
        }catch {
            print("Error while loading products data from file")
        }
    }
    
    private func saveData(){
        do{
            let jsonObject = try JSONEncoder().encode(productsList)
            let result = try JSONSerialization.save(jsonObject: jsonObject, toFilename: "products")
            
            if !result{
                print("Error while saving products data to file")
            }
        }catch {
            print("Error while saving products data to file")
        }
    }
    
    private func sortData(){
        self.productsList.sort{
            $0.name < $1.name
        }
    }
    
    private func areListsSame(list1: [Product], list2: [Product]) -> Bool{
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
            if list1[i].carbohydrates != list2[i].carbohydrates {
                return false
            }
            if list1[i].energy != list2[i].energy {
                return false
            }
            if list1[i].fat != list2[i].fat {
                return false
            }
            if list1[i].protein != list2[i].protein {
                return false
            }
            if list1[i].sugars != list2[i].sugars {
                return false
            }
            if list1[i].water != list2[i].water {
                return false
            }
        }
        
        return true
    }
    
    func updateData(){
        
        let db = Firestore.firestore()
        
        db.collection("products").getDocuments { snapshot, error in
            
            if error == nil {
                
                if let snapshot = snapshot {
                    
                    DispatchQueue.main.async {
                        
                        let updatedList = snapshot.documents.map { p in
                            
                            return Product(id: p.documentID,
                                           name: p["name"] as? String ?? "produkt" + p.documentID,
                                           carbohydrates: p["carbohydrates"] as? Double ?? 0,
                                           energy: p["energy"] as? Double ?? 0,
                                           fat: p["fat"] as? Double ?? 0,
                                           protein: p["protein"] as? Double ?? 0,
                                           sugars: p["sugars"] as? Double ?? 0,
                                           water: p["water"] as? Double ?? 0)
                        }
                        
                        if !self.areListsSame(list1: updatedList, list2: self.productsList){
                            self.productsList = updatedList
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
