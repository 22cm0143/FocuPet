//
//  ShopView.swift
//  FocusPet
//
//  Created by 刘诚志 on 2023/11/28.
//

import SwiftUI
import RealmSwift

struct ShopView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var timerContorller: TimerModel
    
   
    var body: some View {
        VStack{
            HStack{
                Button(action: {
                    dismiss()
                }, label: {
                    Image("Back")
                        .resizable()
                        .frame(width: 20,height: 20)
                })
                Spacer()
                Text("ショップ")
                    .font(/*@START_MENU_TOKEN@*/.title2/*@END_MENU_TOKEN@*/)
                Spacer()
            }
            .padding()
            HStack {
                Text("コイン：\(timerContorller.viewCoin)")
                    .foregroundColor(.orange)
                    .font(.title2)
                Spacer()
                Button(action: {
                    // 执行确认或其他操作
                }) {
                    Image(systemName: "questionmark.circle")
                        .foregroundColor(.orange)
                }
            }
            .padding()
            
            ShopCatVIewModel(catContorller: CatModel())
            

        }//VStack
        .navigationBarBackButtonHidden(true)
        //.navigationTitle("")
        .padding(.top,-20)
    }//body
}

#Preview {
    ShopView(timerContorller: TimerModel())
}
