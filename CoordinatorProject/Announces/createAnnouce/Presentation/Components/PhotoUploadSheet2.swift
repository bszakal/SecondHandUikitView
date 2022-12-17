//
//  PhotoUploadSheet2.swift
//  CoordinatorProject
//
//  Created by Benjamin Szakal on 17/12/22.
//

import SwiftUI

struct PhotoUploadSheet2: View {
    
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var createAnnounceVM: CreateAnnounceVM
   
    @State private var showConfirmation = false
    @State private var showPhotoLibrary = false
    @State private var showCamera = false
    @State private var uiPhotosDico = [Int: UIImage]()
    @State private var selectedPhoto = 0
    @State private var uiPhotosArray = [UIImage]()
    
    @State private var showConfirmationDialogue = false
    
    let backButtonPressed: ()->Void
    let forwardButtonPressed: ()->Void
    let dimissHandler: ()->Void
    
    var body: some View {
        VStack{
            title
                .padding(.top)
            
            VStack{
                
                ScrollView{
                    photoPlacerHolderView(image: convertOptionalUiImgToOptionalImg(nbre: 1), photoNbre: 1)
                        .frame(height: 250)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .contentShape(Rectangle())
                        .onTapGesture {
                            showConfirmation = true
                            selectedPhoto = 1
                        }
                        .padding(.horizontal)
                    LazyVGrid(columns: [GridItem(), GridItem()]){
                        ForEach(2...6, id:\.self){ nbre in
                            photoPlacerHolderView(image: convertOptionalUiImgToOptionalImg(nbre: nbre), photoNbre: nbre)
                                .frame(width: 175, height: 175)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    showConfirmation = true
                                    selectedPhoto = nbre
                                }
                        }
                    }
                    .padding(.horizontal)
                }
                BottomBarUikit {
                    if !uiPhotosDico.isEmpty{
                        createAnnounceVM.uiPhotosArray = uiPhotosDico.map{$0.value}
                    }
                    backButtonPressed()
                } nextButtonPressed: {
                    if !uiPhotosDico.isEmpty{
                        createAnnounceVM.uiPhotosArray = uiPhotosDico.map{$0.value}
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

        .onAppear(perform: {
           uiPhotosDico = createAnnounceVM.loadDicoImgFromArray()
        })
        
        .confirmationDialog("Upload Photo", isPresented: $showConfirmation, actions: {
            Button("Library") {showPhotoLibrary = true}
            Button("Camera") {showCamera = true}
        })
        .sheet(isPresented: $showPhotoLibrary, content: {
            ImagePicker {img in
                self.uiPhotosDico[selectedPhoto] = img
            }
        })
        .sheet(isPresented: $showCamera, content: {
            Camera {img in
                if let photo = img {
                    self.uiPhotosDico[selectedPhoto] = photo
                }
                showCamera = false
            }
        })
        
    }
    
    var title: some View {
        VStack{
            ZStack{
                Text("Upload Photos")
                    .fontWeight(.bold)
            }
            .font(.title2)
            dividerCustom
            
        }
    }
    
    func convertOptionalUiImgToOptionalImg(nbre: Int) -> Image? {
        if let uiPhoto = uiPhotosDico[nbre] {
            return Image(uiImage: uiPhoto)
        } else {
            return nil
        }
    }
}


struct PhotoUploadSheet2_Previews: PreviewProvider {
    static var previews: some View {
        PhotoUploadSheet2(createAnnounceVM: CreateAnnounceVM(), backButtonPressed: {}, forwardButtonPressed: {}, dimissHandler: {})
    }
}
