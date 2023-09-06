//
//  HomeSearchDetailView.swift
//  CEats
//
//  Created by 유하은 on 2023/09/05.
//

import SwiftUI

struct HomeSearchDetailView: View {
    
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var restaurantViewModel: RestaurantViewModel
    @State var searchText: String = ""
    @State var isSubmit: Bool = false
    var array: Set<String> {
        Set(restaurantViewModel.collectAllFoodNames())
    }
    var body: some View {
        NavigationStack{
            VStack{
                ZStack{
                    Rectangle()
                        .frame(width: 350,height: 45) //뷰 바운드로 수정
                        .foregroundColor(.white)
                        .cornerRadius(30)
                        .shadow(radius: 3)
                    ZStack{
                        HStack{
                            Image(systemName: "magnifyingglass")
                            TextField("ooo님, 서브웨이 어때요?", text: $searchText)
                                .onSubmit{
                                    isSubmit.toggle()
                            }
                            if !searchText.isEmpty {
                                Button(action: {
                                    self.searchText = ""
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                }
                            } else {
                                EmptyView()
                            }
                        }
                        .padding(.leading,40)
                    }
                }
                
                Spacer()
                List {
                    ForEach(array.filter{$0.hasPrefix(searchText) || searchText == ""}, id:\.self) {
                        searchText in
                        Text(searchText)
                            
                    }
                }
                
                .listStyle(PlainListStyle())
            }
        }
        .onTapGesture {
            hideKeyboard() 
        }
        .sheet(isPresented: $isSubmit) {
            AfterSearchView(restaurantsStore: restaurantViewModel, data: searchText)
        }
    }
}

struct HomeSearchDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HomeSearchDetailView(restaurantViewModel: RestaurantViewModel())
    }
}
