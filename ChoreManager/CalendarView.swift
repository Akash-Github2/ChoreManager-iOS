//
//  CalendarView.swift
//  ChoreManager
//
//  Created by Akash on 12/19/20.
//

import SwiftUI

struct CalendarView: View, ToString {
    
    var body: some View {
        Text("Calendar View!")
    }
    
    func toString() -> String {
        return "CalendarView"
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
