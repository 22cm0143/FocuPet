//
//  FocusPetApp.swift
//  FocusPet
//
//  Created by 刘诚志 on 2023/11/27.
//

import SwiftUI

@main
struct FocusPetApp: App {
    
    init() {
        RealmManager().realmManager()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.colorScheme, .light)
           
        }
    }
}

