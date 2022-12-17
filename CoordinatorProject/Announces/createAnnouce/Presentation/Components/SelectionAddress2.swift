//
//  SelectionAddress2.swift
//  CoordinatorProject
//
//  Created by Benjamin Szakal on 17/12/22.
//

import SwiftUI

struct SelectionAddress2: View {
    
    @ObservedObject var createAnnounce: CreateAnnounceVM
    
    @State private var showConfirmationDialogue = false
    
    let backButtonPressed: ()->Void
    let forwardButtonPressed: ()->Void
    let dimissHandler: ()->Void
    
    var body: some View{
        ZStack{
            BackgrdColorCreateAnnounce()
            VStack(spacing:0){
                Spacer()
                
                Text("Address")
                    .modifier(TitleModifier())
                
                VStack{
                    Group{
                        HStack{
                            Text("Delivery Type:")
                                .foregroundColor(.secondary)
                            Spacer()
                            Picker("Deivery Type", selection: $createAnnounce.deliveryType) {
                                Text("Collection").tag("Collection")
                                Text("DPD").tag("DPD")
                            }
                            .tint(.primary)
                        }
                        
                        TextField(text: $createAnnounce.addressLine, label: {
                            Text("Address")
                        })
                        
                        TextField(text: $createAnnounce.postCode, label: {
                            Text("Postcode")
                        })
                        
                        TextField(text: $createAnnounce.city, label: {
                            Text("City")
                        })
                    }
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .background(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1).foregroundColor(.primary).opacity(0.1))
                    .padding(.horizontal)
                }
                .padding(.vertical)
                .background(.white)
                
                
                BottomBarUikit {
                    backButtonPressed()
                } nextButtonPressed: {
                    if createAnnounce.addressLine != "" && createAnnounce.postCode != "" && createAnnounce.city != ""{
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

struct SelectionAddress2_Previews: PreviewProvider {
    static var previews: some View {
        SelectionAddress2(createAnnounce:CreateAnnounceVM(), backButtonPressed: {}, forwardButtonPressed: {}, dimissHandler: {})
    }
}
