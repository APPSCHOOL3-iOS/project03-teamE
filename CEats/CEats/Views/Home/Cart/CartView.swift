//
//  CartView.swift
//  CEats
//
//  Created by 박범수 on 2023/09/07.
//

import SwiftUI

struct CartView: View {
    // MARK: - Properties
    @Binding var isOpenMapSheet: Bool
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var tabViewModel: TabViewModel
    @EnvironmentObject private var userViewModel: UserViewModel
    @State private var showingAlert: Bool = false
    @State private var isOpenOrderedSheet: Bool = false
    @Binding var tabIndex: Int
    @State private var isEdited: Bool = false
    @State private var progress: CGFloat = 0.0
    @State private var isAnimating = false
    
    // MARK: - View
    var body: some View {
        VStack {
            if userViewModel.user.foodCart?.cart.isEmpty ?? false {
                VStack(spacing: 50) {
                    VStack {
                        Image(systemName: "cart")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.lightgray)
                            .padding()
                        
                        Text("장바구니가 비어있습니다.")
                            .foregroundColor(.lightgray)
                        
                        Button {
                            do { withAnimation(.easeOut(duration: 0.1)) {
                                self.isAnimating.toggle()
                                self.progress = self.isAnimating ? 1 : 0
                            }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                    tabIndex = 0
                                    self.isAnimating.toggle()
                                    self.progress = 0
                                }
                            }
                        } label: {
                            ZStack(alignment: .leading) {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 2)
                                    .frame(width: 180, height: 50)
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.gray)
                                    .frame(width: 180 * progress, height: 50)
                                    .animation(.linear(duration: 0.3), value: isAnimating)
                                Text("쿠팡이츠 맛집 구경가기")
                                    .foregroundColor(.black)
                                    .frame(width: 180, height: 50)
                            }
                        }
                    }
                }
                .navigationBarBackButtonHidden()
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        CEatsNavigationBackButton {
                            dismiss()
                        }
                    }
                }
            } else {
                ScrollView(showsIndicators: false) {
                    CartDeliveryView(isOpenMapSheet: $isOpenMapSheet)
                    CartMenuView()
                    CartPayView()

                    CartPayButtonView(showingAlert: $showingAlert)
                }
                
                .alert("결제 하시겠습니까?", isPresented: $showingAlert) {
                    Button("뒤로가기") {
                        showingAlert = false
                    }
                    Button {
                        userViewModel.newOrder { result in
                            isOpenOrderedSheet = true
                        }
                    } label: {
                        Text("결제하기")
                    }
                } message: {
                    //                Text("주문이 성공적으로 완료되었습니다.")
                }
                
                .onChange(of: tabViewModel.tabIndex) { _ in
                    print("tab Change")
                    dismiss()
                }
            }
        }
        .fullScreenCover(isPresented: $isOpenOrderedSheet) {
            RealTimeOrderInfoView(isOpenOrderedSheet: $isOpenOrderedSheet, completion: { dismiss() })
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CartView(isOpenMapSheet: .constant(false), tabIndex: .constant(2))
                .environmentObject(UserViewModel())
                .environmentObject(RestaurantViewModel())
                .environmentObject(TabViewModel())
        }
    }
}
