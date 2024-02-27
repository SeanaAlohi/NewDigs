//
//  RatingView.swift
//  NewDigs
//
//  Created by Seana Marie Lanias on 11/4/22.
//

import SwiftUI

struct RatingView: View {
    
    @Binding var rating: Int
    var leading: Bool = false
    
    var body: some View {
        HStack {
            ForEach(1...5, id: \.self) { idx in
                Image("star")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 19, height: 19, alignment: .center)
                    .saturation(idx <= rating ? 1.0 : 0)
                    .onTapGesture {
                        rating = idx
                    }
            }
            if leading {
                Spacer()
            }
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: .constant(4))
    }
}
