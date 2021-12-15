//
//  SymptomView.swift
//  HealthApp
//
//  Created by Łukasz on 12/12/2021.
//

import SwiftUI

struct SymptomView: View {
    @EnvironmentObject var symptom: CurrentSymptom
    var body: some View {
        ScrollView{
            HStack{
                Spacer()
                
                VStack(spacing: 45){
                    HStack{
                        Text(symptom.name)
                            .font(.system(size: 45,weight: .bold ,design: .serif))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                        
                        Spacer()
                    }
                    
                    VStack(spacing: 15){
                        HStack{
                            Text("Opis")
                                .font(.system(size: 30,weight: .bold ,design: .serif))
                                .foregroundColor(.white)
                            
                            Spacer()
                        }
                        
                        VStack{
                            Spacer()
                                .frame(height:10)
                            
                            HStack{
                                Spacer()
                                    .frame(width:7)
                                
                                Text(symptom.depiction)
                                    .font(.system(size: 22,weight: .regular ,design: .serif))
                                    .multilineTextAlignment(.leading)
                                
                                
                                Spacer()
                            }
                            
                            Spacer()
                                .frame(height:15)
                        }
                        .background(Color.init(red: 30/255, green: 30/255, blue: 30/255))
                        .cornerRadius(15)
                    }
                    
                    VStack(spacing: 15){
                        HStack{
                            Text("Leczenie")
                                .font(.system(size: 30,weight: .bold ,design: .serif))
                                .foregroundColor(.white)
                            
                            Spacer()
                        }
                        
                        VStack{
                            Spacer()
                                .frame(height:10)
                            
                            HStack{
                                Spacer()
                                    .frame(width:7)
                                
                                Text(symptom.treatment)
                                    .font(.system(size: 22,weight: .regular ,design: .serif))
                                    .multilineTextAlignment(.leading)
                                
                                
                                Spacer()
                            }
                            
                            Spacer()
                                .frame(height:15)
                        }
                        .background(Color.init(red: 30/255, green: 30/255, blue: 30/255))
                        .cornerRadius(15)
                    }
                    
                }
                
                Spacer()
            }
        }
        .navigationBarTitle("", displayMode: .inline)
    }
}

struct SymptomView_Previews: PreviewProvider {
    static var previews: some View {
        SymptomView()
            .preferredColorScheme(.dark)
    }
}
