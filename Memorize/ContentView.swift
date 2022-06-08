//
//  ContentView.swift
//  Memorize
//
//  Created by Valenlyn Chua on 30/5/22.
//

import SwiftUI

struct ContentView: View { // this struct behaves as a view
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View { // view is a rectangular area on the screen
        VStack{
            VStack {
                Text("Memorize!")
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card: card)
                            }
                    }
                }
            }
                .foregroundColor(.red)
                .padding(.horizontal)
        }
    }
    
    var animals: some View {
        Button {
            print("aniamls")
        } label: {
            VStack{
                Image(systemName: "hare.fill")
                Text("Animals")
            }
            .padding()
        }
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
  
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if (card.isFaceUp) {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle)
            } else if card.isMatched {
                shape.opacity(0)
            } else {
                shape.fill()
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        ContentView(viewModel: game)
            .preferredColorScheme(.light)
        ContentView(viewModel: game)
            .preferredColorScheme(.dark)
    }
}
