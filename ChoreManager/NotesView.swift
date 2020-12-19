//
//  NotesView.swift
//  ChoreManager
//
//  Created by Akash on 12/19/20.
//

import SwiftUI

struct NotesView: View, ToString {
    @Environment(\.colorScheme) var cs
    @EnvironmentObject var envData: EnvData
    
    var body: some View {
        Text("Notes View!")
    }
    
    func toString() -> String {
        return "NotesView"
    }
}

struct NotesView_Previews: PreviewProvider {
    static var previews: some View {
        NotesView()
    }
}
