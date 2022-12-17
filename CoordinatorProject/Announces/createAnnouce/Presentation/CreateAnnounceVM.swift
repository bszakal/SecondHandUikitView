//
//  CreateAnnounceVM.swift
//  SecondHand3
//
//  Created by Benjamin Szakal on 05/11/22.
//

import SwiftUI

@MainActor
class CreateAnnounceVM: ObservableObject {
    
    @Published var selectedCategory = ""
    @Published var title: String = ""
    @Published var descrpition: String = "Description"
    @Published var price: Double?
    @Published var condition = ""
    @Published var addressLine = ""
    @Published var postCode = ""
    @Published var city = ""
    @Published var deliveryType = "Collection"
    @Published var uiPhotosArray = [UIImage]()
    
    var fullAddress: String {
        if addressLine.isEmpty || postCode.isEmpty || city.isEmpty {
            return ""
        } else {
            return addressLine + ", " + postCode + ", " + city
        }
        
    }
    
    
    @Inject var fetcher: FirebaseCategoriesProtocol!
    @Inject var createAnnounce: CreateAnnounceProtocol!
    
    @Published private(set) var categories = [Category]()
    
    
    
    func getCategories(){
        
        Task{
            let resut = await fetcher.getCategories()
            switch resut {
            case .success(let success):
                self.categories = success
            case .failure(let failure):
                print(failure.localizedDescription)
            }            
        }
    }
    
    func uploadAnnounce(title: String, description: String, price: Double, category: String, condition: String, deliveryType: String, address: String, images: [UIImage]) async -> Result<Bool, Error> {
        
        let size = "XS"
        
        let ImgsAsData = images.compactMap{$0.jpegData(compressionQuality: 0.8)}
        
        //Task {
            return await createAnnounce.createAnnounce(title:title,
                                          description:description,
                                          price:price,
                                          category:category,
                                          size:size,
                                          condition:condition,
                                          deliveryType:deliveryType,
                                          address:address,
                                          images:ImgsAsData)
        //}
        
    }
    
    func loadDicoImgFromArray() -> [Int:UIImage] {
        var dico = [Int:UIImage]()
        if uiPhotosArray.isEmpty{
            return dico
        } else {
            for nbre in 0..<uiPhotosArray.count {
                dico[nbre + 1] = uiPhotosArray[nbre]
            }
            return dico
        }
        
    }
    
    func uploadAnnounceUikit() async {
        
        let size = "XS"
        
        let ImgsAsData = uiPhotosArray.compactMap{$0.jpegData(compressionQuality: 0.8)}
        
        //Task {
            await createAnnounce.createAnnounce(title:title,
                                          description:descrpition,
                                          price:price ?? 0,
                                          category:selectedCategory,
                                          size:size,
                                          condition:condition,
                                          deliveryType:deliveryType,
                                          address:fullAddress,
                                          images:ImgsAsData)
        //}
        
    }
    

    
}
