//
//  WeekModel.swift
//  FocusPet
//
//  Created by 刘诚志 on 2024/01/18.
//

import Foundation
import RealmSwift
import Foundation
import RealmSwift

class WeekModel: ObservableObject {
    private var realm: Realm
    @Published var weeks: [Week]

    init() {
        do {
            realm = try Realm()
        } catch {
            print("Unable to initialize Realm: \(error)")
            fatalError("Realm initialization failed.")
        }

        let storedWeeks = realm.objects(Week.self)

       
        if storedWeeks.isEmpty {
            weeks = [
                Week(id: 1, weekdays: "日", isWeekSelected: false),
                Week(id: 2, weekdays: "月", isWeekSelected: false),
                Week(id: 3, weekdays: "火", isWeekSelected: false),
                Week(id: 4, weekdays: "水", isWeekSelected: false),
                Week(id: 5, weekdays: "木", isWeekSelected: false),
                Week(id: 6, weekdays: "金", isWeekSelected: false),
                Week(id: 7, weekdays: "土", isWeekSelected: false)
            ]

            try? realm.write {
                realm.add(weeks)
            }
        } else {
            weeks = Array(storedWeeks)
        }
    }

    var selectedWeekdays: [Int] {
        weeks.filter { $0.isWeekSelected }.map { $0.id }
    }
    
    func updateWeek(week: Week) {
            let realm = try! Realm()
            try! realm.write {
                week.isWeekSelected.toggle()
            }
           
            self.weeks = Array(realm.objects(Week.self))
        }
}


class Week: Object, ObjectKeyIdentifiable {
    
    @Persisted var id: Int
    @Persisted var weekdays: String
    @Persisted var isWeekSelected: Bool
    
    convenience init(id: Int, weekdays: String, isWeekSelected: Bool) {
        self.init()
        self.id = id
        self.weekdays = weekdays
        self.isWeekSelected = isWeekSelected
    }
}
