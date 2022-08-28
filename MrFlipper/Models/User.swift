//
//  User.swift
//  MrFlipper
//
//  Created by Duong Minh Nhat on 28/08/2022.
//

import Foundation

struct User: Identifiable, Codable {
    var id = UUID()
    var username: String
    var highScore: Int = 0
    var badge: String = ""
}

// Both methods `throw` to hand over an en-/decoding error to the caller
func saveUserDict(value: [String:User]) {
    print(value)
    
    do {
        let usersData = try JSONEncoder().encode(value)
        UserDefaults.standard.set(usersData, forKey: "users")
    } catch let error {
        fatalError("Failed to encode JSON: \(error)")
    }
}

func getUserDict() -> [String:User] {
    guard let usersData = UserDefaults.standard.data(forKey: "users") else {return [:]}
    
    do {
        let usersData = try JSONDecoder().decode([String:User].self, from: usersData)
        return usersData
    } catch let error {
        fatalError("Failed to decode JSON: \(error)")
    }
}
