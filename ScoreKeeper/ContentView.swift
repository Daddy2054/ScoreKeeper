//
//  ContentView.swift
//  ScoreKeeper
//
//  Created by Jean on 11/10/24.
//

import SwiftUI

struct ContentView: View {
    @State private var scoreboard = Scoreboard()
    @State private var startingPoints = 0
    
    let range = 1...20
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                
                SettingsView(doesHighestScoreWin: $scoreboard.doesHighestScoreWin, startingPoints: $startingPoints).disabled(scoreboard.state != .setup)
                
                Grid {
                    GridRow {
                        Text("Player")
                            .gridColumnAlignment(.leading)
                        
                        Text("Score")
                            .opacity(scoreboard.state == .setup ? 0 : 1.0)
                    }
                    .font(.headline)
                    //List {
                    ForEach($scoreboard.players) { $player in
                        GridRow {
                            HStack {
                                if scoreboard.winners.contains(player){
                                    Image(systemName: "crown.fill")
                                        .foregroundStyle(Color.yellow)
                                }
                                TextField("Name", text: $player.name)
                            }
                            Text("\(player.score)")
                            Stepper("\(player.score)",
                                    value: $player.score, in: range)
                            
                            .labelsHidden()
                        }
                    }
                }
                //.padding(.zero)
                .padding(.vertical)
                Button("Add Player", systemImage: "plus") {
                    scoreboard.players.append(Player(name: "", score: 0))
                }
                .opacity(scoreboard.state == .setup ? 0 : 1.0)
                
                HStack {
                    Spacer()
                    switch scoreboard.state {
                    case .setup:
                        Button("Start Game", systemImage: "play.fill") {
                            scoreboard.state = .playing
                            scoreboard.resetScores(to: startingPoints)
                        }
                    case .playing:
                        Button("End Game", systemImage: "stop.fill") {
                            scoreboard.state = .gameOver
                        }
                    case .gameOver:
                        Button("Restart Game", systemImage: "arrow.counterclockwise") {
                            scoreboard.state = .setup
                        }
                    }
                    Spacer()
                }
                .buttonStyle(.bordered)
                .buttonBorderShape(.capsule)
                .controlSize(.large)
                .tint(.blue)
            }
            
            //}
            .padding()
            .navigationTitle("Score Keeper")
            .toolbar {
                EditButton()
            }}}
}

#Preview {
    ContentView()
}
