//
//  AboutUs.swift
//  RealFlow
//
//  Created by Aran Ali on 2024-03-29.
//

import SwiftUI

struct AboutUs: View {
    var body: some View {
        VStack{
            Text("About us")
                .font(.title)
                .bold()
                .padding()
            
            Spacer()
            
            Text("This is a messenger app in real time to analyse how techniqual and fast communication affects humans in terms of clarity in communicating. This is also why the name of the app is RealFlow Messaging")
                .padding()
            
            Spacer()

            
            
    
        }
    }
}

#Preview {
    AboutUs()
}
