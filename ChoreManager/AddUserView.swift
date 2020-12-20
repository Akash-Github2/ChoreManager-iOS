//
//  AddUserView.swift
//  ChoreManager
//
//  Created by Akash on 12/19/20.
//

import SwiftUI

struct AddUserView: View, ToString {
    
    @EnvironmentObject var envData: EnvData
    @State var selectionColor = Color.black
    @State var userName = ""
    
    var body: some View {
        VStack {
            ZStack {
                CustomNavBarSmall(title: "Add New User", backIndex: envData.lastViewIndex, currIndex: envData.currViewIndex)
                HStack {
                    Spacer()
                    Button(action: {
                        print("save")
                        envData.currViewIndex = envData.lastViewIndex
                        envData.lastViewIndex = -1
                    }) {
                        Text("Save")
                            .padding(.trailing, 15)
                            .offset(y: 5)
                    }
                    .disabled(userName.count == 0)
                }
            }
            .padding(.bottom, 30)
            
            HStack {
                Text("Name")
                Spacer()
                TextField("E.g. Josh", text:$userName)
                    .padding(8)
                    .font(Font.system(size: 15, weight: .medium))
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 1))
                    .padding(.trailing, 15)
                    .padding(.leading, 10)
            }
            .padding(.horizontal, 20)
            HStack {
                ColorPicker("Pick a profile color", selection: $selectionColor, supportsOpacity: false)
                    .padding(20)
                Rectangle()
                    .frame(width: 80, height: 50)
                    .foregroundColor(selectionColor)
                    .padding(.leading, 15)
                    .padding(.trailing, 25)
            }
            Spacer()
            
        }
        .onAppear() {
            selectionColor = generateRandomColor()
        }
    }
    
    func generateRandomColor() -> Color {
        let r = CGFloat.random(in: 0...1)
        let g = CGFloat.random(in: 0...1)
        let b = CGFloat.random(in: 0...1)
        
        return Color(UIColor(red: r, green: g, blue: b, alpha: 1.0))
    }
    
    func toString() -> String {
        return "AddUserView"
    }
}

struct AddUserView_Previews: PreviewProvider {
    static var previews: some View {
        AddUserView()
    }
}
