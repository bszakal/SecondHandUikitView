//
//  CommonPartCreateAnnounceUikit.swift
//  CoordinatorProject
//
//  Created by Benjamin Szakal on 16/12/22.
//

import SwiftUI

struct CommonPartCreateAnnounceUikit: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct dismissButtonCreateAnnounce: View{
    var body: some View{
            Image(systemName: "xmark")
                .foregroundColor(.white)
                .fontWeight(.bold)
                .padding(5)
                .background(Circle().foregroundColor(.black))
        
    }
}

struct BottomBarUikit: View{
    
    var text = "Next"
    let backButtonPressed:()->Void
    let nextButtonPressed:()->Void
    
    var body: some View {
        VStack(spacing:0){
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight:2)
            HStack{
              
                    Button("Back") { backButtonPressed() }
                    .modifier(buttonModifierCreateAnnouce())
                
                Spacer()
                
                Button(action: { nextButtonPressed() }, label: {
                    Text(text)
                })
                .modifier(buttonModifierCreateAnnouce())
                
            }
        }
        .background(.white)
    }
}

struct BackgrdColorCreateAnnounce: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [.black,.white]), startPoint: .bottomLeading, endPoint: .topTrailing)
            .ignoresSafeArea()
    }
}

struct selectionModifier: ViewModifier {
    let isSelected: Bool
    func body(content: Content) -> some View {
        content
            .background(isSelected ?
                        RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 3).foregroundColor(.primary).opacity(1) :
                        RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 3).foregroundColor(.primary).opacity(0.1))
    }
}



struct buttonModifierCreateAnnouce: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .fontWeight(.bold)
            .padding(.vertical)
            .padding(.horizontal, 30)
            .background(.black.opacity(0.7))
            .foregroundColor(.primary)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.horizontal, 30)
            .padding(.top, 15)
    }
}

struct TitleModifier: ViewModifier{
    func body(content: Content) -> some View{
        HStack{
            content
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.horizontal)
            
            Spacer()
        }
        .padding(.vertical)
    }
}




struct CommonPartCreateAnnounceUikit_Previews: PreviewProvider {
    static var previews: some View {
        BottomBarUikit(backButtonPressed: {}, nextButtonPressed: {})
    }
}
