//
//  ProjectView.swift
//  FocusPet
//
//  Created by 刘诚志 on 2023/11/28.
//



import SwiftUI
import RealmSwift

struct ProjectView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var timerContorller: TimerModel
    @ObservedObject var weekController: WeekModel
    @ObservedRealmObject var timerData : TimerData
   
    init(timerContorller: TimerModel, weekController: WeekModel) {
        let realm = try! Realm()
        let timerData = realm.objects(TimerData.self).first
        self.timerContorller = timerContorller
        self.weekController = weekController
        self._timerData = ObservedRealmObject(wrappedValue: timerData ?? TimerData())
    }
    
    var body: some View {
        VStack{
            //タイマー
            VStack(alignment:.leading){
                Text("タイマー：\(Int(timerData.timeTimer / 60)) / 60")
                Slider(value: $timerData.timeTimer, in: 600...3600,step: 300)
                                    .accentColor(.orange)
                                    .padding(.bottom, 20.0)
                                    .padding(.top, 15.0)
            }
            
        
            //短い休憩
            VStack(alignment:.leading){
                Text("短い休憩：\(Int(timerData.timeShort / 60)) / 20")
                Slider(value: $timerData.timeShort, in: 60...1200,step: 60)
                                    .accentColor(.orange)
                                    .padding(.bottom, 20.0)
                                    .padding(.top, 15.0)
            }
           
          
            //長い休憩
            VStack(alignment:.leading){
                Text("長い休憩：\(Int(timerData.timeLong / 60)) / 40")
                Slider(value: $timerData.timeLong, in: 300...2400,step: 300)
                                    .accentColor(.orange)
                                    .padding(.bottom, 20.0)
                                    .padding(.top, 15.0)
            }
            
            
            //何回毎に長い休憩
            HStack{
                Text("何回毎に長い休憩：")
                Spacer()
                Picker("NUM", selection: $timerData.numBreak) {
                            ForEach(1...10, id: \.self) { number in
                                Text("\(number)")
                                   
                            }
                } .accentColor(.orange)
            }
           
           
            //単日繰り返す目標数
            HStack{
                Text("単日繰り返す目標数：")
                Spacer()
                Picker("NUM", selection: $timerData.numDayGoal) {
                            ForEach(1...20, id: \.self) { number in
                                Text("\(number)")
                                   
                            }
                } .accentColor(.orange)
            }
            
            //持続期間
            HStack{
                Text("持続期間：")
                HStack{
                    DatePicker("", selection: $timerData.startDate, displayedComponents: .date)
                        .accentColor(.orange)
                        
                    Text(" ~")
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                        .foregroundColor(Color.orange)
                    
                    DatePicker("", selection: $timerData.endDate, displayedComponents: .date)
                        .accentColor(.orange)
     
                }
                .padding(.leading, -20.0)
                
                
            }
            
   
        
            //繰り返す曜日
            VStack(alignment: .leading){
                Text("繰り返す曜日：")
                .padding(.bottom)
                .padding(.leading,10 )
                HStack(alignment: .center){
                    Spacer()
                    WeekPicker(weekController:  weekController)
                }
            }
            
           
       
            
        }//VStack
        .navigationBarBackButtonHidden(true)
        .toolbar{
            ToolbarItem(placement: .topBarLeading){
                Button(action: {
                    dismiss()
                }, label: {
                    Image("Back")
                        .resizable()
                        .frame(width: 20,height: 20)
                })
                
            }//TOOLBARITEM
            ToolbarItem(placement: .topBarTrailing){
                Button(action: {
                    upTimerData()
                    dismiss()
                }, label: {
                    Image("Save")
                        .resizable()
                        .frame(width: 20,height: 20)
                })
                
            }//TOOLBARITEM
        }//TOOLBAR
        //.padding(.top,20)
        .padding()
        
        Spacer()
       
    }//body
        
}

extension ProjectView {
    
    
    func upTimerData() {
        
        let realm = try! Realm()
       
        if let timerData = realm.objects(TimerData.self).first{
            try! realm.write{
                timerData.timeTimer = $timerData.timeTimer.wrappedValue
                timerData.timeLong = $timerData.timeLong.wrappedValue
                timerData.timeShort = $timerData.timeShort.wrappedValue
                timerData.numBreak = $timerData.numBreak.wrappedValue
                timerData.numDayGoal = $timerData.numDayGoal.wrappedValue
                timerData.startDate = $timerData.startDate.wrappedValue
                timerData.endDate = $timerData.endDate.wrappedValue
            }
        }
        
        timerContorller.timerData = timerData
    }
}

#Preview {
    ProjectView(timerContorller: TimerModel(),weekController: WeekModel())
}
