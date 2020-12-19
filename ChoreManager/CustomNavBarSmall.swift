//
//  CustomNavBarSmall.swift
//  ChoreManager
//
//  Created by Akash on 12/19/20.
//

import SwiftUI

struct CustomNavBarSmall: View {
    @EnvironmentObject var envData: EnvData
    @Environment(\.colorScheme) var cs
    var title: String
    var backIndex: Int
    var currIndex: Int
    
    var body: some View {
        VStack {
            VStack {
                ZStack {
                    if backIndex != -1 {
                        HStack {
                            Button(action: {
                                envData.currViewIndex = backIndex
                                envData.lastViewIndex = currIndex
                            }) {
                                HStack {
                                    Image(systemName: "chevron.left")
                                        .font(Font.system(size: 20, weight: .heavy))
                                        .padding(.leading, 5)
                                        .padding(.trailing, 20)
                                }
                            }
                            .foregroundColor(Colors(cs).backBtnFC())
                            Spacer()
                        }
                        .padding(.leading, 10)
                    }
                    HStack {
                        Spacer()
                        Text(title)
                            .font(.system(size: 18.5))
                            .fontWeight(.bold)
                        Spacer()
                    }
                }
                .frame(height: 62)
                .background(Colors(cs).navBarSmallBC())
                .padding(.bottom, -15)
            }
        }
    }
}

struct CustomNavBarSmall_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavBarSmall(title: "Add Task", backIndex: -1, currIndex: 0)
    }
}
