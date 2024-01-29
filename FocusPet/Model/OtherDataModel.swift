//
//  OtherDataModel.swift
//  FocusPet
//
//  Created by 刘诚志 on 2024/01/16.
//

import Foundation
import RealmSwift

class OtherDataModel: ObservableObject{
    @Published var coin: Int = 200
    @Published var hunger: Int = 100
    
   

    func hungerDown() {
        
    }
}

