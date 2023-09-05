//
//  RestaurantTitleInfoView.swift
//  CEats
//
//  Created by gnksbm on 2023/09/04.
//

import SwiftUI

struct RestaurantTitleInfoView: View {
    @State private var sampleTitle = "대한냉면"
    @State private var sampleGrade = 4.9
    @State private var sampleReviewCount = 60
    
    var body: some View {
        VStack {
            Text(sampleTitle)
                .font(.system(size: 36, weight: .medium))
            NavigationLink {
//                ReviewInfoView()
            } label: {
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                        .padding(0)
                    Text(String(format: "%.1f", sampleGrade) + "(\(sampleReviewCount))")
                    Image(systemName: "chevron.forward")
                }
                .foregroundColor(.primary)
            }
        }
    }
}

struct RestaurantMinimalInfoView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantTitleInfoView()
    }
}