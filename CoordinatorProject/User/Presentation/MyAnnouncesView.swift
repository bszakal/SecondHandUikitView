//
//  MyAnnouncesView.swift
//  SecondHand3
//
//  Created by Benjamin Szakal on 13/11/22.
//

import SwiftUI

struct MyAnnouncesView: View {
    
    @StateObject var myAnnouncesVm = MyAnnouncesVM()
    let DetailViewRequested: ()-> Void
    
    var body: some View {
        

            List{
                ForEach(myAnnouncesVm.myAnnounces) {announce in
                    Button {
                        DetailViewRequested()
                    } label: {
                        myAnnounceSingleView(announce: announce)
                    }
                }
                .listRowSeparator(.hidden)
               
            }
            
            .listStyle(.plain)
            .onAppear{ myAnnouncesVm.getMyAnnounce() }

        .navigationTitle("My announces")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct myAnnounceSingleView: View {
    let announce: Announce
    
    var body: some View{
        HStack(alignment: .bottom){
            photoView2(imageUrlsString: announce.imageRefs)        
                .frame(width: 130, height: 150)
            TextView(announce: announce)
            Spacer()
        }
        .foregroundColor(.primary)
        .padding()
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(radius: 10)
    }
}

struct TextView: View {
    let announce: Announce
    
    var body: some View{
        VStack(alignment:.leading, spacing: 5){
            VStack(alignment:.leading){
                Text(announce.title)
                    .font(.headline)
                
                HStack(spacing:2){
                    Text(announce.price, format: .number)
                    Text(Locale.current.currencySymbol ?? "EUR")
                }
                .font(.headline)
            }
            
            Text(announce.category)
                .font(.body)
                .fontWeight(.bold)
                .foregroundColor(.secondary)
                
            VStack(alignment:.leading){
                Text(announce.city_PostCode)
                Text(announce.lastUpdatedAt ?? Date(), format: .dateTime)
            }
            .font(.subheadline)
           
            Text(announce.deliveryType)
                .font(.subheadline)
                .underline()
                
        }

    }
}




struct MyAnnouncesView_Previews: PreviewProvider {
    static var previews: some View {

            MyAnnouncesView(DetailViewRequested: {})
        
    }
}
