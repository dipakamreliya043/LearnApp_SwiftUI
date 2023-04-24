//
//  FullDetailsView.swift
//  LearnApp
//
//  Created by Dipak Amreliya on 13/06/22.
//

import SwiftUI
import UIKit
import AVFoundation

struct FullDetailsView: View {
    
    @State var selectIndex : Int
    @State var imgCat : String
    
    @State var arrDetails = [homeModel]()
    
    @ObservedObject var speaker = Speaker()
    
    var body: some View {
        ProductCard(image: "\(arrDetails[selectIndex].image)", title: "\(arrDetails[selectIndex].des)")
        Spacer()
        
        HStack{
            Button {
                if selectIndex > 0{
                    selectIndex -= 1
                }
            } label: {
                Image(systemName: "arrowshape.turn.up.left.circle")
                    .frame(width: 50, height: 50, alignment: .center)
                    .font(.title)
                    .foregroundColor(.black)
            }
            Spacer()
            Button {
                speaker.speak("\(arrDetails[selectIndex].des)")
            } label: {
                Image(systemName: "speaker.wave.3")
                    .frame(width: 50, height: 50, alignment: .center)
                    .font(.title)
                    .foregroundColor(.black)
            }
            Spacer()
            Button {
                if selectIndex < arrDetails.count - 1{
                    selectIndex += 1
                }
            } label: {
                Image(systemName: "arrowshape.turn.up.right.circle")
                    .frame(width: 50, height: 50, alignment: .center)
                    .font(.title)
                    .foregroundColor(.black)
            }

            
        }.frame(width: UIScreen.main.bounds.width * 0.94, height: 60)
            .background(Color.white)
            .modifier(CardListModifier())
            .padding(.all, 10)
       
    }
}

//struct FullDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        FullDetailsView(selectIndex: 0, imgCat: "img", strTitle: "Home")
//    }
//}

struct CardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            
            .border(Color.black.opacity(0.4), width: 0.2)
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 0)
    }
}

struct ProductCard: View {
    
    var image: String
    var title: String
    
    var body: some View {
        VStack(spacing: 30) {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width * 0.75, height: UIScreen.main.bounds.width * 0.85, alignment: .center)
                .padding(.all, 20)
            Text(title)
                .font(.system(size: 26, weight: .bold, design: .default))
                .foregroundColor(.black)
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width * 0.94, height: UIScreen.main.bounds.width * 1.2)
        .background(Color.white)
        .modifier(CardModifier())
        .padding(.all, 10)
    }
}



class Speaker: NSObject, ObservableObject, AVSpeechSynthesizerDelegate {
    let synth = AVSpeechSynthesizer()
    @Published var label: NSAttributedString? // <- change to AttributedString
    

    override init() {
        super.init()
        synth.delegate = self
    }

    func speak(_ string: String) {
        let utterance = AVSpeechUtterance(string: string)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = 0.4
        synth.speak(utterance)
    }
    
    // Functions to highlight text
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) {
        let mutableAttributedString = NSMutableAttributedString(string: utterance.speechString)
        mutableAttributedString.addAttribute(.foregroundColor, value: UIColor.red, range: characterRange)
        label = mutableAttributedString
        print(label)
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        label = NSAttributedString(string: utterance.speechString)
    }
}

struct LabelRepresented: UIViewRepresentable {
    var text : NSAttributedString?
    
    func makeUIView(context: Context) -> UILabel {
        return UILabel()
    }
    
    func updateUIView(_ uiView: UILabel, context: Context) {
        uiView.attributedText = text
    }
}
