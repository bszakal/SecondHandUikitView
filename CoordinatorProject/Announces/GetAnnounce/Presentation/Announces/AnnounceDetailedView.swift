//
//  AnnounceDetailedView.swift
//  SecondHand3
//
//  Created by Benjamin Szakal on 11/11/22.
//
import UIKit
import SwiftUI

protocol AnnounceDetailViewDelegate: AnyObject {
    var isLoggedIn: Bool {get}
    var showLoginView: ()->Void {get}
    func showChatView(announceId: String, otherUser: UserProfile, currentUser: UserProfile)
    func showAnnounceDetailView(announce: Announce)
}

extension AnnounceDetailViewDelegate{
//    func getAnnounceDetailViewVC(announce: Announce)->UIHostingController<AnnounceDetailedView>{
//        return UIHostingController(rootView: AnnounceDetailedView(announce: announce, delegate: self))
//    }
    
    func getAnnounceDetailViewVC(announce: Announce)->UIViewController{
        return AnnounceDetailedViewUikit(announce: announce)
    }
}

struct AnnounceDetailedView: View {
    
    
    @State private var showloginView = false
    
    @StateObject var announceDetailedVM = AnnounceDetailedVM()
    let announce: Announce
    weak var delegate: AnnounceDetailViewDelegate?
    
    var body: some View {
        GeometryReader{ geo in
            VStack{
                ScrollView{
                    VStack{
                        photoView2(imageUrlsString: announce.imageRefs)
                            .frame(height: geo.frame(in: .local).height / 2)
                        
                        VStack(alignment:.leading){
                            announceMainInfos
                            
                            userDetails
                            
                            announceDescription
                            
                            announceCondition
                            
                            announceDelivery
                            
                        }
                        .padding(.horizontal)
                    }
                }
               
                bottomBar
              
            }
        }
        .toolbar(.hidden, for: .tabBar)
        .toolbar(content: {
            FavouriteHeartView(isAFavourite: announceDetailedVM.isAFavourite, isLoggedIn: delegate?.isLoggedIn) {
                if let isLoggedIn = delegate?.isLoggedIn, isLoggedIn == true{
                    announceDetailedVM.AddOrRemoveFromFavourite(announce: announce)
                } else {
                    delegate?.showLoginView()
                }
   
            }
            .padding(5)
            .background(Circle()).foregroundColor(.white)
        })
        .edgesIgnoringSafeArea(.top)
        .onAppear{
            announceDetailedVM.isAFavourite(announce: announce)
            announceDetailedVM.getUserDetailsForAnnounce(announce: announce)
            announceDetailedVM.getCurrentUserDetails()
            
        }
    }
    
    
    var userDetails: some View {
        VStack(alignment:.leading){
            HStack{
                photoView2(imageUrlsString: [announceDetailedVM.userProfileForAnnounce.profilePictureUrlStr],imageToShowIfFail: Image(systemName: "person"))
                    .frame(width: 75, height: 75)
                    .clipShape(Circle())
                    .padding(.trailing, 10)
                VStack(alignment:.leading){
                    Text(announceDetailedVM.userProfileForAnnounce.pseudo)
                        .font(.title3)
                        .padding(.bottom, 10)
                    HStack{
                        ForEach(1...5, id:\.self){nbre in
                            Image(systemName: "star.fill")
                        }
                    }
                }
            }
            HStack{
                Spacer()
                dividerCustom
                    .frame(width: 75)
                Spacer()
            }
        }
    }
    
    var announceMainInfos: some View {
        VStack{
            HStack{
                VStack(alignment:.leading){
                    Text(announce.title)
                    Text((announce.price), format: .currency(code: "EUR"))
                        .padding(.bottom, 1)
                    Text(announce.lastUpdatedAt ?? Date(), format: .dateTime)
                        .font(.body)
                        .fontWeight(.regular)
                        .foregroundColor(.secondary)
                    
                }
                .font(.title3)
                .fontWeight(.semibold)
                Spacer()
            }
            HStack{
                Spacer()
                dividerCustom
                    .frame(width: 75)
                Spacer()
            }
        }
    }
    
    var announceDescription: some View {
        announceDetailedViewText(title: "Description", bodyText: announce.description)
        .padding(.bottom)
    }
    
    var announceCondition: some View {
        announceDetailedViewText(title: "Condition", bodyText: announce.condition)
        .padding(.bottom)
 
    }
    
    var announceDelivery: some View {
        announceDetailedViewText(title: "Delivery", bodyText: announce.deliveryType)
    }
    
    struct announceDetailedViewText: View {
        let title: String
        let bodyText: String
        var body: some View{
            VStack(alignment:.leading){
                Text(title)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)
                Text(bodyText)
            }
        }
    }
    
    var bottomBar: some View {
        VStack{
            dividerCustom
                .scaleEffect(3)
                .padding(.bottom, 5)
            HStack{
   
                Button {
                    if let isLoggedIn = delegate?.isLoggedIn, isLoggedIn == true{

                        delegate?.showChatView(announceId: announce.id ?? "", otherUser: announceDetailedVM.userProfileForAnnounce, currentUser: announceDetailedVM.currentUserProfile)

                    } else {
                        delegate?.showLoginView()
                    }
                } label: {
                    bottomBarButtonLabel(text: "Message")
                }
                
                Button {
                    //TODO
                } label: {
                    bottomBarButtonLabel(text: "Buy")
                    
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 50)
            .padding(.horizontal)
            
        }
        .background(.white)
        
    }
    
    struct bottomBarButtonLabel: View {
        let text: String
        var body: some View{
            ZStack{
                Text(text)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.primary)
                   
                RoundedRectangle(cornerRadius: 10).stroke().foregroundColor(.primary)
            }
        }
    }
}

struct AnnounceDetailedView_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationStack{
            AnnounceDetailedView(announce: Announce.example)
                .environmentObject(LoginState())
        }
    }
}
