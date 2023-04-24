//
//  SettingView.swift
//  LearnApp
//
//  Created by Dipak Amreliya on 22/06/22.
//

import SwiftUI

struct SettingView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.openURL) var openURL
    
    let positions = [settingModel(id: 1, name: "Share", imgName: "ic_share")
        ]
    
    var body: some View {
        
        VStack{
            HStack{}.frame(height: 40)
            HStack{
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Back")
                        .padding(.all, 10)
                }
                Spacer()
            }.frame(height: 60)
            Button {
                print("Pro")
            } label: {
                Text("Show More")
                    .foregroundColor(Color.white)
                    .fontWeight(.semibold)
                    .font(.title2)
                    .frame(width: UIScreen.main.bounds.width - 50, height: 50, alignment: .center)
                    .background(Color.black)
                    .cornerRadius(25)
                    
            }
            List {
                ForEach(positions) { position in
                    
                    Button {
                        print("Index \(position.id)")
                       
                    } label: {
                        HStack{
                            Image(position.imgName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                            Text("   \(position.name)")
                                .fontWeight(.medium)
                                .font(.title3)
                                .padding(.all, 10)
                            Spacer()
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(UIColor.secondarySystemBackground))
        .edgesIgnoringSafeArea(.all)
        
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}

struct settingModel: Identifiable {
    let id: Int
    let name: String
    let imgName: String
}
