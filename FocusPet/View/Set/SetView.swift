//
//  SetView.swift
//  FocusPet
//
//  Created by 刘诚志 on 2023/11/27.
//

import SwiftUI

struct SetView: View {
    
    @Environment(\.dismiss) var dismiss
        
    
    var body: some View {
        VStack{
            
            HStack{
                Text("ポロジェット管理")
                Spacer()
                NavigationLink(destination: ProjectView(timerContorller: TimerModel(),weekController: WeekModel())){
                    Image("next")
                        .resizable()
                        .frame(width: 30,height: 30)
                }
            }
            .padding()
            
            HStack{
                Text("ペットショップ")
                Spacer()
                NavigationLink(destination: ShopView(timerContorller: TimerModel())){
                    Image("next")
                        .resizable()
                        .frame(width: 30,height: 30)
                }
            }
            .padding()
            
            
            HStack{
                Text("通知管理")
                Spacer()
                NavigationLink(destination: InformView()){
                    Image("next")
                        .resizable()
                        .frame(width: 30,height: 30)
                }
            }
            .padding()
            
            
            HStack{
                Text("使用ガイド")
                Spacer()
                NavigationLink(destination: GuideView()){
                    Image("next")
                        .resizable()
                        .frame(width: 30,height: 30)
                }
            }
            .padding()
            
            HStack{
                Text("利用規約")
                Spacer()
                NavigationLink(destination: AgreementView()){
                    Image("next")
                        .resizable()
                        .frame(width: 30,height: 30)
                }
            }
            .padding()
            
            
        Spacer()
            
 
            
        }//VSTACK
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
        }//TOOLBAR
        .padding(.top, -30.0)
        
    }//BODY
       
}//SET VIEW

#Preview {
    SetView()
}
