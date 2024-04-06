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
            
            Text("Detta är en messenger app i realtid för att analysera hur teknisk och snabb kommunikation påverkar människans tydlighet i att kommunicera på. Därför också som namnet på appen är RealFlow Messaging")
                .padding()
            
            Spacer()

            
            
    
        }
    }
}

#Preview {
    AboutUs()
}
