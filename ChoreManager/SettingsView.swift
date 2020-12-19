//
//  SettingsView.swift
//  ChoreManager
//
//  Created by Akash on 12/19/20.
//

import SwiftUI

struct SettingsView: View, ToString {
    @Environment(\.colorScheme) var cs
    @EnvironmentObject var envData: EnvData
    
    var body: some View {
        Text("Settings View!")
    }
    
    func toString() -> String {
        return "SettingsView"
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
