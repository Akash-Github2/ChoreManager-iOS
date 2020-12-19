//
//  ContentView.swift
//  ChoreManager
//
//  Created by Akash on 12/19/20.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var cs
    @EnvironmentObject var envData: EnvData
    
    var body: some View {
        ZStack {
            CurrentView()
            VStack {
                Spacer()
                CustomTabBar()
                    .padding(.bottom, 5)
            }
            .ignoresSafeArea(.keyboard)
        }
    }
    
    
    func CurrentView() -> AnyView {
        return Util.indexMapAnyView[envData.currViewIndex]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
