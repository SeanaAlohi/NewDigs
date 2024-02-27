//
//  AddApartmentView.swift
//  NewDigs
//
//  Created by Seana Marie Lanias on 11/2/22.
//

import SwiftUI

struct AddApartmentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    
    @StateObject var locationVM = LocationVM()
    @State private var rating = 3
    @State private var title = ""
    @State private var address = ""
    @State private var notes = ""
    @State private var phone = ""
    @State private var date = Date()
    @State private var uiImage: UIImage?
    // rent is an int16
    //        @State private var rent = "0"
    @State private var rent = Int16(0.0)
    //    @State var rent: Int16
    //sqft is an int16
    //        @State private var sqft = "1"
    @State private var sqft = Int16(0.0)
    //    @State var sqft: Int16
    // longitude is a double
    @State private var longitude = 0.0
    @State private var latitude = 0.0
    
    @State private var imagePickerPresenting = false
    
    
    
    var body: some View {
        NavigationView {
            Form {
                VStack {
                    Image(uiImage: uiImage ?? UIImage(imageLiteralResourceName: "newpost"))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(9)
                        .clipShape(Rectangle())
                        .padding()
                    
                    Text("Choose a photo")
                        .foregroundColor(.blue)
                        .fontWeight(.heavy)
                        .onTapGesture {
                            imagePickerPresenting.toggle()
                            locationVM.toggleService()
                        }
                        .padding()
                }
                Section("Title") {
                    TextField("Title", text: $title)
                }
                
                Section("Rating") {
                    HStack {
                        Spacer()
                        RatingView(rating: $rating)
                        Spacer()
                    }
                }
                
                Section("Address") {
                    TextField("Address", text: $address)
                }
                
                Section("Phone") {
                    TextField("(###) ###-####", text: $phone)
                }
                
                Section("Rent"){
                    TextField("Rent", value: $rent, formatter: numFormatter)
                }
                
                Section("Square Feet"){
                    TextField("Square Feet", value: $sqft, formatter: NumberFormatter())
                }
                
                Section("Notes"){
                    TextEditor(text: $notes)
                }
                
                Section {
                    HStack {
                        Spacer()
                        Button(action: {
                            addApartment()
                            locationVM.toggleService()
                        }, label: {
                            Text("Save")
                        })
                        .disabled(title.isEmpty)
                        Spacer()
                    }
                }
            }
            .sheet(isPresented: $imagePickerPresenting) {
                PhotoPicker(image: $uiImage)
                
            }
            .navigationTitle("New Listing")
        }
    }
    
    private func addApartment() {
        withAnimation {
            let imgData = Item(context: viewContext)
            imgData.address = address
            imgData.title = title
            imgData.notes = notes
            imgData.phone = phone
            imgData.rent = Int16(rent)
            imgData.sqft = Int16(sqft)
            imgData.rating = Int16(rating)
            imgData.date = Date()
            imgData.uuid = UUID()
            imgData.longitude = locationVM.location?.coordinate.longitude ?? 0.0
            imgData.latitude = locationVM.location?.coordinate.latitude ?? 0
            
            if let data = uiImage?.jpegData(compressionQuality: 0.8) {
                imgData.data = data
            }
            
            do {
                try viewContext.save()
                dismiss()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
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

struct AddApartmentView_Previews: PreviewProvider {
    static var previews: some View {
        AddApartmentView()
    }
}
