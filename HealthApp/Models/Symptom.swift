//
//  Symptom.swift
//  HealthApp
//
//  Created by Łukasz on 12/12/2021.
//

import Foundation

struct Symptom: Identifiable, Codable{
    var id: String
    var name: String = ""
    var depiction: String = ""
    var treatment: String = ""

}
