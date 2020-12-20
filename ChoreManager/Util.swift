//
//  Util.swift
//  ChoreManager
//
//  Created by Akash on 12/19/20.
//

import SwiftUI

class EnvData: ObservableObject {
    @Published var currViewIndex = 0
    @Published var lastViewIndex = -1
}

struct Util {
    
    static var indexMap: [ToString] = [HomeView(), CalendarView(), NotesView(), SettingsView(), AddTaskView(), AddUserView()]
    
    static var indexMapAnyView: [AnyView] = [AnyView(HomeView()), AnyView(CalendarView()), AnyView(NotesView()), AnyView(SettingsView()), AnyView(AddTaskView()), AnyView(AddUserView())]
    
    static func retIndexNum(view: ToString) -> Int {
        for i in 0..<indexMap.count {
            if indexMap[i].toString() == view.toString() {
                return i
            }
        }
        return -1
    }
}

protocol ToString {
    func toString() -> String
}

extension Date {
    func toCustomString() -> String {
        let dateFormatter = DateFormatter()
        let curLocale: Locale = Locale.current
        let formatString: NSString = DateFormatter.dateFormat(fromTemplate: "h:mm a", options: 0, locale: curLocale)! as NSString
        dateFormatter.dateFormat = formatString as String
        return dateFormatter.string(from: self)
    }
}
