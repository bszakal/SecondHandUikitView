//
//  SelectionCondition.swift
//  SecondHand3
//
//  Created by Benjamin Szakal on 19/11/22.
//

import SwiftUI

struct SelectionCondition2: View {
    
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
                Text("Condition")
                    .modifier(TitleModifier())
                VStack{
                    
                    Group{
                        Text("Very Good")
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .onTapGesture {
                                createAnnounceVM.condition = "Very Good"
                            }
                            .modifier(selectionModifier(isSelected: createAnnounceVM.condition == "Very Good"))
                        Text("Good")
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .onTapGesture {
                                createAnnounceVM.condition = "Good"
                            }
                            .modifier(selectionModifier(isSelected: createAnnounceVM.condition == "Good"))
                        
                    }
                    
                    .contentShape(Rectangle())
                    .background(.white)
                    
                    .padding(.horizontal)
                }
                .padding(.vertical)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))

                BottomBarUikit(backButtonPressed: {
                    backButtonPressed()
                }, nextButtonPressed: {
                    if createAnnounceVM.condition != "" {
                        forwardButtonPressed()
                    }
                })

            }
        }
        .navigationBarBackButtonHidden()
        .toolbar{ Button { showConfirmationDialogue = true } label: { dismissButtonCreateAnnounce() } }
        .confirmationDialog("Are you sure?", isPresented: $showConfirmationDialogue) {
            Button("Confirm", role: .destructive){ dimissHandler() }
            Button("Cancel", role: .cancel) { showConfirmationDialogue = false }
        } message: { Text("Are you sure you want to exit?").font(.title) }
        .overlay(
            GeometryReader{ geo in
                Color.clear.onAppear{
                    withAnimation{
                        //viewSize(geo.frame(in: .local).size)
                        //offset = geo.frame(in: .local).size
                    }
                }
            }
        )
    }
    


    

}

struct SelectionCondition2_Previews: PreviewProvider {
    static var previews: some View {
        SelectionCondition2(createAnnounceVM: CreateAnnounceVM(), backButtonPressed: {}, forwardButtonPressed: {}, dimissHandler:{})
    }
}

