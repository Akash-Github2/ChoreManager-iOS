//
//  CustomTabBar.swift
//  ChoreManager
//
//  Created by Akash on 12/19/20.
//

import SwiftUI

struct CustomTabBar: View {
    @Environment(\.colorScheme) var cs
    
    var body: some View {
        
        HStack {
            TabItem(currViewIndex: 0, imageName: "house.fill", tabName: "Home")
            TabItem(currViewIndex: 1, imageName: "calendar", tabName: "Calendar")
            TabItem(currViewIndex: 2, imageName: "doc.text.fill", tabName: "Notes")
            TabItem(currViewIndex: 3, imageName: "gear", tabName: "Settings")
        }
        .padding(.top, 3)
        .frame(width: UIScreen.main.bounds.width * 0.94, height: 58)
        .background(Colors(cs).tabBarBC().opacity(0.97))
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.2), radius: 3, x: 3, y: 3)
        .shadow(color: Color.white.opacity(0.3), radius: 1.5, x: -1.5, y: -1.5)
    }
}

struct TabItem: View {
    @EnvironmentObject var envData: EnvData
    let currViewIndex: Int
    let imageName: String
    let tabName: String
    
    var body: some View {
        Group {
            Spacer()
            Button(action: {
                envData.currViewIndex = currViewIndex
                envData.lastViewIndex = -1
            }) {
                VStack {
                    Image(systemName: imageName)
                        .padding(.bottom, -5)
                    Text(tabName)
                        .font(.system(size: 10))
                        .fontWeight(envData.currViewIndex == currViewIndex ? .bold : .regular)
                }
                .foregroundColor(envData.currViewIndex == currViewIndex ? .blue : Color(#colorLiteral(red: 0.6273946166, green: 0.627487123, blue: 0.6273742914, alpha: 1)))
            }
            Spacer()
        }
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar()
    }
}
