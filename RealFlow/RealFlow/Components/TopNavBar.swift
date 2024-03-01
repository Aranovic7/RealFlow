//
//  TopNavBar.swift
//  RealFlow
//
//  Created by Aran Ali on 2024-02-28.
//

import SwiftUI

struct TopNavBar: View {
    @State var shouldShowLogOutOption: Bool = false
    var body: some View {
        VStack{
            HStack(spacing: 16){
                
                Image(systemName: "person.fill")
                    .font(.system(size: 34, weight: .heavy))
                
                VStack(alignment: .leading, spacing: 4){
                    Text("USERNAME")
                        .font(.system(size: 24, weight: .bold))
                    HStack{
                        Circle()
                            .foregroundStyle(.green)
                            .frame(width: 14, height: 14)
                        Text("online")
                            .font(.system(size: 12))
                            .foregroundStyle(Color.gray)
                    }
                }
                Spacer()
                Button {
                    shouldShowLogOutOption.toggle()
                } label: {
                    Image(systemName: "gear")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundStyle(Color.black)
                }
                
            }
            .padding()
            .actionSheet(isPresented: $shouldShowLogOutOption) {
                ActionSheet(
                    title: Text("Settings"),
                    message: Text("What do you want to do?"),
                    buttons: [
                        .destructive(Text("Sign Out")) {
                            // Hantera utloggning
                            print("handle sign out")
                        },
                        .cancel()
                    ]
                )
            }
        }
    }
}

#Preview {
    TopNavBar()
}
