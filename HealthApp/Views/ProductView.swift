//
//  ProdcutView.swift
//  HealthApp
//
//  Created by Łukasz on 26/12/2021.
//

import SwiftUI

struct ProductView: View {
    var values = ["Węglowodany","Kalorie","Tłuszcze","Białko","Cukry","Woda"]
    
    @EnvironmentObject var product: CurrentProduct
    var body: some View {
        ScrollView{
            HStack{
                Spacer()
                
                VStack(spacing: 30){
                    HStack{
                        Text(product.name)
                            .font(.system(size: 45,weight: .bold ,design: .serif))
                            .foregroundColor(Color(red: 169/255, green: 169/255, blue: 169/255))
                            .multilineTextAlignment(.leading)
                        
                        Spacer()
                    }
                    
                    HStack{
                        Text("Dane dotyczące produktu podane są dla 100 g (ml) produktu")
                            .font(.system(size: 18,weight: .bold ,design: .serif))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                        
                        Spacer()
                    }
                    
                    VStack(spacing: 40){
                        ForEach(values, id: \.self){ name in
                            HStack{
                                VStack{
                                    Spacer()
                                        .frame(height:10)
                                    
                                    HStack{
                                        Spacer()
                                            .frame(width:7)
                                        
                                        Text(name + ":  ")
                                            .font(.system(size: 25,weight: .bold ,design: .serif))
                                            .foregroundColor(Color(red: 255/255, green: 90/255, blue: 50/255))
                                        
                                        Spacer()
                                        
                                        Text(product.getValue(namePL: name))
                                            .font(.system(size: 25,weight: .bold ,design: .serif))
                                            .foregroundColor(Color(red: 199/255, green: 141/255, blue: 32/255))
                                        
                                        Spacer()
                                            .frame(width: 80)
                                    }
                                    
                                    Spacer()
                                        .frame(height:15)
                                }
                                .background(Color.init(red: 30/255, green: 30/255, blue: 30/255))
                                .cornerRadius(15)
                            }
                        }
                    }
                }
                
                Spacer()
            }
        }
        .navigationBarTitle("", displayMode: .inline)
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        ProductView()
            .preferredColorScheme(.dark)
    }
}
