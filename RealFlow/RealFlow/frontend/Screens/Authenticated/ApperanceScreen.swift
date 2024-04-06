//
//  ApperanceScreen.swift
//  RealFlow
//
//  Created by Aran Ali on 2024-03-19.
//

import SwiftUI

struct ApperanceScreen: View {
    
    @State var lightTheme: Bool = true
    
    var body: some View {
        
        ZStack{
            
            if lightTheme {
                Color.white
                    .ignoresSafeArea()
            } else {
                Color.black
                    .ignoresSafeArea()
            }
            
            VStack{
                
                if lightTheme {
                    
                    Text("Light Theme")
                        .foregroundStyle(Color.black)
                        .font(.title)
                        .bold()
                    
                } else {
                    
                    Text("Dark Theme")
                        .foregroundStyle(Color.white)
                        .font(.title)
                        .bold()
                }
                
                Spacer()
                
                ZStack{
                    
                    if lightTheme {
                        
                        Image(systemName: "sun.max.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .foregroundStyle(Color.yellow)
                        
                    } else {
                        
                        Image(systemName: "moon.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .foregroundStyle(Color.white)
                        
                    }
                    
                }
                
                Spacer()
                
                Toggle(isOn: $lightTheme) {
                    
                    if lightTheme {
                        
                        Text("Activate Dark Theme")
                            .bold()
                        
                        Image(systemName: "moon.fill")
                            .tint(Color.black)
                           
                    } else {
                        
                        Rectangle()
                            .frame(width: 220, height: 35)
                            .clipShape(.rect(cornerRadius: 8))
                            .overlay{
                                HStack{
                                    Text("Activate Light Theme")
                                        .bold()
                                        .tint(Color.black)
                                    
                                    Image(systemName: "sun.max.fill")
                                        .tint(Color.black)
                                    
                                }
                            }
                    }
                    
                }
                .tint(lightTheme ? Color.black : Color.white)
                .toggleStyle(.button)
                .padding()
                
               
            }
            
        }
        
    }
}

#Preview {
    ApperanceScreen()
}
