//
//  ReportView.swift
//  FocusPet
//
//  Created by 刘诚志 on 2023/11/27.
//

import SwiftUI

struct ReportView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var calendarView: CalendarViewController
    
    var body: some View {
        ScrollView{
            VStack(alignment:.leading){
                Text("ポロジェット時間：")
                
                ZStack{
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 100)
                
                    HStack{
                        VStack{
                            Text("125")
                                .font(.system(size: 45))
                                .fontWeight(.bold)
                                .fontDesign(.monospaced)
                                .foregroundColor(Color.orange)
                            Text("今日分数")
                        }
                        Spacer()
                        VStack{
                            Text("425")
                                .font(.system(size: 45))
                                .fontWeight(.bold)
                                .fontDesign(.monospaced)
                                .foregroundColor(Color.orange)
                            Text("今週分数")
                        }
                        Spacer()
                        VStack{
                            Text("925")
                                .font(.system(size: 45))
                                .fontWeight(.bold)
                                .fontDesign(.monospaced)
                                .foregroundColor(Color.orange)
                            Text("今月分数")
                        }
                    }//HSTACK
                    .padding(.horizontal, 20.0)
          
                }
                Spacer()
                
                Text("進行中の目標：")
                
                ZStack{
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 100)
                
                    HStack{
                        VStack{
                            Text("60")
                                .font(.system(size: 45))
                                .fontWeight(.bold)
                                .fontDesign(.monospaced)
                                .foregroundColor(Color.orange)
                            Text("目標日数")
                        }
                        Spacer()
                        VStack{
                            Text("6")
                                .font(.system(size: 45))
                                .fontWeight(.bold)
                                .fontDesign(.monospaced)
                                .foregroundColor(Color.orange)
                            Text("完成日数")
                        }
                        Spacer()
                        VStack{
                            Text("15%")
                                .font(.system(size: 45))
                                .fontWeight(.bold)
                                .fontDesign(.monospaced)
                                .foregroundColor(Color.orange)
                            Text("消化率")
                        }
                    }//HSTACK
                    .padding(.horizontal, 20.0)
          
                }
                Spacer()
                
                Text("目標カレンダー：")
                
                ZStack{
                      
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 400)
                    
                    CalendarViewRepresentable()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        
                
          
                }
                
            }//VStack
            
        }// ScrollView
        .padding()
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
            }//TOOLBARITEM１
            ToolbarItem(placement: .principal){
                Text("レポート")
            }
        }//toolbar
        
    }//body
    
}

#Preview {
    ReportView()
}
