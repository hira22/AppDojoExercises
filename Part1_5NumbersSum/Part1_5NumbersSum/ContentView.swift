//
//  ContentView.swift
//  Part1_5NumbersSum
//
//  Created by hiraoka on 2021/03/17.
//

import SwiftUI

struct ContentView: View {
    @State private var values: [String] = ["", "", "", "", ""]    
    @State private var sum: String = "Label"
    
    var body: some View {
        GeometryReader { geometry in
            
            VStack(spacing: 16) {
                
                ForEach(0..<values.count) { index in
                    TextField("", text: $values[index])
                }
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 100)
                
                Button("Button") {
                    let sum = values.reduce(0) { (result, value) in
                        return result + (Int(value) ?? 0)
                    }
                    
                    self.sum = String(sum)
                }
                
                Text(sum)
                    .frame(width: 100, alignment: .leading)
            }
            .frame(width: geometry.frame(in: .global).width,
                   height: geometry.frame(in: .global).height,
                   alignment: .topLeading)
            
        }
        .padding()

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
