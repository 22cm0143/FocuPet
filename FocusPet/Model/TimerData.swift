//
//  TimerData.swift
//  FocusPet
//
//  Created by 刘诚志 on 2024/01/19.
//

import Foundation
import RealmSwift

class TimerData: Object,ObjectKeyIdentifiable{
    
    @Persisted(primaryKey: true) var id: ObjectId
    
    //project data
    @Persisted var timeTimer: Double 
    @Persisted var timeShort: Double
    @Persisted var timeLong: Double
    @Persisted var numBreak: Int
    @Persisted var numDayGoal: Int
    @Persisted var startDate = Date()
    @Persisted var endDate = Date()
    @Persisted var hungerDate = Date()
    
    
    //other
    @Persisted var coin : Int
    @Persisted var hunger: Int
    

}
