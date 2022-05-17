//
//  ContentView.swift
//  assign2
//
//  Created by Josue Proano on 3/7/22.
//

import SwiftUI


struct ContentView: View {
    
    @EnvironmentObject var triples : Triples
    @EnvironmentObject var scores : ScoreList

    //@State private var moved : Bool
    
    
    var body: some View {
        VStack{
        TabView{
            Board().tabItem{
                Label("Board",systemImage: "gamecontroller")
            }
            Scores().tabItem{
                Label("Scores",systemImage: "list.dash")
            }
            About().tabItem{
                Label("About",systemImage: "info.circle")
            }
        }
        
        }
           
        
    }
}

struct ContentView_Previews: PreviewProvider {
    @State var moved : Bool
    static var previews: some View {
        ContentView().environmentObject(Triples()).environmentObject(ScoreList())
    }
}
