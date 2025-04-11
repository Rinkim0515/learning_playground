//
//  CalVM.swift
//  Practice
//
//  Created by KimRin on 4/8/25.
//.00000000

import Foundation
import RxSwift

class CalVM {
    private let dateManager = DateManager.shared
    
    private var calendar = Calendar.current
    
    struct Input {
        let currentMonth: Observable<Date>
    }
    struct Output {
        let sections: Observable<[CalendarSectionModel]>
    }
    
    func transform(input: Input) -> Output {
        let sections = input.currentMonth
            .map { [weak self] monthDate -> [CalendarSectionModel] in
                guard let self = self else { return [] }
                
                let items = self.configureCalendarItems(currentMonth: monthDate)
                let section = CalendarSectionModel(
                    month: self.dateToMonthString(monthDate),
                    items: items
                )
                return [section]
            }
        
        return Output(sections: sections)
    }
    
    
    
    private func dateToMonthString(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM"
        return formatter.string(from: date)
    }
    
    
    //CalendarCell에게 주어야하는 구조채 만드는 로직
    func configureCalendarItems(currentMonth: Date) -> [CalendarItem] {
        var calendarItems: [CalendarItem] = []
        var weekSectionCounter: Int = 0 // 각 주차별 설정
        let firstDayInMonth = dateManager.getFirstDayInMonth(date: currentMonth)
        let firstWeekday = dateManager.getFirstWeekday(for: currentMonth)
        let lastMonthOfStart = dateManager.moveToSomeday(when: firstDayInMonth, howLong: -firstWeekday + 1)
        let thisMonth: Int = calendar.component(.month, from: currentMonth)
        
        
        for i in 0 ..< 42 {
            let date = dateManager.moveToSomeday(when: lastMonthOfStart, howLong: i)
            let dayBudget: Int = 0
            var isThisMonth = (thisMonth == calendar.component(.month, from: date)) // +
            
            var totalIncome: Int = 0
            var totalExpense: Int = 0
            var totalAmount: Int = 0
            let dayType = dateManager.getDayOfWeek(date: date)
            
            
            
            // 지출내역에 대한 총합산을 불러오는 메서드
            let amount = getAmount(date: date)
            totalIncome = amount.totalIncome
            totalExpense = amount.totalExpense
            totalAmount = totalIncome - totalExpense
            
            //이번달이 맞는 경우 주차별 값 설정 1주차/ 2주차 / 3주차 이런식
            if isThisMonth && dayType == .Sunday {
                weekSectionCounter += 1
                
            }
            // 월별예산안에 대한 데이터 호출
            
            
            //생성된 데이터 구조체
            var calendarItem = CalendarItem()
            calendarItem.date = date
            calendarItem.isThisMonth = isThisMonth
            calendarItem.weekSection = weekSectionCounter
            calendarItem.totalIncome = totalIncome
            calendarItem.totalExpense = totalExpense
            calendarItem.totalAmount = totalAmount
            calendarItem.dayType = dayType
            calendarItem.dayBudget = dayBudget
            
            calendarItems.append(calendarItem)
                
            
            

       }
        return calendarItems
        
        
    }
    
    func getAmount(date:Date) -> (totalIncome: Int, totalExpense: Int) {
        let startTime = dateManager.getDayOfStart(date: date)
        let endTime = dateManager.getDayOfEnd(date: date)
        var totalIncome = 0
        var totalExpense = 0
//        for i in realmManger.fetchDiaryBetweenDates(startTime, endTime) {
//            if i.isIncome {
//                totalIncome += Int(i.amount)
//            } else {
//                totalExpense += Int(i.amount)
//            }
//        }
        return (totalIncome, totalExpense)
    }
    
}


