//
//  ShopCatVIewModel.swift
//  FocusPet
//
//  Created by 刘诚志 on 2024/01/16.
//

import SwiftUI
import RealmSwift



struct ShopCatVIewModel: View {
    
    @ObservedObject var catContorller: CatModel
    
      
    var body: some View {
        ScrollView{
            VStack{
                ForEach(catContorller.cats, id: \.id) { cat in
                    NavigationLink(
                        destination: SubShopView(timerContorller: TimerModel(),catContorller: CatModel(), timerData: TimerData(), cat: cat)){
                            CatRow(cat: cat)
                        }
                    
                }
            }
        }
        
    }
}

struct CatRow: View {
    
    @ObservedRealmObject var cat : Cat
    
    var body: some View {
        ZStack{
            Image(cat.catimage)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
                .frame(height: 150)
            HStack{
                Spacer()
                Image(systemName: "checkmark.seal")
                    .foregroundColor(cat.isBought ? .orange : .gray)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .padding()
            }
            
        }
        .background(cat.isSelected ?  Color.orange.opacity(0.2) : Color.white)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.orange,lineWidth: 2)
        )
        .padding()
    }
}

#Preview {
    ShopCatVIewModel(catContorller: CatModel())
}
