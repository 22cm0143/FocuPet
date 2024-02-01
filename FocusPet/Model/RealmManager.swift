//
//  RealmManager.swift
//  FocusPet
//
//  Created by 刘诚志 on 2024/01/22.
//

import Foundation
import RealmSwift

class RealmManager{
    
    func realmManager(){
        
        do {
            // 创建或获取 Realm 实例
            let realm = try Realm()

            // 创建 TimerData 对象
            let timerData = TimerData()
            
            timerData.timeTimer = 1500
            timerData.timeShort = 300
            timerData.timeLong = 900
            timerData.numBreak = 4
            timerData.numDayGoal = 1
            timerData.startDate = Date()
            timerData.endDate = Date()
            timerData.hungerDate = Date()
            
            timerData.coin = 200
            timerData.hunger = 100
      
            // 创建 Cat 对象
            let existingCats = realm.objects(Cat.self).map { $0.catname }
            let cats = [Cat(price: 0, catname: "Cat1", catimage: "cat1", isBought: true, isSelected: true),
                        Cat(price: 30, catname: "Cat2", catimage: "cat1", isBought: false, isSelected: false),
                        Cat(price: 35, catname: "Cat3", catimage: "cat1", isBought: false, isSelected: false)
                        ]
            let catsToAdd = cats.filter { !existingCats.contains($0.catname) }

            
            // 创建 Week 对象
            let existingWeeks = realm.objects(Week.self).map{$0.weekdays}
            let weeks = [Week(id: 1, weekdays: "日", isWeekSelected: false),
                         Week(id: 2, weekdays: "月", isWeekSelected: false),
                         Week(id: 3, weekdays: "火", isWeekSelected: false),
                         Week(id: 4, weekdays: "水", isWeekSelected: false),
                         Week(id: 5, weekdays: "木", isWeekSelected: false),
                         Week(id: 6, weekdays: "金", isWeekSelected: false),
                         Week(id: 7, weekdays: "土", isWeekSelected: false)
                        ]
            let weeksToAdd = weeks.filter{ !existingWeeks.contains($0.weekdays)}
           

            // 将对象保存到 Realm 数据库
            try realm.write {
               
                realm.add(timerData)
                
                realm.add(catsToAdd)
                
                realm.add(weeksToAdd)
            }
        } catch {
            print("An error occurred while writing to Realm: \(error)")
        }
    }
}
