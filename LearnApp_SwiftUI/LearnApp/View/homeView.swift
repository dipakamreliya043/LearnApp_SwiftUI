//
//  homeView.swift
//  LearnApp
//
//  Created by Dipak Amreliya on 13/06/22.
//

import SwiftUI

struct homeView: View {
    
    var flexibleLayout = [GridItem(.flexible())]
    @State var showingSetting = false
    
    var body: some View {
        NavigationView {
            ScrollView{
                LazyVGrid(columns: flexibleLayout, spacing: 20) {
                    ForEach((arrHome.indices), id: \.self) { item in
                        Print(item)
                        if item == 4{
                            NavigationLink(destination: AnimalsList()) {
                                homeCell(listitem: arrHome[item])
                            }
                        }else{
                            NavigationLink(destination: DetailsView(index: item, strTitle: arrHome[item].name)) {
                                homeCell(listitem: arrHome[item])
                            }
                        }
                    }
                }
            }.navigationBarTitle("Home")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(leading: Button(action: {
                    self.showingSetting.toggle()
                }) {
                    Image(systemName: "gearshape")
                        .foregroundColor(Color.black)
                }.fullScreenCover(isPresented: $showingSetting, onDismiss: {
                    print("dismiss")
                }, content: {
                    SettingView()
                }))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        homeView()
    }
}


struct homeCell: View {
    
    var listitem : homeModel
    var body: some View {
        HStack {
            Image(listitem.image)
                .resizable()
                .scaledToFit()
                .frame(width: 78, height: 78, alignment: .leading)
                .padding([.horizontal, .vertical])
            Text(listitem.name)
                .foregroundColor(Color.black)
                .fontWeight(.semibold)
                .font(.title2)
            Spacer()
        }.frame(width: (UIScreen.main.bounds.width - 30), height: 130)
            .background(Color.white)
            .modifier(CardListModifier())
    }
}

struct CardListModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .cornerRadius(16)
            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 0)
    }
}

extension View {
    func Print(_ vars: Any...) -> some View {
        for v in vars { print(v) }
        return EmptyView()
    }
}
