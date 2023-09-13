//
//  MyView.swift
//  CEats
//
//  Created by 박범수 on 2023/09/04.
//

import SwiftUI


struct MyView: View {
    @Binding var tabIndex: Int
    @EnvironmentObject private var userViewModel: UserViewModel
    @EnvironmentObject private var restaurantViewModel: RestaurantViewModel
    
    @State private var isOpenMapSheet: Bool = false
    
    var body: some View {
        NavigationStack {
            Text("\(userViewModel.user.username)")// 내 이름
                .font(.largeTitle)
                .padding(5)
            Text("\(userViewModel.user.phoneNumber)")// 내 전화번호
            
            HStack(alignment: .center ,spacing: 10) {
                VStack {
                    Text("\(userViewModel.user.reviews.count)")
                        .font(.largeTitle)
                        .bold()
                    Text("내가 남긴리뷰")
                        .font(.footnote)
                }
                .padding()
                VStack(alignment: .center) {
                    Text("0")
                        .font(.largeTitle)
                        .bold()
                    Text("도움이 됐어요")
                        .font(.footnote)
                }
                .padding()
                VStack {
                    Text("\(userViewModel.user.favoriteRestaurant.count)")
                        .font(.largeTitle)
                        .bold()
                    Text("즐겨찾기")
                        .font(.footnote)
                }
                .padding()
            }
            // 자세히보기 버튼
            NavigationLink {
                MyInfoView()
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 320, height: 50)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.blue, lineWidth: 1)
                        )
                        .foregroundColor(.white)
                        .padding(2)
                    Text("자세히 보기")
                        .bold()
                }
            }
            Image("advertisement")
                .resizable()
                .aspectRatio(contentMode: .fit)
            VStack {
                NavigationLink {
                    MapHomeView(isOpenMapSheet: $isOpenMapSheet)
                } label: {
                    HStack {
                        Image(systemName: "list.bullet.rectangle.portrait")
                            .imageScale(.large)
                            .padding()
                        Text("주소 관리")
                            .frame(height: 60)
                        Spacer()
                    }
                }
                NavigationLink {
                    FavoriteView(tabIndex: $tabIndex)
                } label: {
                    HStack {
                        Image(systemName: "heart")
                            .imageScale(.large)
                            .padding()
                        Text("즐겨찾기")
                            .frame(height: 60)
                        Spacer()
                    }
                }
                NavigationLink {
                    CouponView(coupons: userViewModel.user.coupons)
                } label: {
                    HStack {
                        Image(systemName: "tag")
                            .imageScale(.large)
                            .padding()
                        Text("할인 쿠폰")
                            .frame(height: 60)
                        if userViewModel.user.coupons.count > 0 {
                            Image(systemName: "\(userViewModel.user.coupons.count).circle.fill")
                                .foregroundColor(.blue)
                        }
                        Spacer()
                    }
                }
                
                HStack {
                    Image(systemName: "tag")
                        .imageScale(.large)
                        .padding()
                    Text("CEats 머니")
                        .frame(height: 60)
                    Spacer()
                    Spacer()
                    Text("\(userViewModel.user.cEatsMoney)원")
                    Spacer()
                }
            }
            .foregroundColor(.primary)
            .listStyle(.plain)
        }
        .task {
            userViewModel.fetchUser {
                print("잘가져와짐")
                print(userViewModel.user.favoriteRestaurant.count)
            }
            restaurantViewModel.fetchAllRestaurant()
        }
    }
}


struct MyView_Previews: PreviewProvider {
    @State private static var tabIndex: Int = 4
    static var previews: some View {
        MyView(tabIndex: $tabIndex)
            .environmentObject(UserViewModel())
            .environmentObject(RestaurantViewModel())
    }
}
