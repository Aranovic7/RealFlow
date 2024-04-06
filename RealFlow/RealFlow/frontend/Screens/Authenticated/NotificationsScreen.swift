//
//  NotificationsScreen.swift
//  RealFlow
//
//  Created by Aran Ali on 2024-03-19.
//

import SwiftUI

struct NotificationsScreen: View {
    var body: some View {
        
        Text("Notifications")
            .font(.title)
            .bold()
        
        Form{
               
                Toggle(isOn: .constant(true), label: {
                    Text("Notifications")
                })
            
            
        }
    }
}

#Preview {
    NotificationsScreen()
}
