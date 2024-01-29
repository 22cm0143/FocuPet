//
//  BreakView.swift
//  FocusPet
//
//  Created by 刘诚志 on 2023/12/06.
//

import SwiftUI

struct BreakView: View {
    @ObservedObject var timerContorller: TimerModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
       VStack(alignment: .center){
            
            
            //PET IMAGE
            Image("cat1")
                .resizable()
                .frame(width: 500,height: 500)
            
            
           VStack{
                Text(timerContorller.formattedRest())
                    .font(.system(size: 40))
                    .fontWeight(.bold)
                    .padding(.horizontal, 20.0)
                    .fontDesign(.monospaced)
                    .foregroundColor(Color.orange)
                //TODO: icon变更
                Button(action: {
                    timerContorller.isShowRestartAlert = true
    
                }, label: {
                    Image("stopcount")
                        .resizable()
                        .frame(width: 40,height: 40)
                })
                .alert("休みをスキップニャン？！",isPresented: $timerContorller.isShowRestartAlert){
                     Button("はニャ",role: .destructive){
                         
                         timerContorller.skipRest()
                         timerContorller.isRestView = false
                         timerContorller.isTimeView = true
                         
                         timerContorller.startTimer()
                         
                     }
                     //SKIP REST
                     Button("いニャン",role: .cancel){
                         
                     }
                 } message: {
                     Text("ニャッニャ！")
                 }
            }//VStack2
           .navigationDestination(isPresented: $timerContorller.isTimeView){
               TimeView(timerContorller: timerContorller)
           }
 
        }//VStack1
       .navigationBarBackButtonHidden(true)
        
    }
       
        
}

#Preview {
    BreakView(timerContorller: TimerModel())
}
