//
//  ApartmentView.swift
//  NewDigs
//
//  Created by Seana Marie Lanias on 11/2/22.
//

import SwiftUI
import MapKit

struct ApartmentView: View {
    
    var items : Item
    @StateObject var locationVM = LocationVM()
    
    var body: some View {
        //        NavigationView {
        Form {
            Group{
                VStack{
                    Image(imageData: items.data, placeholder: "newpost")
                        .resizable()
                        .cornerRadius(6)
                        .aspectRatio(contentMode: .fit)
                        .padding()
                    
                    MapView(coord:CLLocationCoordinate2D(latitude: items.latitude, longitude: items.longitude))
                        .aspectRatio(contentMode: .fit)
                }
            }
            .padding()
            
            Group{
                VStack (alignment: .leading) {
                    HStack{
                        Text("Title:")
                            .font(.headline)
                        Text(items.title ?? "")
                    }
                    .padding()
                    
                    Group{
                        VStack (alignment: .leading) {
                        HStack {
                            Text("Rating:")
                                .font(.headline)
                            RatingView(rating: .constant(Int(items.rating)), leading: false)
                        }
                    }
                    }
                    .padding()
                    
                    Group{
                        VStack (alignment: .leading) {
                        HStack{
                            Text("Address:")
                                .font(.headline)
                            Text(items.address ?? "")
                        }
                        }
                    }
                    .padding()
                    
                    Group{
                        VStack (alignment: .leading) {
                        HStack{
                            Text("Date:")
                                .font(.headline)
                            Text(items.date!, formatter: itemFormatter)
                        }
                    }
                    }
                    .padding()
                    
                    Group{
                        VStack (alignment: .leading) {
                        HStack{
                            Text("Phone Number:")
                                .font(.headline)
                            Text(items.phone ?? "")
                        }
                        }
                    }
                    .padding()
                }
            }
            
            Group{
                VStack(alignment: .leading){
                    
                    Group{
                        VStack (alignment: .leading) {
                        HStack{
                            Text("Rent:")
                                .font(.headline)
                            Text(items.rent as NSObject, formatter: numFormatter)
                        }
                        }
                    }
                    .padding()
                    
                    Group{
                        HStack{
                            Text("Square Footage:")
                                .font(.headline)
                            Text(String(items.sqft))
                        }
                    }
                    .padding()
                    
                    Group{
                        VStack (alignment: .leading){
                            Text("Notes:")
                                .font(.headline)
                            Text(items.notes ?? "")
                            
                        }
                    }
                    .padding()
                    
                }
            }
            
        }
    }
    //        }
}

private let numFormatter : NumberFormatter = {
    let nformatter = NumberFormatter()
    nformatter.usesGroupingSeparator = true
    nformatter.generatesDecimalNumbers = true
    nformatter.numberStyle = .currency
    nformatter.currencyCode = "USD"
    //    nformatter.locale = Locale.current
    nformatter.string(from: NSNumber(value: 9999.99))
    // not sure what to put for value
    return nformatter
}()

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .short
    return formatter
}()

//struct ApartmentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ApartmentView()
//    }
//}
