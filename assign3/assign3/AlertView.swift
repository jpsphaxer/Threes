//
//  AlertView.swift
//  assign2
//
//  Created by Josue Proano on 3/10/22.
//

import Foundation
import SwiftUI

struct AlertView : View {
    @EnvironmentObject var triples : Triples 
    //@State var score : Int
    let image = "☠️"
    
    var body : some View {
        
        VStack {
            Text(image).font(.system(size: 20.0)).padding(10)
            Text ("Game Over").font(.headline).bold()//.padding()
            //Text("Score \(triples.score)")
            Spacer()
            Divider()
            
            HStack{
                Button("New Game?"){
                
                }.frame(width: UIScreen.main.bounds.width/2-30, height: 40).foregroundColor(.white)
            
            }
        }
        .frame(width:UIScreen.main.bounds.width - 50 , height: 200)
        .background(Color.black.opacity(0.2))
        .cornerRadius(30)
        .clipped()
        
    }
    
    
}



struct AlertView_Previews: PreviewProvider{
    static var previews: some View{
        AlertView()
    }
}
