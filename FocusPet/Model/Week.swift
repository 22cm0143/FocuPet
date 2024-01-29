//
//  Week.swift
//  FocusPet
//
//  Created by 刘诚志 on 2023/11/27.
//

import SwiftUI
import RealmSwift

enum Week: String, CaseIterable, PersistableEnum {
    
    case mon

    
    var week: Int {
        switch self{
        case .mon:
            return 1
        }
    }
}
