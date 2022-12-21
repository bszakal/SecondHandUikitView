//
//  SingleAnnounceView.swift
//  SecondHand3
//
//  Created by Benjamin Szakal on 23/11/22.
//

import SwiftUI

struct SingleAnnounceView: View {
    
    let announce: Announce    
    @ObservedObject var announcesListVM: AnnouncesListVM
    @State private var showLoginView = false
    weak var delegate: GetAnnounceCoordinator?
    
    var body: some View{
        
        VStack{
            VStack(alignment:.leading){
                ZStack(alignment:.topTrailing){
                    Button {
                        delegate?.showAnnounceDetailView(announce: announce)
                    } label: {
                        photoView2(imageUrlsString: announce.imageRefs)
                    }

                    FavouriteHeartView(isAFavourite: announcesListVM.isAFavouriteAnnounce(announceId: announce.id ?? ""), isLoggedIn: delegate?.isLoggedIn) {
                        if let isLoggedIn = delegate?.isLoggedIn, isLoggedIn == true{
                            announcesListVM.AddOrRemoveFromFavourite(announce: announce)
                        } else {
                            delegate?.showLoginView()
                        }
                    }
                    .padding()
               
                }
                .padding(.bottom, 2)
               textView
            }
        }
    }
 
    var textView: some View {
        VStack(alignment:.leading){
            HStack(alignment:.top){
                VStack(alignment:.leading){
                    Text(announce.title)
                        .font(.headline)
                        .fontWeight(.semibold)
                    Text(announce.price, format: .currency(code: "EUR"))
                        .font(.headline)
                        .fontWeight(.semibold)
                        .padding(.bottom, 1)
                    
                }
                .modifier(tempDataModifier(isTempata: announcesListVM.useTempData))
                
                Spacer()
                HStack(spacing:0){
                    Image(systemName: "star.fill")
                    Text(5, format: .number)
                }
                .padding(.trailing,2)
                .modifier(tempDataModifier(isTempata: announcesListVM.useTempData))
            }
            
            Text(announce.city_PostCode)
                .foregroundColor(.secondary)
                .modifier(tempDataModifier(isTempata: announcesListVM.useTempData))
            
            HStack{
                Text(announce.lastUpdatedAt ?? Date(), format: .dateTime.day().month())
                Text("a")
                Text(announce.lastUpdatedAt ?? Date(), format: .dateTime.hour().minute())
            }
            .foregroundColor(.secondary)
            .modifier(tempDataModifier(isTempata: announcesListVM.useTempData))
        }
        
    }

    
}

struct tempDataModifier: ViewModifier {
    let isTempata: Bool
    func body(content: Content) -> some View {
        if isTempata {
        content
                .overlay(RoundedRectangle(cornerRadius: 10).foregroundColor(.gray))
        } else {
        content
        }
    }
}


struct SingleAnnounceView_Previews: PreviewProvider {
    static var previews: some View {
        SingleAnnounceView(announce: Announce.example, announcesListVM: AnnouncesListVM())
            .environmentObject(LoginState())
    }
}
