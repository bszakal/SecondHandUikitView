//
//  MyAccountView.swift
//  SecondHand3
//
//  Created by Benjamin Szakal on 13/11/22.
//

import SwiftUI

struct MyAccountView: View {

    @StateObject var myAccountVM = MyAccountVM()
    
    let userProfileRequested: () -> Void
    let favouritViewRequested: () ->Void
    let myAnnouncesViewRequested:() -> Void

    
    var body: some View {
        
            
                List{
                    Section {
                        
                        Button {
                            userProfileRequested()
                        } label: {
                            HStack{
                                itemListViewMyAccount(imageName: "person.crop.circle.fill",
                                                      text: "Edit profile")
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                        }
                            
                        
                    } header: {
                        Text("Profile")
                    }
                    .listSectionSeparator(.hidden)
                    //
                    
                    Section{
                        Button {
                            favouritViewRequested()
                        } label: {
                            HStack{
                                itemListViewMyAccount(imageName: "heart.fill", text: "Favourites")
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                        }
                        .listSectionSeparator(.hidden)
                        
                        Button {
                            myAnnouncesViewRequested()
                        } label: {
                            HStack{
                                itemListViewMyAccount(imageName: "list.bullet.rectangle.fill",
                                                      text: "My announces")
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                        }
                        .listSectionSeparator(.hidden)
                        
                    } header: {
                        Text("Announces")
                    }
                    .listSectionSeparator(.hidden)
                    //
        
                    Button("Log out") { myAccountVM.logOut() }
                    .listSectionSeparator(.hidden)
                    .underline()
                    .fontWeight(.semibold)
                    
                }
                .listStyle(.plain)
                .navigationTitle("My Account")
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(Color.gray, for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbarColorScheme(.dark, for: .navigationBar)
            
    }
}
struct itemListViewMyAccount: View {
    let imageName: String
    let text: String
    var body: some View{
        HStack{
            Image(systemName: imageName)
                .font(.title2)
                .foregroundColor(.primary)
            Text(text)
        }
    }
}

struct MyAccountView_Previews: PreviewProvider {
    static var previews: some View {
        MyAccountView(userProfileRequested: {}, favouritViewRequested: {}, myAnnouncesViewRequested: {})
    }
}
