//
//  CalVM.swift
//  Practice
//
//  Created by KimRin on 4/8/25.
//.00000000

// ✅ 업데이트된 ViewModel: 섹션 3개 구성 (이전/현재/다음)
import Foundation
import RxSwift
import RxDataSources

// ✅ typealias 정의
typealias CalendarSection = SectionModel<String, CalendarItem>

class CalVM {
    private let dateManager = DateManager.shared
    private var calendar = Calendar.current

    struct Input {
        let currentMonth: Observable<Date>
    }

    struct Output {
        let sections: Observable<[CalendarSection]>
    }

    func transform(input: Input) -> Output {
        let sections = input.currentMonth
            .map { [weak self] monthDate -> [CalendarSection] in
                guard let self = self else { return [] }

                let months = [-1, 0, 1].compactMap { offset -> Date? in
                    self.calendar.date(byAdding: .month, value: offset, to: monthDate)
                }

                return months.map { date in
                    let items = self.configureCalendarItems(currentMonth: date)
                    let monthString = self.dateToMonthString(date)
                    return SectionModel(model: monthString, items: items)
                }
            }

        return Output(sections: sections)
    }

    private func dateToMonthString(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM"
        return formatter.string(from: date)
    }

    func configureCalendarItems(currentMonth: Date) -> [CalendarItem] {
        var calendarItems: [CalendarItem] = []
        var weekSectionCounter: Int = 0
        let firstDayInMonth = dateManager.getFirstDayInMonth(date: currentMonth)
        let firstWeekday = dateManager.getFirstWeekday(for: currentMonth)
        let lastMonthOfStart = dateManager.moveToSomeday(when: firstDayInMonth, howLong: -firstWeekday + 1)
        let thisMonth: Int = calendar.component(.month, from: currentMonth)

        for i in 0 ..< 42 {
            let date = dateManager.moveToSomeday(when: lastMonthOfStart, howLong: i)
            let isThisMonth = (thisMonth == calendar.component(.month, from: date))
            let dayType = dateManager.getDayOfWeek(date: date)

            let amount = getAmount(date: date)
            let totalIncome = amount.totalIncome
            let totalExpense = amount.totalExpense
            let totalAmount = totalIncome - totalExpense

            if isThisMonth && dayType == .Sunday {
                weekSectionCounter += 1
            }

            var calendarItem = CalendarItem()
            calendarItem.date = date
            calendarItem.isThisMonth = isThisMonth
            calendarItem.weekSection = weekSectionCounter
            calendarItem.totalIncome = totalIncome
            calendarItem.totalExpense = totalExpense
            calendarItem.totalAmount = totalAmount
            calendarItem.dayType = dayType
            calendarItem.dayBudget = 0

            calendarItems.append(calendarItem)
        }
        return calendarItems
    }

    func getAmount(date: Date) -> (totalIncome: Int, totalExpense: Int) {
        let startTime = dateManager.getDayOfStart(date: date)
        let endTime = dateManager.getDayOfEnd(date: date)
        var totalIncome = 0
        var totalExpense = 0
        return (totalIncome, totalExpense)
    }
}
