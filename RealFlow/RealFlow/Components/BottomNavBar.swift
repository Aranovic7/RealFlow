//
//  BottomNavBar.swift
//  RealFlow
//
//  Created by Aran Ali on 2024-02-28.
//

import SwiftUI

struct BottomNavBar: View {
    var body: some View {
        VStack{
            HStack{
                Button(action: {
                    print("")
                }, label: {
                    VStack(alignment: .center, spacing: 4){
                        Image(systemName: "bubble.left.fill")
                            .font(.system(size: 25))
                        Text("Messages")
                            .font(.system(size: 11))
                            
                    }
                })
                .padding(.leading, 70)
                Spacer()
                Button(action: {
                    print("")
                }, label: {
                    VStack(alignment: .center, spacing: 4){
                        Image(systemName: "gear")
                            .font(.system(size: 25))
                        Text("Settings")
                            
                    }
                })
                .padding(.trailing, 70)
            }
            .frame(width: 400,height: 70)
            .background(Color.red)
        }
    }
}

#Preview {
    BottomNavBar()
}
