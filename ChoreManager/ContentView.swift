//
//  ContentView.swift
//  ChoreManager
//
//  Created by Akash on 12/18/20.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView (.horizontal) {
                    HStack (spacing: 30) {
                        UserProfileCircle(name: "All")
                        UserProfileCircle(name: "Akash")
                        UserProfileCircle(name: "Aidan")
                        UserProfileCircle(name: "John")
                        UserProfileCircle(name: "Nick")
                        UserProfileCircle(name: "Joe")
                    }
                    .padding(.leading, 20)
                    .padding(.top, 10)
                }
                .padding(.bottom, 20)
                HStack {
                    Text("Today")
                        .font(.system(size: 28))
                        .fontWeight(.medium)
                        .padding(.leading, 15)
                    Spacer()
                    ZStack {
                        CircleTimer()
                        Text("4")
                            .fontWeight(.medium)
                    }
                    .padding(.trailing, 15)
                }
                
                //Horizontal Scrollbar of the days of the week
                Scroll
                
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
                    Image(systemName: "plus")
                        .font(Font.title.weight(.bold))
                        .frame(width: 10, height: 10)
                }
                .offset(x:-5, y:25)
            )
        }
        
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

struct UserProfileCircle: View {
    
    var name: String
    
    var body: some View {
        VStack {
            Circle()
                .foregroundColor(Color.red.opacity(0.5))
                .frame(width: 20, height: 20)
            Text(name)
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
