//
//  ProjectModel.swift
//  FocusPet
//
//  Created by 刘诚志 on 2024/01/15.
//

import Foundation
import RealmSwift
import Combine

class ProjectModel:ObservableObject{
    
    @Published var timeTimer: Double = 25
    @Published var timeShort: Double = 5
    @Published var timeLong: Double = 15
    @Published var numBreak: Int = 1
    @Published var numDayGoal: Int = 1
    @Published var startDate = Date()
    @Published var endDate = Date()
}
