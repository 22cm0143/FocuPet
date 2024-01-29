//
//  CalendarViewController.swift
//  FocusPet
//
//  Created by 刘诚志 on 2023/12/18.
//

import UIKit
import SwiftUI
import FSCalendar

struct CalendarViewRepresentable: UIViewControllerRepresentable {
    
    // 创建 CalendarViewController 实例
    func makeUIViewController(context: Context) -> CalendarViewController {
        
        return CalendarViewController(timerData: TimerData(),weekModel: WeekModel())
    }

    // 更新 CalendarViewController
    func updateUIViewController(_ uiViewController: CalendarViewController, context: Context) {
        // 这里可以更新你的视图控制器，如果有必要的话
    }
}

struct DateRange {
    
    var startDate: Date
    var endDate: Date
    
}



class CalendarViewController: UIViewController, ObservableObject {

    var calendarView = FSCalendar()
    // 初始化为某个日期范围
    var dateRange : DateRange
    // 初始化为选中的星期天数
    var weekModel: WeekModel

    init(timerData: TimerData, weekModel: WeekModel) {
            self.dateRange = DateRange(startDate: timerData.startDate, endDate: timerData.endDate)
            self.weekModel = weekModel
            super.init(nibName: nil, bundle: nil)
        }

    
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

    override func viewDidLoad() {
        super.viewDidLoad()
    
       
    // 设置 FSCalendar
    setupCalendarView()
    setupCalendar()
    }

    private func setupCalendarView() {
        view.addSubview(calendarView)
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: view.topAnchor),
            calendarView.leftAnchor.constraint(equalTo: view.leftAnchor),
            calendarView.rightAnchor.constraint(equalTo: view.rightAnchor),
            calendarView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        
        calendarView.dataSource = self
        calendarView.delegate = self
       
    }
    
    

    
    private func setupCalendar() {
        
       
        //字体大小变更
        calendarView.appearance.titleFont = UIFont.systemFont(ofSize: 18, weight: .regular)
        calendarView.appearance.weekdayFont = UIFont.systemFont(ofSize: 20, weight: .regular)
        
        //UIFont.systemFont(ofSize: 14, weight: .regular)
        //标题颜色
        calendarView.appearance.headerTitleColor = UIColor.black
        calendarView.appearance.weekdayTextColor = UIColor.black
        calendarView.appearance.titleDefaultColor = UIColor.black
        
        //年月、曜日を日本語に変更
        calendarView.appearance.headerDateFormat = "YYYY年MM月"
        calendarView.calendarWeekdayView.weekdayLabels[0].text = "日"
        calendarView.calendarWeekdayView.weekdayLabels[1].text = "月"
        calendarView.calendarWeekdayView.weekdayLabels[2].text = "火"
        calendarView.calendarWeekdayView.weekdayLabels[3].text = "水"
        calendarView.calendarWeekdayView.weekdayLabels[4].text = "木"
        calendarView.calendarWeekdayView.weekdayLabels[5].text = "金"
        calendarView.calendarWeekdayView.weekdayLabels[6].text = "土"
        

//        // calendarの曜日部分の色を変更
//        calendarView.calendarWeekdayView.weekdayLabels[0].textColor = .systemRed
//        calendarView.calendarWeekdayView.weekdayLabels[6].textColor = .systemRed
//        

        
       
        
        //最初に今日の日付を選択する
        let myDate = Date()
        let tempCalendar = Calendar.current
        let nowYear = tempCalendar.component(.year, from: myDate)
        let nowMonth = tempCalendar.component(.month, from: myDate)
        let nowDay = tempCalendar.component(.day, from: myDate)
        let selectDate = tempCalendar.date(from: DateComponents(year: nowYear, month: nowMonth, day: nowDay))
        calendarView.select(selectDate)
        
       
        
    }


}

extension CalendarViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    
    // FSCalendar 数据源方法
        func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
            
            let selectedWeekdays = weekModel.selectedWeekdays
            if date.isInRange(dateRange) && date.isWeekday(selectedWeekdays) {
                return 1
            }
            return 0
        }
    
    // 自定义事件标记的外观
        func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
            
            let selectedWeekdays = weekModel.selectedWeekdays
            if date.isInRange(dateRange) && date.isWeekday(selectedWeekdays) {
                return [UIColor.orange] // 事件标记的颜色
            }
            return nil
        }
    
//    // 土日や祝日の日の文字色を変える
//    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
//        //今月だけ
//        let dateDC = Calendar.current.dateComponents([.year, .month], from: date)
//        let todayDC = Calendar.current.dateComponents([.year, .month], from: Date())
//        if dateDC == todayDC {
//            
//            //今日の日付
//            let dateDC = Calendar.current.dateComponents([.year, .month, .day], from: date)
//            let todayDC = Calendar.current.dateComponents([.year, .month, .day], from: Date())
//            if dateDC == todayDC {
//                return UIColor.white
//            }
//            
//           
//            //土日の判定を行う（土曜日は青色、日曜日は赤色で表示する）
//            let weekday = self.getWeekIdx(date)
//            if weekday == 1 {   //日曜日
//                return UIColor.red
//            }
//            else if weekday == 7 {  //土曜日
//                return UIColor.red
//            }
//            
//        }
//        return nil
//    }
    
    
    //今日の日付の背景色
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        let dateDC = Calendar.current.dateComponents([.year, .month, .day], from: date)
        let todayDC = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        if dateDC == todayDC {
            return UIColor.lightGray
        }
        return nil
    }
    
    //選択した日付の背景色
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
        return UIColor.orange
    }
    
    //選択した日付の文字色
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleSelectionColorFor date: Date) -> UIColor? {
        return UIColor.white
    }
    
    
    //週の番号を取得する
    func getWeekIdx(_ date: Date) -> Int{
        let tmpCalendar = Calendar(identifier: .gregorian)
        return tmpCalendar.component(.weekday, from: date)
    }
    
    
    
    
}

extension Date {
    func isInRange(_ dateRange: DateRange) -> Bool {
        return self >= dateRange.startDate && self <= dateRange.endDate
    }

    func isWeekday(_ weekdays: [Int]) -> Bool {
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: self)
        return weekdays.contains(weekday)
    }
}

