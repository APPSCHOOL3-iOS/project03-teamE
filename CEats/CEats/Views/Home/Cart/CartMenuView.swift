//
//  CartMenuView.swift
//  CEats
//
//  Created by 박범수 on 2023/09/07.
//

import SwiftUI

// 장바구니: 사용자1 -> 가게1(음식1, 음식2)
// 유저1의 장바구니 -> 선택한 식당 이름, 선택한 음식, 수량, 선택한 식당의 추천 음식(무작위)
struct CartMenuView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var restaurant: RestaurantViewModel
    var colorSet: UIColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text(userViewModel.user.foodCart?.restaurantName ?? "몰라")
                    .font(.title3)
                    .bold()
                ForEach(userViewModel.user.foodCart?.cart ?? []) { food in
                    VStack {
                        Divider()
                        HStack {
                            VStack(alignment: .leading) {
                                Text(food.name)
                                Text(food.description)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                
                                Text("\(food.price * food.foodCount)원")
                                    .bold()
                            }
                            Spacer()
                            ZStack {
                                Capsule()
                                    .fill(Color(colorSet))
                                    .frame(width: 100, height: 30)
                                HStack {
                                    Button {
                                        userViewModel.subtractCount(food: food)
                                        print(userViewModel.user.foodCart?.cart[0].foodCount)
                                    } label: {
                                        Image(systemName: "minus.circle.fill")
                                    }.disabled(food.foodCount == 0)
                                    Text("\(food.foodCount)")
                                    Button {
                                        userViewModel.addCount(food: food)
                                        print(userViewModel.user.foodCart?.cart[0].foodCount)
                                    } label: {
                                        Image(systemName: "plus.circle.fill")
                                    }
                                }
                                .padding()
                            }
                            .foregroundColor(.white)
                        }
                    }
                }
            }
            Divider()
        }
        .padding()
        NavigationLink {
            // userViewModel.user.foodCart.restaurant을 통해서 뷰를 호출해야함.
            // if let으로 ! -> 아닐 경우 넘어가지 않게 !
            if let restaurant = userViewModel.user.foodCart?.restaurant {
                RTRView(restaurant: restaurant)
            }
            
            
        } label: {
            Text("+ 메뉴 추가")
        }
        .font(.caption)
//        VStack {
//            HStack {
//                Text("함께 주문하면 좋을 메뉴")
//                    .bold()
//                    .padding()
//                Spacer()
//            }
//            ScrollView(.horizontal, showsIndicators: false) {
//                HStack {
//                    ForEach(userViewModel.recommendFoods(food: userViewModel.user.foodCart?.cart ?? [], restaurant: userViewModel.user.foodCart?.restaurant ?? [Restaurant.sampleData])) { store in
//
//                        Button {
//
//                        } label: {
//                            HStack {
//                                VStack {
//                                    Text(store.name)
//                                        .foregroundColor(.black)
//                                    Text("\(store.price)")
//                                }
//                                Button {
//
//                                } label: {
//                                    Image(systemName: "plus.circle")
//                                        .font(.title)
//                                }
//                            }
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 5)
//                                    .stroke(Color.gray, lineWidth: 2)
//                            )
//                        }
//                    }
//                }
//            }
//            .padding()
//        }
    }
}

struct CartMenuView_Previews: PreviewProvider {
    static var previews: some View {
        CartMenuView()
            .environmentObject(RestaurantViewModel())
            .environmentObject(UserViewModel())
    }
}
