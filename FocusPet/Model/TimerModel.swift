//
//  TimerModel.swift
//  FocusPet
//
//  Created by 刘诚志 on 2023/12/04.
//

import Foundation
import Combine
import RealmSwift


class TimerModel: ObservableObject{
    
    @Published var timerData: TimerData?

    //time view data
    @Published var timerCount: TimeInterval
    @Published var restShortCount: TimeInterval

    @Published var viewCoin: Int
    @Published var viewHunger: Int
    
    @Published var timer: Timer?
    @Published var rest: Timer?
    @Published var hungerTimer: Timer?
    
    
    
    @Published var isRunning: Bool = false
    @Published var isTimeView: Bool = false
    @Published var isShowStopAlert: Bool = false
    @Published var isShowRestAlert: Bool = false
    @Published var isFullScreen: Bool = false
    @Published var isRestView: Bool = false
    @Published var isShowRestartAlert: Bool = false
    
    
   

    
    init() {
        
        self.timerCount = 600
        self.restShortCount = 300
        self.viewCoin = 99
        self.viewHunger = 88
        
        loadData()
        startHungerTimer()
        
        }
    
    // 更新
    func loadData() {
            let realm = try! Realm()
            if let updatedTimerData = realm.objects(TimerData.self).first {
                self.timerData = updatedTimerData
                self.timerCount = updatedTimerData.timeTimer
                self.restShortCount = updatedTimerData.timeShort
                self.viewCoin = updatedTimerData.coin
                self.viewHunger = updatedTimerData.hunger
            }
        }
    
    //饱食度
    func startHungerTimer() {
            hungerTimer = Timer.scheduledTimer(withTimeInterval: 3600, repeats: true) { [weak self] _ in
                self?.decreaseHunger()
            }
        }
    
    func decreaseHunger() {
        
        
           guard let timerData = self.timerData else { return }
           let realm = try! Realm()
           try! realm.write {
               let now = Date()
               let difference = Calendar.current.dateComponents([.hour], from: timerData.hungerDate, to: now)
    
               timerData.hunger -= Int(difference.hour ?? 0)
               timerData.hungerDate = now
               
               if timerData.hunger < 0 {
                   timerData.hunger = 0
               }
           }

           self.viewHunger = timerData.hunger
       }
    
//    func lastHunger() {
//        
//        if let lastExitTime = UserDefaults.standard.object(forKey: "lastExitTime") as? Date {
//            
//            let now = Date()
//            
//            let difference = Calendar.current.dateComponents([.hour], from: lastExitTime, to: now)
//            
//            if let minuteDifference = difference.minute {
//                guard let timerData = self.timerData else { return }
//                let realm = try! Realm()
//
//                try! realm.write {
//                    
//                    timerData.hunger -= Int(minuteDifference)
//                    
//                    if timerData.hunger < 0 {
//                        timerData.hunger = 0
//                    }
//                }
//
//                self.viewHunger = timerData.hunger
//            }
//        }
//       
//    }


    
    //    //コイン消費
    //    func coinPaid() {
    //
    //        timerData.coin -= 5
    //    }
       
   
    //タイマーTOGGLE
    func toggleTimer(){
        
        isRunning.toggle()
        
        if isRunning{
            startTimer()
        } else {
            stopTimer()
            isShowStopAlert = true
            
        }
    }
    

    //タイマー時間表示
    func formattedTimer() -> String {
        let minutes = Int(timerCount) / 60
        let second = Int(timerCount) % 60
        return String(format: "%02d:%02d", minutes, second)
    }
    //休み時間表示
    func formattedRest() -> String {
        let minutes = Int(restShortCount) / 60
        let second = Int(restShortCount) % 60
        return String(format: "%02d:%02d", minutes, second)
    }
    
    //タイマー開始
    func startTimer(){
            
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ [self]_ in
                if timerCount > 0 {
                    timerCount -= 1
                }else{
                    stopTimer()
                    //isRestView = true
                    isShowRestAlert = true
                    timerCount =  timerData!.timeTimer
                
                }
            }

        }
    //タイマー停止
    func stopTimer(){
        isRunning = false
        timer?.invalidate()
    }
    
    //start rest when the rest runs out restart timer
    func startRest(){
            
            rest = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ [self]_ in
                if restShortCount > 0 {
                    restShortCount -= 1
                }else{
                    skipRest()
                    isTimeView = true
                    isRestView = false
                    startTimer()
                    restShortCount =  timerData!.timeShort
                }
                }

        }
    
    //skip rest and restart timer
    func skipRest(){
        
        rest?.invalidate()
        restShortCount =  timerData!.timeShort
    }
    
    func reSet() {
        timerCount = timerData!.timeTimer
    }

}

