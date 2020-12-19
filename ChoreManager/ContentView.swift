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
    @Published var selectedInd = 0
    let shortToLongWeekDayMap = ["MON": "Monday", "TUE": "Tuesday", "WED": "Wednesday", "THU": "Thursday", "FRI": "Friday", "SAT": "Saturday", "SUN": "Sunday"]
    @Published var daysOfWeekArr: [String] = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"]
    @Published var dayNumArr: [String] = ["01", "02", "03", "04", "05", "06", "07"]
    @Published var anyTasksArr: [Bool] = [true, false, true, true, false, true, true]
    @Published var datesOfWeekArr: [Date] = [Date(), Date(), Date(), Date(), Date(), Date(), Date()]
}

struct ContentView: View {
    @ObservedObject var data = DataClass()
    @Environment(\.managedObjectContext) var context
    @FetchRequest(fetchRequest: TaskEntry.getAllRecords()) var taskEntries: FetchedResults<TaskEntry>
    
    var body: some View {
        NavigationView {
            VStack {
                
                HStack {
                    Text(data.titleTxt)
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                        .padding(.leading, 15)
                    Spacer()
                    NumTasksLeftCircle(numTasks: getNumTasksForDay())
                    .padding(.trailing, 15)
                }
                .padding(.top, 15)
                
                //Horizontal Scrollbar of the days of the week
                HStack (spacing: 4) {
                    ForEach((0..<7), id: \.self) { i in
                        DayOfWeekSmallIcon(ind: i, data: data)
                    }
                }
                .padding(.horizontal, 12)
                .padding(.top, 10)
                .padding(.bottom, 5)
                
                ScrollView {
                    if getNumTasksForDay() > 0 {
                        ForEach(taskEntries) { entry in
                            //Each cell
                            if isDateSameDay(date1: data.datesOfWeekArr[data.selectedInd], date2: entry.dueDate!) {
                                ToDoListRow(completed: entry.isCompleted == "1", taskName: entry.name ?? "", taskEntry: entry)
                            }
                            
                        }.onDelete { indexSet in
                            let deleteItem = taskEntries[indexSet.first!]
                            context.delete(deleteItem)
                            
                            do {
                                try context.save()
                            } catch {
                                print(error)
                            }
                        }
                    } else {
                        Text("No tasks left for \(data.shortToLongWeekDayMap[data.daysOfWeekArr[data.selectedInd]]!)")
                    }
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
                data.daysOfWeekArr = getDaysOfWeekInfo()
                data.dayNumArr = getDayNumsInfo()
                data.datesOfWeekArr = getDatesOfWeek()
                addItem(dueDate: Date().addingTimeInterval(TimeInterval(0*86400)), isCompleted: "0", name: "Go for a Run", taskDescr: "N/A", usersList: "Joe")
                //addItem(dueDate: Date().addingTimeInterval(TimeInterval(3*86400)), isCompleted: "0", name: "Do Dishes", taskDescr: "N/A", usersList: "Joe")
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
    
    func getDatesOfWeek() -> [Date] {
        var datesArr: [Date] = []
        for i in 0..<7 {
            let date = Date().addingTimeInterval(TimeInterval(i*86400))
            datesArr.append(date)
        }
        return datesArr
    }
    
    func isDateSameDay(date1: Date, date2: Date) -> Bool {
        let df = DateFormatter()
        df.dateFormat = "EEE"
        let dayOfWeek1: String = df.string(from: date1).uppercased()
        let dayOfWeek2: String = df.string(from: date2).uppercased()
        if dayOfWeek1 != dayOfWeek2 {
            return false
        }
        let diff = abs(date1.timeIntervalSinceReferenceDate - date2.timeIntervalSinceReferenceDate)
        return diff < 86400
    }
    
    func getNumTasksForDay() -> Int {
        var count = 0
        for taskEntry in taskEntries {
            if isDateSameDay(date1: data.datesOfWeekArr[data.selectedInd], date2: taskEntry.dueDate!) {
                count += 1
            }
        }
        return count
    }
    
    //Core data
    func addItem(dueDate: Date, isCompleted: String, name: String, taskDescr: String, usersList: String) {
        
        let entry = TaskEntry(context: context)
        entry.dueDate = dueDate
        entry.isCompleted = isCompleted
        entry.name = name
        entry.taskDescr = taskDescr
        entry.usersList = usersList
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
}


struct NumTasksLeftCircle: View {
    
    let numTasks: Int
    
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: 1)
                .stroke(retColorForNumTasks().opacity(0.5), style: StrokeStyle(lineWidth: 5, lineCap: .round))
                .frame(width: 40, height: 40)
                .rotationEffect(.init(degrees: -90))
            Text("\(numTasks)")
                .fontWeight(.medium)
        }
    }
    
    func retColorForNumTasks() -> Color {
        if numTasks == 0 {
            return .green
        } else if numTasks >= 1 && numTasks <= 5 {
            return .yellow
        } else {
            return .red
        }
    }
}

struct DayOfWeekSmallIcon: View {
    
    var ind: Int
    @ObservedObject var data: DataClass
    @Environment(\.managedObjectContext) var context
    @FetchRequest(fetchRequest: TaskEntry.getAllRecords()) var taskEntries: FetchedResults<TaskEntry>
    
    var body: some View {
        VStack (alignment: .center) {
            Text(data.daysOfWeekArr[ind])
                .fontWeight(.medium)
                .padding(.bottom, 2)
            Text(data.dayNumArr[ind])
                .fontWeight(.semibold)
                .padding(.bottom, -1)
            Circle()
                .frame(width:5,height:5)
                .foregroundColor(.blue)
                .opacity(!isDayEmpty() ? 1 : 0)
        }
        .frame(width: (UIScreen.main.bounds.width - 30)/7 - 5)
        .padding(.vertical, 9)
        .background(ind == data.selectedInd ? Color.blue.opacity(0.15) : Color.clear)
        .cornerRadius(7)
        .onTapGesture {
            data.selectedInd = ind
            if ind == 0 {
                data.titleTxt = "Today"
            } else if ind == 1 {
                data.titleTxt = "Tomorrow"
            } else { //ind > 1
                data.titleTxt = data.shortToLongWeekDayMap[data.daysOfWeekArr[ind]] ?? "Today"
            }
        }
    }
    
    func isDayEmpty() -> Bool {
        for taskEntry in taskEntries {
            if isDateSameDay(date1: data.datesOfWeekArr[ind], date2: taskEntry.dueDate!) {
                return false
            }
        }
        return true
    }
    func isDateSameDay(date1: Date, date2: Date) -> Bool {
        let df = DateFormatter()
        df.dateFormat = "EEE"
        let dayOfWeek1: String = df.string(from: date1).uppercased()
        let dayOfWeek2: String = df.string(from: date2).uppercased()
        if dayOfWeek1 != dayOfWeek2 {
            return false
        }
        let diff = abs(date1.timeIntervalSinceReferenceDate - date2.timeIntervalSinceReferenceDate)
        return diff < 86400
    }
}

struct ToDoListRow: View {
    
    @Environment(\.managedObjectContext) var context
    @FetchRequest(fetchRequest: TaskEntry.getAllRecords()) var taskEntries: FetchedResults<TaskEntry>
    @State var completed = false
    var taskName: String
    var taskEntry: TaskEntry
    
    var body: some View {
        HStack {
            Button(action: {
                completed.toggle()
                withAnimation {
                    removeEntry()
                }
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
    
    func removeEntry() {
        context.delete(taskEntry)
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
}
