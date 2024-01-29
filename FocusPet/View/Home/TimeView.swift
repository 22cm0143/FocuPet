//
//  TimeView.swift
//  FocusPet
//
//  Created by 刘诚志 on 2023/11/28.
//
/*
 TODO:
    1.単日繰り返す回数で繰り返す
    2.超えたらAlertで聞く（続けるかどうか
 */

import SwiftUI
import RealmSwift

struct TimeView: View {
    
    @ObservedObject var timerContorller: TimerModel
    @Environment(\.dismiss) var dismiss
   
    var body: some View {
      
        NavigationStack{
            
            VStack(alignment: .center){
                Text(timerContorller.formattedTimer())
                    .font(.system(size: 80))
                    .fontWeight(.bold)
                    .fontDesign(.monospaced)
                    .foregroundColor(Color.orange)
                
                //PET IMAGE
                Image("cat1")
                    .resizable()
                    .frame(width: 500,height: 500)
                HStack{
                    
                    Button(action: {
                        timerContorller.isFullScreen = true
                    }, label: {
                       Image("full")
                            .resizable()
                            .frame(width: 45,height: 45)
                            .padding()
                    })
                    .fullScreenCover(isPresented: $timerContorller.isFullScreen) {
                        FullScreenTimeView(timerContorller: timerContorller)
                    }
                           

                    
                    
                    //MARK: START/STOP BUTTON
                    Button (action: {
                        timerContorller.toggleTimer()
                    } ){
                        Image(timerContorller.isRunning ? "stopcount" : "startcount")
                            .resizable()
                            .frame(width: 70,height: 70)
                            .padding()
                    }
                   .alert("タイマーを中止ニャッ？",isPresented: $timerContorller.isShowStopAlert){
                        Button("はニャー",role: .destructive){
                        //TODO: COIN
                            timerContorller.stopTimer()
                            timerContorller.reSet()
                            dismiss()
                        }
                        
                        Button("いニャッ",role: .cancel){
                            timerContorller.toggleTimer()
                        }
                    } message: {
                        Text("タイマーニャッ中止すると５コインニャッ消費されニャーン！")
                    }

                }//HSTACK
                     
            
            }//VSTACK
            .navigationBarBackButtonHidden(true)
            .padding(20)
            .alert("休みニャッ！",isPresented: $timerContorller.isShowRestAlert){
                 Button("はい",role: .destructive){
                     timerContorller.isRestView = true
                     timerContorller.startRest()
                     
                 }
                 //SKIP REST
                 Button("いいえ",role: .cancel){
                     timerContorller.skipRest()
                     timerContorller.startTimer()
                 }
             } message: {
                 Text("ニャオウ！ニャオウ！ニャーンニャーンニャーンニャッ！")
             }
             .navigationDestination(isPresented: $timerContorller.isRestView){
                 BreakView(timerContorller: timerContorller)
             }
             
        
            Spacer()
        }//NavigationStack
        .navigationBarBackButtonHidden(true)
  
    }//BODY
    
}

#Preview {
    TimeView( timerContorller: TimerModel())
        
}
