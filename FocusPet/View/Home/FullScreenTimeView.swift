//
//  FullScreenTimeView.swift
//  FocusPet
//
//  Created by 刘诚志 on 2023/12/05.
//
/*
 TODO:
    .fullScreenCover
    タイマー終わったらalertで休みかどうかを聞く
    Full休み画面に飛ぶとかSKIPとか
    SKIPしたら自動的にスタートする
 */
import SwiftUI

struct FullScreenTimeView: View {
    
    @ObservedObject var timerContorller: TimerModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(alignment: .center){
            
            
            //PET IMAGE
            Image("cat1")
                .resizable()
                .frame(width: 500,height: 500)
                .rotationEffect(.degrees(90))
            
            
            VStack{
                Text(timerContorller.formattedTimer())
                    .font(.system(size: 40))
                    .fontWeight(.bold)
                    .padding(.horizontal, 20.0)
                    .fontDesign(.monospaced)
                    .foregroundColor(Color.orange)
                
                //TODO: icon变更
                Button(action: {
                    dismiss()
                }, label: {
                    Image("backfull")
                        .resizable()
                        .frame(width: 40,height: 40)
                })
            }//VStack
            .rotationEffect(.degrees(90))
            .padding()
            
 
        }//HStack
        //.rotationEffect(.degrees(-90))
        
    }
       
        
}


#Preview {
    FullScreenTimeView(timerContorller: TimerModel())
}
