//
//  ContentView.swift
//  NewDigs
//
//  Created by Seana Marie Lanias on 11/2/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.date, ascending: false)],
        animation: .default)
    
    private var items: FetchedResults<Item>
    
    @State private var addApartmentIsPresenting = false
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        ApartmentView(items: item)
                    } label: {
                        HStack {
                            
                                Image(imageData: item.data, placeholder: "newpost")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 48, height: 48, alignment: .center)
                            
                            VStack (alignment: .leading) {
                                Text(item.title ?? "title")
                                    .font(.body)
                                    .aspectRatio(contentMode: .fill)
                            
                                Text("Rent: \(item.rent as NSObject, formatter: numFormatter)")
                                    .font(.caption)
                                    .aspectRatio(contentMode: .fill)
 
                                Text("\(item.sqft as NSObject, formatter:NumberFormatter()) sqft")
                                    .font(.caption)
                                    .aspectRatio(contentMode: .fill)
                                
                                RatingView(rating: .constant(Int(item.rating)), leading: true)
                                    .aspectRatio(contentMode: .fit)

                            }
                        }
                        .padding(4)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem (placement: .navigationBarTrailing){
                    Button(action: {
                        addApartmentIsPresenting.toggle()
                    }, label: {
                        Label("Add Item", systemImage: "plus")
                    })
                }
            }
            .sheet(isPresented: $addApartmentIsPresenting){
                AddApartmentView()
            }
            .navigationTitle("NewDigs")
        }
    }
    
    //    private func addItem() {
    //        withAnimation {
    //            let newItem = Item(context: viewContext)
    //            newItem.date = Date()
    //
    //            do {
    //                try viewContext.save()
    //            } catch {
    //                // Replace this implementation with code to handle the error appropriately.
    //                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
    //                let nsError = error as NSError
    //                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
    //            }
    //        }
    //    }
    
    
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

private let numFormatter : NumberFormatter = {
    let nformatter = NumberFormatter()
    nformatter.usesGroupingSeparator = true
    nformatter.numberStyle = .currency
    nformatter.currencyCode = "USD"
    nformatter.locale = Locale.current
    //    nformatter.string(from: NSNumber(value: ))
    // not sure what to put for value
    return nformatter
}()


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
