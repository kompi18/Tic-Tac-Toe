//
//  ContentView.swift
//  tictactoe
//
//  Created by P.M. Student on 1/28/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        NavigationView {
        Home()
            .navigationTitle("Tic Tac Toe")
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}

}

struct Home: View {
    
    // For the number of moves
    @State var moves : [String] = Array(repeating: "", count: 9)
    // Indentifies the current player
    @State var isPlaying = true
    @State var gameOver = false
    @State var msg = ""
    
    var body: some View {
        VStack {
            
            LazyVGrid(columns: Array(repeating:
                                        GridItem(.flexible(),spacing: 15), count: 3), spacing: 15) {
                ForEach(0..<9, id: \.self)
                { index in
                    ZStack {
                        
                        Color.red
                        
                        Color.orange
                            .opacity(moves[index] == "" ? 1 : 0)
                        
                        Text(moves[index])
                            .font(.system(size: 55))
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                        
                    }
                    
                    .frame(width: getWidth(), height: getWidth())
                    .cornerRadius(15)
                    .onTapGesture(perform: {
                        withAnimation(Animation.easeIn(duration: 0.5)) {
                        
                            if moves[index] == "" {
                                moves[index] = isPlaying ? "x" : "o"
                            isPlaying.toggle()
                            }
                        }
                        })
        }

                                        
        }
                .padding (15)
        
        }
        .onChange(of: moves, perform: { value in
            checkWinner()
        
        })
        
        .alert(isPresented: $gameOver, content: {
         
            Alert(title: Text("Winner"), message:Text(msg), dismissButton: .destructive(Text("Play Again"),action: {
                    
                    withAnimation(Animation.easeIn(duration: 0.5)){
                        
                        moves.removeAll()
                        moves = Array(repeating: "", count: 9)
                        isPlaying = true
                    }
            }))
        })
    }
            // used to calculate width.
            
            func getWidth() -> CGFloat {
            let width = UIScreen.main.bounds.width - (30 + 30)
            
            return width / 3
}
    func checkWinner() {
        
        if checkMoves(player: "X") {
           
            msg = "Player X Won!!!"
            gameOver.toggle()
        }
           else if checkMoves(player: "O") {
               
                msg = "Player O Won!!!"
                gameOver.toggle()
            } else {
                let status = moves.contains { (value) -> Bool
                    in
                    return value == ""
                }
                if !status {
                    msg = "Game Over TIED!"
                    gameOver.toggle()
                }
            }
    }
        
func checkMoves (player: String) -> Bool {
    //Check for horizontal moves
    for contestant in stride(from: 0, to: 9, by: 3) {
        if moves[contestant] == player && moves[contestant+1] == player && moves[contestant+2] == player {
            
            return true
    }
}
    //Check for vertical moves
    for contestant in 0...2 {
        if moves[contestant] == player && moves[contestant+3] == player && moves[contestant+6] == player {
            return true
        }
    }
    
    //Check for diagonal moves
    if moves[0] == player && moves [4] == player && moves[8] == player {
        return true
    }
    
    if moves[2] == player && moves[4] == player && moves[6] == player {
        return true
    }
    return false
}

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
