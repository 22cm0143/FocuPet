//
//  WeekPicker.swift
//  FocusPet
//
//  Created by 刘诚志 on 2024/01/04.
//

import SwiftUI
import RealmSwift

struct WeekPicker: View {
    
    @ObservedObject var weekController: WeekModel
   
    
    var body: some View {
        HStack(spacing: 20) {
            ForEach(weekController.weeks, id: \.id) { week in
                WeekRow( week: week)
                   }
               }
              
    }
}

struct WeekRow: View {
    

    var week : Week
    
    var body: some View {
        
        Button(action: {
            //TODO: REALM Save isWeekSelected
           let realm = try? Realm()
            try? realm?.write{
                self.week.isWeekSelected.toggle()
            }
        }) {
            Text(week.weekdays)
                .foregroundColor(.white)
                .frame(width: 35, height: 35)
                .background(week.isWeekSelected ? Color.orange : Color.gray)
                .clipShape(Circle())
                .font(.title3)
        }
       
    }
}

#Preview {
    WeekPicker(weekController: WeekModel())
    
}
