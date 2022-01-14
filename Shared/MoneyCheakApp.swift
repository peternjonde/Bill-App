//
//  MoneyCheakApp.swift
//  Shared
//
//  Created by Peter Njonde on 2021-12-26.
//

import SwiftUI
import Firebase

@main
struct MoneyCheakApp: App {
    @StateObject var info = Info()
    @StateObject var addservice = AddService()
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(info)
                .environmentObject(addservice)
                
        }
    }
}
