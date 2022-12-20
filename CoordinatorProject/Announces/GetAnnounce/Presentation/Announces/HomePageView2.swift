//
//  HomePageView2.swift
//  CoordinatorProject
//
//  Created by Benjamin Szakal on 18/12/22.
//

import SwiftUI

struct HomePageView2: View {
    
     var delegate: GetAnnounceCoordinator?
    
    @State private var searchText = ""

    var body: some View {
        
        
        
        ScrollView{
            VStack{
                Button {
                    delegate?.showFilterView()
                } label: {
                    searchBar(searchText: $searchText)
                        .padding(.horizontal)
                        .disabled(true)
                }
                
                listOfCategoriesView(delegate: delegate)
                    .frame(height: 220)
                
                AnnounceView(isPartOfMainView: true, delegate: delegate)
                
            }
        }
        .background(LinearGradient(gradient: Gradient(colors: [.gray.opacity(0.3), .white]), startPoint: .top, endPoint: .trailing))
        .toolbar(.visible, for: .tabBar)
   
    }
    
}

struct HomePageView2_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView2()
    }
}
