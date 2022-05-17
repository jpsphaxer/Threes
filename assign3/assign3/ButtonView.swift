
import Foundation
import SwiftUI


// I used a tutorial to learn about this and decided to use the code to make the app better.
// my original button view is at the bottom commented out
struct Grow : ButtonStyle{
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width:50)
            .padding()
            .background(Color.blue)
            .foregroundColor(Color.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
    
    
}

struct Grow2 : ButtonStyle{
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width:100)
            .padding()
            .background(Color.green)
            .foregroundColor(Color.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
    
    
}





struct ButtonView : View {
    @EnvironmentObject var triples : Triples
    @EnvironmentObject var scores : ScoreList
    @State private var deterministic = false
    @State var moved = false
    //@State private var gameover = triples.gameOver
    @State private var mode  = "Random"
    
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    
    var drag: some Gesture{
        DragGesture(minimumDistance: 0, coordinateSpace: .local)
            .onEnded{ v in
                
                if v.translation.width < 0 && v.translation.height > -40 && v.translation.height < 40{
                    left()
                    print("left")
                }
                
                if v.translation.width > 0 && v.translation.height > -40 && v.translation.height < 40{
                    right()
                    print("right)")
                }
                
                if v.translation.height < 0 && v.translation.width < 50 && v.translation.width > -50{
                    up()
                    print("up")
                }
                
                if v.translation.height > 0 && v.translation.width < 50 && v.translation.width > -50{
                    down()
                    print("down")
                }
            }
    }
    
    var body : some View {
        
        
        
        if verticalSizeClass == .regular{
            
            VStack{
                
                Text("Score: \(triples.score)").font(.system(size:35,weight: .heavy))
                
                TileView(moved: $moved)
                    .padding()
                    .gesture(drag)
                
            }
            HStack{
                Button(action : left){
                    Text("Left")
                }.buttonStyle(Grow())
                
                VStack{
                    Button(action : up){
                        Text("Up")
                    }.buttonStyle(Grow())
                    
                    
                    Button(action : down){
                        Text("Down")
                    }.buttonStyle(Grow())
                }
                
                
                Button(action : right){
                    Text("Right")
                }.buttonStyle(Grow())
            }
            
            HStack{
                VStack{
                    Toggle(isOn: $deterministic){
                        Text("Game Mode: \(deterministic ? "Deterministic" : "Random")").bold()
                        
                    }.padding()
                    
                    Button(action: newGame){
                        Text("New Game")
                    }.buttonStyle(Grow2())
                }.alert(isPresented: $triples.gameOver){
                    Alert(
                        title: Text("Game Over"),
                        message: Text("Score \(triples.score)"),
                        dismissButton: Alert.Button.default(
                            Text("Play Again"), action: {
                                recordScore()
                                start()
                            }))
                }
            }
        }
        else {
            HStack{
                VStack{
                   
                    TileView(moved: $moved).scaledToFit()
            
                        .gesture(drag)
                    
                    
                }.padding()
                VStack{
                    Text("Score: \(triples.score)").font(.system(size:35,weight: .heavy))
                
                HStack{
                    Button(action : left){
                        Text("Left")
                    }.buttonStyle(Grow())
                    
                    VStack{
                        Button(action : up){
                            Text("Up")
                        }.buttonStyle(Grow())
                        
                        
                        Button(action : down){
                            Text("Down")
                        }.buttonStyle(Grow())
                    }
                    
                    
                    Button(action : right){
                        Text("Right")
                    }.buttonStyle(Grow())
                }
                
                HStack{
                    VStack{
                        Toggle(isOn: $deterministic){
                            Text("Game Mode: \(deterministic ? "Deterministic" : "Random")").bold()
                            
                        }.padding()
                        
                        Button(action: newGame){
                            Text("New Game")
                        }.buttonStyle(Grow2())
                    }.alert(isPresented: $triples.gameOver){
                        Alert(
                            title: Text("Game Over"),
                            message: Text("Score \(triples.score)"),
                            dismissButton: Alert.Button.default(
                                Text("Play Again"), action: {
                                    recordScore()
                                    start()
                                }))
                    }
                }
                }
                
                
                
                
                
            }
        }
        
    }
    
    
    func start() {
        triples.newgame(choice: deterministic)
        triples.spawn()
        triples.spawn()
        triples.spawn()
        triples.spawn()
        //recordScore()
        
    }
    
    func recordScore() {

        scores.addScore(score: Score(score: triples.score, time: Date()))
    }
    
    
    func newGame() {
        triples.gameOver = true
        triples.gameOver = true //adding this 2nd statement fixed the finishing gamething
    }
    
    
    func left () {
        let spawn = triples.collapse(dir: .left)
        
        if moved {
            moved = false
        }else {
            moved = true
        }
        
        if(spawn){
            triples.spawn()
        }
        triples.isGameOver()
        
    }
    
    func right () {
        let spawn = triples.collapse(dir: .right)
        if moved {
            moved = false
        }else {
            moved = true
        }
        
        if(spawn){
            triples.spawn()
            
        }
        triples.isGameOver()
        
    }
    
    func up () {
        let spawn = triples.collapse(dir: .up)
        if moved {
            moved = false
        }else {
            moved = true
        }
        
        if(spawn){
            triples.spawn()
            
        }
        triples.isGameOver()
        
    }
    
    func down() {
        
        let spawn = triples.collapse(dir: .down)
        if moved {
            moved = false
        }else {
            moved = true
        }
        
        if(spawn){
            triples.spawn()
            
        }
        triples.isGameOver()
        
    }
    
}


struct ButtonView_Preview : PreviewProvider{
    
    static var previews : some View{
        ButtonView().environmentObject(Triples()).environmentObject(ScoreList())
    }
    
}

//
//
//
//struct ButtonView : View {
//    @EnvironmentObject var triples : Triples
//    @State private var deterministic = false
//    @State private var mode  = "Random"
//
//
//    var body : some View {
//        HStack{
//            Button(action : left){
//                Text("Left").foregroundColor(Color.white).frame(width:50)
//            }.padding()
//                .background(Color.blue)
//                .clipShape(Capsule())
//
//            VStack{
//                Button(action : up){
//                    Text("Up").foregroundColor(Color.white).frame(width:50)
//                }.padding()
//                    .background(Color.blue)
//                    .clipShape(Capsule())
//
//
//                Button(action : down){
//                    Text("Down").foregroundColor(Color.white).frame(width:50)
//                }.padding()
//                    .background(Color.blue)
//                    .clipShape(Capsule())
//            }
//
//
//            Button(action : right){
//                Text("Right").foregroundColor(Color.white).frame(width:50)
//            }.padding()
//                .background(Color.blue)
//                .clipShape(Capsule())
//        }
//
//        HStack{
//            VStack{
//                Toggle(isOn: $deterministic){
//                    Text("Game Mode: \(deterministic ? "Deterministic" : "Random")").bold()
//                }.padding()
//                //Text("\(deterministic ? "Deterministic" : "Random")")
//                Button(action: start){
//                    Text("New Game").foregroundColor(Color.white)
//                }.padding()
//                    .background(Color.green)
//                    .clipShape(Capsule())
//            }
//
//        }
//
//    }
