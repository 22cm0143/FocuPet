//
//  HomePage.swift
//  FocusPet
//
//  Created by 刘诚志 on 2023/11/27.
//

/*
 TODO: 
    1.今日待完成任务数
    2.和宠物的点击互动
 */

import SwiftUI
import RealmSwift

struct HomePage: View {
    
    @ObservedObject var timerContorller: TimerModel
    //@ObservedRealmObject var timerData : TimerData

   
    var body: some View {
        
        NavigationView{
          
            VStack(alignment: .center){
                
                VStack(alignment: .leading){
                    ProgressView(value: Double(timerContorller.viewHunger),total: 100)
                        .padding([.top, .leading, .trailing])
                        .tint(Color.orange)
                    Text("飽食度:\(timerContorller.viewHunger)/100")
                        .font(/*@START_MENU_TOKEN@*/.caption/*@END_MENU_TOKEN@*/)
                        .padding(.horizontal)
                        
                        

                        
                }//vstack
                .position(CGPoint(x: 200.0, y: -30.0))
                .toolbar{
                        //reportButton
                        ToolbarItem(placement: .topBarLeading){
                            NavigationLink {
                                    ReportView()
                            } label: {
                                Image("reportIcon")
                                    .resizable()
                                    .frame(width: 30,height: 20)
                                }
                        }
                        
                        //focuspet
                        ToolbarItem(placement:.principal){
                            Image("foucspet")
                                .resizable()
                                .frame(width: 160,height: 30)
                        }
                        
                        //settingButton
                        ToolbarItem(placement:.topBarTrailing){
                            NavigationLink {
                                    SetView()
                            } label: {
                                Image("setIcon")
                                    .resizable()
                                    .frame(width: 30,height: 30)
                                }
                        
                        }
                            
                    }//toolbar
                
                //PET IMAGE
                Image("cat1")
                    .resizable()
                    .frame(width: 500,height: 500)
                    

                // TO TIMEPAGE
                NavigationLink(destination: TimeView(timerContorller: TimerModel())){
                    Image("start")
                        .resizable()
                        .frame(width: 130,height: 50)
                        .padding()
                }
             
                
                Spacer()
                     
                
            }//Vstack 1
            
                   
        }//navigationview
       
    }//body
}//homepage

#Preview {
    HomePage(timerContorller: TimerModel())
}
