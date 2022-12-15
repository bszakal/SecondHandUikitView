//
//  LoginRestrictedView.swift
//  SecondHand3
//
//  Created by Benjamin Szakal on 21/11/22.
//

import SwiftUI

struct LoginRestrictedView: View {
    
    @State private var showLoginPage = false
    
    let title: String
    let showLoginPageButtonPressed: () ->Void
    
    var body: some View {
        VStack(alignment:.leading, spacing: 30){
            HStack{
                Text(title)
                Spacer()
            }
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding(.horizontal, 25)
            
            Text("Log in to see \(title)")
                .font(.title)
                .padding(.horizontal, 25)
            
            Button {
                showLoginPageButtonPressed()
            } label: {
                Text("Log in")
                    .modifier(buttonModifierCreateAnnouce())
                    .fontWeight(.bold)
                    .font(.title)
            }

                Spacer()
        }
        .padding(.top, 70)
    
    }
}

struct LoginRestrictedView_Previews: PreviewProvider {
    static var previews: some View {
        LoginRestrictedView(title: "Publish"){}
    }
}
