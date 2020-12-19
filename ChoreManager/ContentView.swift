//
//  ContentView.swift
//  ChoreManager
//
//  Created by Akash on 12/18/20.
//

import SwiftUI
import CoreData

class DataClass: ObservableObject {
    @Published var titleTxt = "Today"
    @Published var selectedArr: [Bool] = [true, false, false, false, false, false, false]
    let shortToLongWeekDayMap = ["MON": "Monday", "TUE": "Tuesday", "WED": "Wednesday", "THU": "Thursday", "FRI": "Friday", "SAT": "Saturday", "SUN": "Sunday"]
}

struct ContentView: View {
    
    @State var daysOfWeekArr: [String] = ["", "", "", "", "", "", ""]
    @State var dayNumArr: [String] = ["", "", "", "", "", "", ""]
    @State var anyTasksArr: [Bool] = [true, false, true, true, false, true, true]
    @ObservedObject var data = DataClass()
    
    var body: some View {
        NavigationView {
            VStack {
                
                HStack {
                    Text(data.titleTxt)
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                        .padding(.leading, 15)
                    Spacer()
                    ZStack {
                        CircleTimer()
                        Text("4")
                            .fontWeight(.medium)
                    }
                    .padding(.trailing, 15)
                }
                .padding(.top, 15)
                
                //Horizontal Scrollbar of the days of the week
                HStack (spacing: 4) {
                    ForEach((0..<7), id: \.self) { i in
                        DayOfWeekSmallIcon(ind: i, dayOfWeek: daysOfWeekArr[i], dayNumStr: dayNumArr[i], anyTasks: anyTasksArr[i], data: data)
                    }
                }
                .padding(.horizontal, 12)
                .padding(.top, 10)
                .padding(.bottom, 5)
                
                ScrollView {
                    ToDoListRow(completed: false, taskName: "Do Groceries")
                    ToDoListRow(completed: false, taskName: "Do Dishes")
                    ToDoListRow(completed: false, taskName: "Go for Run")
                    ToDoListRow(completed: false, taskName: "Do Homework")
                }
                
                Spacer()
            }
            
            .navigationBarTitle("Chore Manager")
            .navigationBarItems(trailing:
                Button(action: {
                    print("Add New Item")
                }) {
                    Image(systemName: "plus.circle.fill")
                        .font(Font.title.weight(.bold))
                        .frame(width: 10, height: 10)
                }
                .offset(x:-12, y:32)
            )
            .onAppear() {
                daysOfWeekArr = getDaysOfWeekInfo()
                dayNumArr = getDayNumsInfo()
            }
        }
        
    }
    
    func getDayNumsInfo() -> [String] {
        var dayNums: [String] = []
        for i in 0..<7 {
            let date = Date().addingTimeInterval(TimeInterval(i*86400))
            let df = DateFormatter()
            df.dateFormat = "dd"
            dayNums.append(df.string(from: date))
        }
        return dayNums
    }
    
    func getDaysOfWeekInfo() -> [String] {
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "EEE"
        let dayOfWeek = df.string(from: date)
        var daysArr = df.shortWeekdaySymbols!
        while dayOfWeek != daysArr[0] {
            daysArr.append(daysArr.remove(at: 0))
        }
        for i in 0..<daysArr.count {
            daysArr[i] = daysArr[i].uppercased()
        }
        return daysArr
    }
    

}

struct CircleTimer: View {
    
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: 1)
                .stroke(Color.black.opacity(0.09), style: StrokeStyle(lineWidth: 5, lineCap: .round))
                .frame(width: 40, height: 40)
            Circle()
                .trim(from: 0, to: CGFloat(6) / CGFloat(10))
                .stroke(Color.green, style: StrokeStyle(lineWidth: 5, lineCap: .round))
                .frame(width: 40, height: 40)
        }
        .rotationEffect(.init(degrees: -90))
    }
}

struct DayOfWeekSmallIcon: View {
    
    var ind: Int
    var dayOfWeek: String
    var dayNumStr: String
    var anyTasks: Bool
    @ObservedObject var data: DataClass
    
    var body: some View {
        VStack (alignment: .center) {
            Text(dayOfWeek)
                .fontWeight(.medium)
                .padding(.bottom, 2)
            Text(dayNumStr)
                .fontWeight(.semibold)
                .padding(.bottom, -1)
            Circle()
                .frame(width:5,height:5)
                .foregroundColor(.blue)
                .opacity(anyTasks ? 1 : 0)
        }
        .frame(width: (UIScreen.main.bounds.width - 30)/7 - 5)
        .padding(.vertical, 9)
        .background(data.selectedArr[ind] ? Color.blue.opacity(0.15) : Color.clear)
        .cornerRadius(7)
        .onTapGesture {
            for i in 0..<7 {
                data.selectedArr[i] = false
            }
            data.selectedArr[ind].toggle()
            if ind == 0 {
                data.titleTxt = "Today"
            } else if ind == 1 {
                data.titleTxt = "Tomorrow"
            } else { //ind > 1
                data.titleTxt = data.shortToLongWeekDayMap[dayOfWeek] ?? "Today"
            }
        }
    }
}

struct ToDoListRow: View {
    
    @State var completed = false
    var taskName: String
    
    var body: some View {
        HStack {
            Button(action: {
                completed.toggle()
            }) {
                Image(systemName: "checkmark.circle")
                    .font(Font.title.weight(.bold))
                    .foregroundColor(Color.green)
                    .frame(width: 30, height: 30)
                    .opacity(completed ? 1 : 0.2)
            }
            .padding(.leading, 15)
            .padding(.trailing, 15)
            Text(taskName)
                .font(.system(size: 25))
                .fontWeight(.medium)
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width * 0.9, height: 75)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(25)
        .padding(.bottom, 2)
    }
}
