//
//  assign3App.swift
//  assign3
//
//  Created by Josue Proano on 3/20/22.
//

import SwiftUI

@main
struct assign3App: App {
    @StateObject var triples : Triples = Triples()
    @StateObject var scores : ScoreList = ScoreList()

    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(triples).environmentObject(scores)
            
        }
    }
}
