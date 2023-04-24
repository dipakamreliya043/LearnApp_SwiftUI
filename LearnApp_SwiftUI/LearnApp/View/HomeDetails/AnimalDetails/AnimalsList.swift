//
//  AnimalsList.swift
//  LearnApp
//
//  Created by Dipak Amreliya on 20/06/22.
//

import SwiftUI

struct AnimalsList: View {
    
    let arrAnimals = [
            AnimalData(title: "Demostic animal", items: [homeModel(id: 1, image: "Cow", des: "Cow", catName: "anim1"),
                                                homeModel(id: 2, image: "Ox", des: "Ox", catName: "anim1"),
                                                homeModel(id: 3, image: "Buffalo", des: "Buffalo", catName: "anim1"),
                                                homeModel(id: 4, image: "Camel", des: "Camel", catName: "anim1"),
                                                homeModel(id: 5, image: "Cat", des: "Cat", catName: "anim1"),
                                                homeModel(id: 6, image: "Dog", des: "Dog", catName: "anim1")]),
            
            AnimalData(title: "Wild animal", items: [homeModel(id: 1, image: "Bear", des: "Bear", catName: "anim2"),
                                                     homeModel(id: 2, image: "Bison", des: "Bison", catName: "anim2"),
                                                     homeModel(id: 3, image: "Chimpanzee", des: "Chimpanzee", catName: "anim2"),
                                                     homeModel(id: 4, image: "Crocodile", des: "Crocodile", catName: "anim2"),
                                                     homeModel(id: 5, image: "Dear", des: "Dear", catName: "anim2"),
                                                     homeModel(id: 6, image: "Elephant", des: "Elephant", catName: "anim2")]),
            
            AnimalData(title: "Under water animal", items: [homeModel(id: 1, image: "1Whale", des: "Whale", catName: "anim3"),
                                                            homeModel(id: 2, image: "2Sea_Anemone", des: "Sea Anemone", catName: "anim32"),
                                                            homeModel(id: 3, image: "3Sea-Horse", des: "Sea Horse", catName: "anim3"),
                                                            homeModel(id: 4, image: "4Shark", des: "Shark", catName: "anim3"),
                                                            homeModel(id: 5, image: "Clown_Fish", des: "Clown Fish", catName: "anim3")])]
    
    
    var body: some View {
        List{
            ForEach(arrAnimals) { animals in
                Section(header: Text(animals.title.capitalized)
                            .foregroundColor(Color.black)
                            .font(.custom("Roboto-Medium", size: 20))){
                    ScrollView(.horizontal) {
                        LazyHGrid(
                            rows: [GridItem(.adaptive(minimum: 130), spacing: 15)],
                            spacing: 12) {
                                ForEach((animals.items.indices), id: \.self) { item in
                                    NavigationLink(destination: FullDetailsView(selectIndex: item, imgCat: animals.items[item].image, arrDetails: animals.items)) {
                                        animalCell(listitem: animals.items[item])
                                    }
                                }
                            }
                    }
                }.textCase(nil)
            }.listRowBackground(Color.clear)
        }.navigationBarTitle("Animal")
    }
}

struct CardAniModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            
            .border(Color.black.opacity(0.2), width: 0.2)
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 0)
    }
}


struct animalCell: View {
    
    var listitem : homeModel
    var body: some View {
        Image(listitem.image)
            .resizable()
            .scaledToFit()
            .frame(width: 110, height: 100)
            .padding([.horizontal, .vertical])
            .background(Color.white)
            .modifier(CardAniModifier())
            .padding(.all, 3)
    }
}

struct AnimalsList_Previews: PreviewProvider {
    static var previews: some View {
        AnimalsList()
    }
}

