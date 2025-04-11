//
//  CalendarSectionModel.swift
//  Practice
//
//  Created by KimRin on 4/8/25.
//

import Foundation
import RxDataSources



struct CalendarSectionModel {
    let month: String
    var items: [CalendarItem]
}

extension CalendarSectionModel: SectionModelType {
    //프로토콜로 정의 한 SectionModelType을 만들어서 채택하고 이것을 통해서 RxDataSource에게 인식할수 있게끔 구현한다 가 주된 정의
    typealias Item = CalendarItem //RxDataSource에게 Item은 무엇인지 지정을 위해서?
    
    init(original: CalendarSectionModel, items: [CalendarItem]) {
        self = original
        self.items = items
    }
    
}
