//
//  ContentView.swift
//  RealFlow
//
//  Created by Aran Ali on 2024-02-18.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack{
            LoginScreen(usernameInput: "", passwordInput: "")
        }
        
        
    }
}

#Preview {
    ContentView()
}
