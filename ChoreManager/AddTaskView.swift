//
//  AddTaskView.swift
//  ChoreManager
//
//  Created by Akash on 12/19/20.
//

import SwiftUI

class ChoreData: ObservableObject {
    @Published var name = ""
    @Published var description = ""
    @Published var date = Date()
}

struct AddTaskView: View, ToString {
    
    @EnvironmentObject var envData: EnvData
    @Environment(\.managedObjectContext) var context
    @FetchRequest(fetchRequest: TaskEntry.getAllRecords()) var taskEntries: FetchedResults<TaskEntry>
    
    @State var showDurationPicker:Bool = false
    @State var showDatePicker:Bool = false
    @State var showTimePicker:Bool = false
    
    @State var rotationValDate:Double = 0
    @State var rotationValDuration:Double = 0
    @State var rotationValTime:Double = 0
    @ObservedObject var choreData = ChoreData()
    
    var body: some View {
        VStack {
            ZStack {
                CustomNavBarSmall(title: "Add New Chore", backIndex: envData.lastViewIndex, currIndex: envData.currViewIndex)
                HStack {
                    Spacer()
                    Button(action: {
                        print("save")
                        addItem(dueDate: choreData.date, isCompleted: "0", name: choreData.name, taskDescr: choreData.description, usersList: "Joe")
                        reset()
                        envData.currViewIndex = envData.lastViewIndex
                        envData.lastViewIndex = -1
                    }) {
                        Text("Save")
                            .padding(.trailing, 15)
                            .offset(y: 5)
                    }
                    .disabled(choreData.name.count == 0)
                }
            }
            List {
                
                HStack {
                    Text("Chore Name")
                    Spacer()
                    TextField("E.g. Do dishes", text:$choreData.name)
                        .padding(8)
                        .font(Font.system(size: 15, weight: .medium))
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 1))
                        .padding(.trailing, 15)
                        .padding(.leading, 10)
                }
                
                DatePicker("Deadline", selection: $choreData.date)
                    .datePickerStyle(CompactDatePickerStyle())
                
                VStack {
                    Text("Description")
                        .padding(.bottom, 5)
                    TextEditor(text: $choreData.description)
                        .padding(8)
                        .font(Font.system(size: 15, weight: .medium))
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 1))
                        .padding(.horizontal, 15)
                }
                .frame(height: 140)
            }
        }
    }
    
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
    
    func reset() {
        choreData.name = ""
        choreData.description = ""
        choreData.date = Date()
    }
    
    func toString() -> String {
        return "AddTaskView"
    }
    
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView()
    }
}
