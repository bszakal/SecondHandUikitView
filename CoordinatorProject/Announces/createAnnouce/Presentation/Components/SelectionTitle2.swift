//
//  SelectionTitle2.swift
//  CoordinatorProject
//
//  Created by Benjamin Szakal on 17/12/22.
//

import SwiftUI

struct SelectionTitle2: View {
    
    @ObservedObject var createAnnounceVM: CreateAnnounceVM
    
    @State private var showConfirmationDialogue = false
    
  
    let backButtonPressed: ()->Void
    let forwardButtonPressed: ()->Void
    let dimissHandler: ()->Void
    
    var body: some View{
        ZStack{
            BackgrdColorCreateAnnounce()
            VStack(spacing:0){
                Spacer()
                Text("Title & Price")
                    .modifier(TitleModifier())
                VStack{
                    Group{
                        TextField(text: $createAnnounceVM.title, label: {
                            Text("Title")
                        })
                        .padding()
                        .frame(maxWidth: .infinity, minHeight: 50)
                        
                        TextField(value: $createAnnounceVM.price, format: .number, label: {
                            Text("Price")
                        })
                        .padding()
                        .frame(maxWidth: .infinity, minHeight: 50)
                        
                        TextEditor(text: $createAnnounceVM.descrpition)
                            .multilineTextAlignment(.leading)
                            .frame(height: 150)
                            .foregroundColor(.primary)
                            .padding()
                    }
                    .background(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1).foregroundColor(.primary).opacity(0.1))
                    
                }
                .padding()
                .background(.white)
                BottomBarUikit {
                    backButtonPressed()
                } nextButtonPressed: {
                    if createAnnounceVM.title != "" && createAnnounceVM.price != 0{
                        forwardButtonPressed()
                    }
                }

            }
        }
        .navigationBarBackButtonHidden()
        .toolbar{ Button { showConfirmationDialogue = true } label: { dismissButtonCreateAnnounce() } }
        .confirmationDialog("Are you sure?", isPresented: $showConfirmationDialogue) {
            Button("Confirm", role: .destructive){ dimissHandler() }
            Button("Cancel", role: .cancel) { showConfirmationDialogue = false }
        } message: { Text("Are you sure you want to exit?").font(.title) }
    }
}



struct SelectionTitle2_Previews: PreviewProvider {
    static var previews: some View {
        SelectionTitle2(createAnnounceVM: CreateAnnounceVM(), backButtonPressed: {}, forwardButtonPressed:{}, dimissHandler: {})
    }
}
