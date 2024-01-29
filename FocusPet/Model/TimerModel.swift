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

    //timer view data
    @Published var timerCount: TimeInterval
    @Published var restShortCount: TimeInterval

    @Published var viewCoin: Int
    @Published var viewHunger: Int
    
    @Published var timer: Timer?
    @Published var rest: Timer?
    
    
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
        
        let realm = try! Realm()
        timerData = realm.objects(TimerData.self).first
        
        if let timerData = self.timerData {
            self.timerCount = timerData.timeTimer
            self.restShortCount = timerData.timeShort
            self.viewCoin = timerData.coin
            self.viewHunger = timerData.hunger
               }
        
        }
    
    //饱食度
    func updateHunger() {
            guard let timerData = timerData else { return }

            let realm = try! Realm()
            try! realm.write {
                if timerData.hunger > 0 {
                    timerData.hunger -= 1
                }
            }
        }
    
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

