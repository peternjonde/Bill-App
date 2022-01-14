//
//  UserInfo.swift
//  MoneyCheak
//
//  Created by Peter Njonde on 2021-12-26.
//

import SwiftUI

class UserInfo: Identifiable, Codable {

    var name = ""
    var schoolEmail = ""
    var password = ""
    var year = ""
}

class UserInfos: ObservableObject {
    @Published var info: [UserInfo]

    init() {
        if let data = UserDefaults.standard.data(forKey: "SavedData") {
            if let decoded = try? JSONDecoder().decode([UserInfo].self, from: data) {
                self.info = decoded
                return
            }
        }

        self.info = []
    }
    func save() {
        if let encoded = try? JSONEncoder().encode(info){
            UserDefaults.standard.set(encoded, forKey: "SavedData")
        }
    }
    
}
