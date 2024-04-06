//
//  NewMessagesBtn.swift
//  RealFlow
//
//  Created by Aran Ali on 2024-02-28.
//

import SwiftUI

struct NewMessagesBtn: View {
    var body: some View {
        Button(action: {
            
        }, label: {
            HStack{
                Spacer()
                Text("+ New Message")
                    .font(.system(size: 16, weight: .bold))
                Spacer()
            }
            .foregroundStyle(Color.white)
            .padding(.vertical)
            .background(Color.blue)
            .clipShape(.rect(cornerRadius: 32))
            .padding(.horizontal)
            .shadow(radius: 15)
            .padding(.bottom)
            
            
        })
    }
}

#Preview {
    NewMessagesBtn()
}
