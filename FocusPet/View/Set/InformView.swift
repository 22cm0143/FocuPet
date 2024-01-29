//
//  InformView.swift
//  FocusPet
//
//  Created by 刘诚志 on 2023/11/28.
//

import SwiftUI

struct InformView: View {
    
    @State private var isInform: Bool = false
    @State private var selectedTime: Date = Calendar.current.date(bySettingHour: 20, minute: 0, second: 0, of: Date()) ?? Date()
        
    
    var body: some View {
        
        VStack{
            HStack{
                Text("定時通知 ：")
                Spacer()
                Toggle("", isOn: $isInform)
                    .tint(isInform ? .orange : .gray)
                    .labelsHidden()
            }
            .padding()
            
            
            
            DatePicker("选择时间",selection: $selectedTime,displayedComponents: .hourAndMinute)
                .scaleEffect(1.5)
                    .labelsHidden()
                    .accentColor(.orange)
                    .datePickerStyle(CompactDatePickerStyle())
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top)
            
            Spacer()
                    
        }//VSTACK
        .padding()
       
                           
    }//BODY
}

#Preview {
    InformView()
}
