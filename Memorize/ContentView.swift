//
//  ContentView.swift
//  Memorize
//
//  Created by Valenlyn Chua on 30/5/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack{
            VStack {
                HStack {
                    Text(viewModel.theme.name)
                    Spacer()
                    Text("Score: \(viewModel.score)")
                }
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card: card)
                            }
                    }
                }
                Spacer()
            }
                .foregroundColor(viewModel.theme.color)
                .padding(.horizontal)
            Button("New Game") {
                  viewModel.restart()
            }
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
