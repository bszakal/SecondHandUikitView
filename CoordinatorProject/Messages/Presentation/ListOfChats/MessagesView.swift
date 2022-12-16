//
//  MessagesView.swift
//  SecondHand3
//
//  Created by Benjamin Szakal on 13/11/22.
//

import SwiftUI

struct MessagesView: View {
    
    @StateObject var messagesVM = MessagesVM()

    let chatViewSelected: (String, UserProfile, UserProfile)->Void
    
    var body: some View {
        

            
                ScrollView{
                    VStack(spacing:20){
                        ForEach(messagesVM.chats) {chat in
                            if let announce = messagesVM.announceForChat[chat.id],
                               let userProfile = messagesVM.userProfileForChat[chat.id] {
                                Button {
//                                    ChatView(announceId: chat.announceID, otherUser: messagesVM.userProfileForChat[chat.id] ?? UserProfile(id: "", emailAddress: ""),user: messagesVM.currentUserProfile)
                                    chatViewSelected(chat.announceID, messagesVM.userProfileForChat[chat.id] ?? UserProfile(id: "", emailAddress: ""), messagesVM.currentUserProfile)
                                    
                                } label: {
                                    ZStack(alignment:.trailing){
                                        VStack(alignment:.leading){
                                            MessageAnnounceRowView(announce: announce, userProfile: userProfile, unreadMessageCount: messagesVM.getUnredMessagesForChat(chat: chat))
                                        }
                                        
                                        Image(systemName: "chevron.right")
                                            .padding(.trailing)
                                            .foregroundColor(.primary)
                                    }
                                }                                
                                .listRowSeparator(.hidden)
                            }
                            
                        }
                    }
                    .padding()
                }
                .listStyle(.plain)
                .navigationTitle("Messages")
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(Color.gray, for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbarColorScheme(.dark, for: .navigationBar)
            
    }
    
//    var announceRowView: some View {
//        
//    }
}

struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
    
            MessagesView { _, _, _ in
                
            }
        
            
    }
}
