//
//  SubShopView.swift
//  FocusPet
//
//  Created by 刘诚志 on 2024/01/16.
//

import SwiftUI
import RealmSwift

struct SubShopView: View {

    @Environment(\.realm) var realm
    @Environment(\.dismiss) var dismiss
    @ObservedObject var timerContorller: TimerModel
    @ObservedObject var catContorller: CatModel
    
    @ObservedRealmObject var timerData : TimerData
    @ObservedRealmObject var cat: Cat
    
    
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
                Text("コイン：\(timerData.coin)")
                    .foregroundColor(.orange)
                    .font(.title2)
                Spacer()
            }
            .padding()
            
            Image(cat.catimage)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
                .padding()
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.orange,lineWidth: 2)
                )
            
            
            Button(action:{
                
                catContorller.isBuyAlert = true
               
            }) {
                Text(cat.isBought ? "購入済み" : "\(cat.price)")
                    .frame(width:150,height: 50)
                    .font(cat.isBought ? .title : .largeTitle)
                    .background(cat.isBought ? Color.orange : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(40)
                    .padding()
            }
            .alert("\(cat.price)コインで購入しますか？",isPresented: $catContorller.isBuyAlert){
                Button("はい",role: .destructive){
                    try? realm.write{
                        timerData.coin -= cat.price
                        cat.isBought = true
                    }
                }
                
                Button("いいえ",role: .cancel){
                    //
                }
            }
            .disabled(cat.isBought)
            .padding()
            
            Button(action:{
                //
                cat.isSelected ? catContorller.isCancelAlert.toggle() : catContorller.isSelectAlert.toggle()
                
                
            }) {
                Text(cat.isSelected ? "選択済み" : "選択する")
                    .frame(width:150,height: 50)
                    .font(.title)
                    .background(cat.isSelected ? Color.orange : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(40)
                    .padding()
            }
            .alert("これを選択しますか？",isPresented: $catContorller.isSelectAlert){
                Button("はい",role: .destructive){
                    try? realm.write{
                        cat.isSelected = true
                    }
                }
                
                Button("いいえ",role: .cancel){
                    //
                }
            }
            .alert("選択をキャンセルしますか？",isPresented: $catContorller.isCancelAlert){
                Button("はい",role: .destructive){
                    try? realm.write{
                        cat.isSelected = false      
                    }
                }
                
                Button("いいえ",role: .cancel){
                    //
                }
            }
            .padding(.top, -30.0)
            
            Spacer()
                

        }//VStack
        .navigationBarBackButtonHidden(true)
        //.navigationTitle("")
        .padding()
    }
}



#Preview {
    SubShopView(timerContorller: TimerModel(),catContorller: CatModel(), timerData: TimerData(), cat: Cat(price: 25,catname: "Cat1", catimage: "cat1",isBought: false,isSelected: false))
}
