//
//  AboutView.swift
//  assign3
//
//  Created by Josue Proano on 3/20/22.
//

import Foundation
import SwiftUI


struct Drawing {
    let id = UUID()
    var col  = Color.blue
    var wid  = 5.0
    
    private var points = [CGPoint]()
    private var breaks = [Int]()
    
    
    
    mutating func addPoint (_ point : CGPoint){
        points.append(point)
    }
    
    
    mutating func addbreak() {
        breaks.append(points.count)
    }
    
    mutating func clear() {
        points = [CGPoint]()
        breaks = [Int]()
    }
    
    
    var path: Path {
        var path = Path()
        guard let firstPoint = points.first else { return path }
        path.move(to: firstPoint)
        for i in 1..<points.count {
            if breaks.contains(i) {
                path.move(to: points[i])
            } else {
                path.addLine(to: points[i])
            }
            
        }
        //path.fill(.clear)
        return path
    }
    
} 


struct DrawShape: Shape {
    let drawingPath: Drawing
    //var drawings : [Drawing]
    
    func path(in rect: CGRect) -> Path {
        drawingPath.path//.fill(.clear)
        
    }
}



struct DrawViewTest: View {
    @Binding var drawing: Drawing
    @Binding var drawings : [Drawing]// = [Drawing]()
    @Binding var color : Color //= .blue
    @Binding var width : Double
    @State var pos : CGPoint = CGPoint(x: 0, y: 0)//= 5.0
    
    var body: some View {
        
        GeometryReader{ geometry in
            ZStack {
                Color.gray.opacity(0.15) // drawing background
                DrawShape(drawingPath: drawing)
                    .stroke(lineWidth: width)
                    .foregroundColor(color) //if i uncomment then it shows the path i am drawing with a black "net"
                
                Circle()
                    .frame(width: 10, height: 10)
                    .foregroundColor(color)
                    .position(pos)
                
                ForEach(drawings, id: \.id) {
                    drawing in DrawShape(drawingPath: drawing)
                        .stroke(lineWidth: drawing.wid) // define stroke width
                        .foregroundColor(drawing.col)
                }
                
            }.gesture(DragGesture(minimumDistance:0.001)
                        .onChanged( { value in
                if(value.location.y >= 0 && value.location.y <= geometry.size.height){ //limit borders
                    drawing.addPoint(value.location)
                    pos = (value.location)
                
                }
                
            }).onEnded( { value in
                pos.x = 0
                pos.y = 0
                drawing.addbreak()
                drawing.col = color
                drawing.wid = width
                drawings.append(drawing)
                drawing = Drawing()
                //drawing.col = color
            }))
        }.frame(maxHeight:.infinity)//.padding()
        
        
        
    }

    func changecolor(){
        
    }
    
}


struct About : View {
    
    @State var drawing : Drawing = Drawing()
    @State var drawings : [Drawing] = [Drawing]()
    @State var color : Color = .black
    @State var width : Double = 5.0
    
    var body : some View {
        
        
        
        VStack{
            Text("Draw Something!").font(.system(size:35,weight: .heavy)).foregroundColor(color)//.font(.headline).padding()
            
            DrawViewTest(drawing: $drawing,drawings : $drawings,color: $color,width: $width)
                .frame(maxWidth:.infinity, maxHeight:.infinity)
                
            
            
            HStack{
                
                
                VStack{
                    Text("Line width: \(Int(width))")
                   
                    Slider(value: $width, in: 1.0...15.0, step:1.0).padding()
                }//.padding()
                //Spacer()
                VStack{
                    
                    ColorPicker("",selection:$color).labelsHidden()
                        .frame(width:10,height: 10)
                        .scaleEffect(CGSize(width: 2, height: 2))
                        .padding()
                        
                    Button( action: clear_drawing){
                        Text("Clear")
                            .frame(width:50, height:50)
                            .foregroundColor(.white)
                            .background(.blue)
                            .clipShape(Capsule())
                        //.animation(.easeOut(duration: 0.2))
                    }.padding()
                    
                      
                        //.padding()
                }.padding()
                
                //original "color picker"
                
                //                Menu {
                //                    Button("Blue", action:{color = .blue})
                //                    Button("Red", action:{color = .red})
                //                    Button("Yellow", action:{color = .yellow})
                //                    Button("Black", action:{color = .black})
                //                } label: {
                //                    Button("Color", action:{})
                //                        .frame(width:50, height:50)
                //                        .foregroundColor(.white)
                //                        .background(color)
                //                        .clipShape(Capsule())
                //                        //.animation(.easeOut(duration: 0.2))
                //
                //                }
                //.padding()
                
                
            }
        }
        
        
        
        
    }
    func clear_drawing(){
        
        print("clearing drawing")
        //print(drawing.path)
        drawing.clear()
        drawings = []
        //print(drawing.path)
    }
    
    
}


struct About_preview : PreviewProvider{
    static var previews : some View{
        
        About()
    }
    
}
