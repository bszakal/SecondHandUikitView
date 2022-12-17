//
//  RecapCreateAnnounce2.swift
//  CoordinatorProject
//
//  Created by Benjamin Szakal on 17/12/22.
//

import SwiftUI


/*
 createAnnounceVM.uploadAnnounce(title: title, description: descrpition, price: price!, category: selectedCategory, condition: condition, deliveryType: deliveryType, address: fullAddress, images: uiPhotosArray)
 */

struct RecapCreateAnnounce2: View {
    
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
                
                Text("Recap")
                    .modifier(TitleModifier())
                
                ScrollView{
                    VStack(alignment:.leading, spacing: 20){
                        
                        Group{
                            listItemRecapView(title: "Category", text: createAnnounceVM.selectedCategory)
                                .listRowSeparator(.hidden)
                            listItemRecapView(title: "Title", text: createAnnounceVM.title)
                                .listRowSeparator(.hidden)
                            listItemRecapView(title: "Condition", text: createAnnounceVM.condition)
                                .listRowSeparator(.hidden)
                            listItemRecapView(title: "Description", text: createAnnounceVM.descrpition)
                        }
                        
                        listDivider
                        
                        listItemRecapView(title: "Price", text: String(createAnnounceVM.price ?? 0))
                        
                        listDivider
                        
                        listItemRecapView(title: "Delivery type", text: createAnnounceVM.deliveryType)
                            .listRowSeparator(.hidden)
                        
                        listItemRecapView(title: "Address", text: createAnnounceVM.fullAddress)
                        
                        listDivider
                        
                        photoList
                        
                    }
                }
                .padding()
                .background(.white)
                
                BottomBarUikit(text:"Create!") {
                    backButtonPressed()
                } nextButtonPressed: {
                    Task{
                        await createAnnounceVM.uploadAnnounceUikit()
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
    
    var listDivider: some View {
        HStack{
            Spacer()
            dividerCustom
                .frame(width: 100)
            Spacer()
        }
    }
    
    var photoList: some View {
        VStack(alignment:.leading, spacing: 5){
            Text("Photo")
                .font(.headline)
            
            ScrollView(.horizontal){
                HStack{
                    ForEach(createAnnounceVM.uiPhotosArray, id:\.self){ img in
                        Image(uiImage: img)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                    }
                }
            }
        }
    }
}


struct RecapCreateAnnounce2_Previews: PreviewProvider {
    static var previews: some View {
        RecapCreateAnnounce2(createAnnounceVM: CreateAnnounceVM(), backButtonPressed: {}, forwardButtonPressed: {}, dimissHandler: {})
    }
}

