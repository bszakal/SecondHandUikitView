//
//  Category.swift
//  SecondHand3
//
//  Created by Benjamin Szakal on 19/11/22.
//

import SwiftUI

struct selectionCategory2: View {
    @ObservedObject var createAnnounceVM: CreateAnnounceVM
    
    @State private var showConfirmationDialogue = false
    
    let backButtonPressed: ()->Void
    let forwardButtonPressed: ()->Void
    let dimissHandler: ()->Void
    
    var body: some View {
        
        ZStack{
            BackgrdColorCreateAnnounce()
            
            VStack(spacing:0){
                Spacer()
                
                Text("Category")
                    .modifier(TitleModifier())
                
                VStack{
                    ForEach(createAnnounceVM.categories){ cat in
                        Text(cat.Name)
                        
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .modifier(selectionModifier(isSelected: createAnnounceVM.selectedCategory == cat.Name))
                            .padding(.horizontal)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                createAnnounceVM.selectedCategory = cat.Name
                            }
                    }
                }
                .padding(.vertical)
                .background(.white)
                BottomBarUikit {
                    backButtonPressed()
                } nextButtonPressed: {
                    if createAnnounceVM.selectedCategory != ""{
                        forwardButtonPressed()
                    }
                }

            }
        }
        .navigationBarBackButtonHidden()
        .onAppear{
            createAnnounceVM.getCategories()
        }
        .toolbar{ Button { showConfirmationDialogue = true } label: { dismissButtonCreateAnnounce() } }
        .confirmationDialog("Are you sure?", isPresented: $showConfirmationDialogue) {
            Button("Confirm", role: .destructive){ dimissHandler() }
            Button("Cancel", role: .cancel) { showConfirmationDialogue = false }
        } message: { Text("Are you sure you want to exit?").font(.title) }
    }
}

struct selectionCategory2_Previews: PreviewProvider {
    static var previews: some View {
        selectionCategory2(createAnnounceVM: CreateAnnounceVM(),backButtonPressed:{}, forwardButtonPressed: {}, dimissHandler:{})
    }
}
