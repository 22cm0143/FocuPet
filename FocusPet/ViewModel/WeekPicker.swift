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
                WeekRow( weekController: WeekModel(), week: week)
                   }
               }
        
              
    }
}

struct WeekRow: View {
    
    @ObservedObject var weekController: WeekModel

    var week : Week
    
    var body: some View {
        
        Button(action: {
            //TODO: REALM Save isWeekSelected
            self.weekController.updateWeek(week: week)
        }) {
            Text(week.weekdays)
                .foregroundColor(.white)
                .frame(width: 35, height: 35)
                .background(self.week.isWeekSelected ? Color.orange : Color.gray)
                .clipShape(Circle())
                .font(.title3)
        }
       
    }
}

#Preview {
    WeekPicker(weekController: WeekModel())
    
}
