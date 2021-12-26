//
//  ProductsMenuView.swift
//  HealthApp
//
//  Created by Łukasz on 26/12/2021.
//

import SwiftUI

struct ProductsMenuView: View {
    @State private var inProgress: Bool? = false
    @State private var searchText: String = ""
    
    @StateObject var products = ProductsList()
    @StateObject var product = CurrentProduct()
    
    var body: some View {
        ScrollView(showsIndicators: false){
            ZStack{
                NavigationLink(destination: ProductView().environmentObject(product), tag: true, selection: $inProgress){
                    EmptyView()
                }
                VStack(spacing: 30){
                    SearchBar(text: $searchText)
                    HStack{
                        Spacer()
                        VStack(spacing: 0.5){
                            
                            ForEach(products.productsList.filter({ searchText.isEmpty ? true : $0.name.contains(searchText) })
                                    , id: \.self.id){ p in
                                
                                Button(action:{
                                    product.setParameters(name: p.name,
                                                          carbohydrates: p.carbohydrates,
                                                          energy: p.energy,
                                                          fat: p.fat,
                                                          protein: p.protein,
                                                          sugars: p.sugars,
                                                          water: p.water)
                                    inProgress = true
                                }, label: {
                                    HStack{
                                        Spacer()
                                            .frame(width: 15)
                                        Text(p.name.components(separatedBy: ",")[0])
                                            .font(.system(size: 23, weight: .bold, design: .serif))
                                            .foregroundColor(Color.white)
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 7)
                                            .foregroundColor(Color.white)
                                        Spacer()
                                            .frame(width: 20)
                                    }
                                    .frame(maxWidth: 380, minHeight: 60)
                                })
                                    .buttonStyle(MenuButtonStyle())
                                
                            }
                        }
                        .background(Color.gray)
                        .cornerRadius(15)
                        Spacer()
                    }
                }
            }
        }.navigationBarTitle("Produkty")
         .onAppear {
             products.updateData()
         }
    }
}

struct ProductsMenuView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsMenuView()
    }
}
