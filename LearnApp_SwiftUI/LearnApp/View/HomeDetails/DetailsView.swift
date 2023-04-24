//
//  DetailsView.swift
//  LearnApp
//
//  Created by Dipak Amreliya on 13/06/22.
//

import SwiftUI

struct DetailsView: View {
    
    var index : Int
    var strTitle : String
    
    var flexibleLayout = [GridItem(.flexible()), GridItem(.flexible())]
    var flexibleLayoutone = [GridItem(.flexible())]
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        Print("Index \(index)")
        
        VStack{
//            HStack{
//                Button {
//                    self.mode.wrappedValue.dismiss()
//                } label: {
//                    Image(systemName: "arrowshape.turn.up.left.circle")
//                        .frame(width: 50, height: 50, alignment: .center)
//                        .font(.title)
//                        .foregroundColor(.black)
//                }
//                Text(strTitle)
//                    .font(.custom("Roboto-Bold", size: 30))
//                    .padding()
//                Spacer()
//            }
            ScrollView{
                
                if arrCateList[index][1].catName == "months" || arrCateList[index][2].catName == "week" {
                    LazyVGrid(columns: flexibleLayoutone, spacing: 20) {
                        ForEach((arrCateList[index].indices), id: \.self) { item in
                            monthCell(listitem: arrCateList[index][item])
                        }
                    }
                }else{
                    LazyVGrid(columns: flexibleLayout, spacing: 20) {
                        ForEach((arrCateList[index].indices), id: \.self) { item in
                            NavigationLink(destination: FullDetailsView(selectIndex: item, imgCat: arrCateList[index][item].image, arrDetails: arrCateList[index])) {
                                if arrCateList[index][0].catName == "alphabet" {
                                    detailsCell(listitem: arrCateList[index][item])
                                }else {
                                    fruitsCell(listitem: arrCateList[index][item])
                                }
                            }
                        }
                    }
                }

            }
        }
        .navigationTitle(strTitle)
        
       
    }
}

struct HomeDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(index: 0, strTitle: "Details")
    }
}

struct detailsCell: View {
    
    var listitem : homeModel
    var body: some View {
        VStack {
            Spacer()
            HStack{
                Text("\(listitem.name)")
                    .font(.custom("Roboto-Bold", size: 80))
                    .minimumScaleFactor(0.5)
                    .foregroundColor(.black)
                Text("\(listitem.image)")
                    .font(.custom("Roboto-BoldItalic", size: 50))
                    .offset(x: 0, y: 10)
                    .minimumScaleFactor(0.5)
                    .foregroundColor(Color.secondary)
            }
            Spacer()
        }.frame(width: (UIScreen.main.bounds.width - 40)/2, height: (UIScreen.main.bounds.width - 40)/2)
            .background(Color.white)
            .modifier(CardListModifier())
    }
}

struct fruitsCell: View {
    
    var listitem : homeModel
    var body: some View {
        VStack {
            Image("\(listitem.image)")
                .resizable()
                .scaledToFit()
                .padding(.all, 20)
        }.frame(width: (UIScreen.main.bounds.width - 40)/2, height: (UIScreen.main.bounds.width - 40)/2)
            .background(Color.white)
            .modifier(CardListModifier())
    }
}

struct monthCell: View {
    
    var listitem : homeModel
    @ObservedObject var speaker = Speaker()
    
    var body: some View {
        VStack {
            Text("\(listitem.name)")
                .font(.custom("Roboto-Bold", size: 35))
                .minimumScaleFactor(0.5)
                .foregroundColor(.black)
            if listitem.catName == "months"{
                Text("Total Days \(getMonthDay(Int("\(listitem.image)")!))")
                    .font(.custom("Roboto-Regular", size: 25))
                    .offset(x: 0, y: 10)
                    .minimumScaleFactor(0.5)
                    .foregroundColor(Color.secondary)
            }
        }.frame(width: UIScreen.main.bounds.width - 60, height: 100)
            .padding()
            .background(Color.white)
            .modifier(CardListModifier())
            .onTapGesture {
                speaker.speak("\(listitem.name)")
                
            }
    }
}

func getMonthDay(_ month: Int) -> String {
    
    let calendar = Calendar.current
    let dateComponents = DateComponents(year: calendar.component(.year, from: Date()), month: month)
    let date = calendar.date(from: dateComponents)!

    let range = calendar.range(of: .day, in: .month, for: date)!
    let numDays = range.count
    print(numDays) // 31
    return "\(numDays)"
}
