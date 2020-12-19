//
//  CustomNavBarLarge.swift
//  ChoreManager
//
//  Created by Akash on 12/19/20.
//

import SwiftUI

struct CustomNavBarLarge: View {
    @EnvironmentObject var envData: EnvData
    @Environment(\.colorScheme) var cs
    var title: String
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                Spacer()
            }
            .padding(.top, 45)
            .padding(.bottom, 5)
            .frame(height: 105)
            .background(Colors(cs).navBarLargeBC())
            .padding(.bottom, -15)
        }
    }
}

struct CustomNavBarLarge_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavBarLarge(title: "Chore Manager")
    }
}
