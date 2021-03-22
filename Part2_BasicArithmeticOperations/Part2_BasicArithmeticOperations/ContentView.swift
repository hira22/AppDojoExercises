//
//  ContentView.swift
//  Part2_BasicArithmeticOperations
//
//  Created by hiraoka on 2021/03/20.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var model: Model = Model()

    var body: some View {

        GeometryReader { geometry in

            VStack(spacing: 20) {
                Group {
                    TextField("", text: $model.value1)
                    TextField("", text: $model.value2)
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)

                Picker(selection: $model.selectedOperation, label: Text("")) {
                    ForEach(Model.Operation.allCases, id: \.self) { operation in
                        Text(operation.rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())

                Button("Button", action: model.calculate)

                Group {
                    switch model.resultState {
                    case .success(let result):
                        Text(String(result))
                    case .failure(let error):
                        Text(error.message)
                    default:
                        EmptyView()
                    }
                }
                .frame(width: 200, alignment: .leading)
                .multilineTextAlignment(.leading)

            }
            .frame(width: 200,
                   height: geometry.frame(in: .global).height,
                   alignment: .topLeading)
            .padding()
        }
    }
}

enum BasicArithmeticError: Error {
    case divideByZero

    var message: String {
        switch self {
        case .divideByZero:
            return "割る数には0以外を入力して下さい"
        }
    }
}

class Model: ObservableObject {
    enum Operation:  String, CaseIterable {
        case addition = "+"
        case subtraction = "-"
        case multiplication = "×"
        case divide = "÷"
    }

    enum ResultState {
        case success(Double)
        case failure(BasicArithmeticError)
    }

    @Published var value1: String = ""
    @Published var value2: String = ""
    @Published var selectedOperation: Operation = .addition
    @Published var resultState: ResultState?

    func calculate() {
        guard let value1: Double = Double(value1),
              let value2: Double = Double(value2)
        else {
            resultState = .none
            return
        }

        if case .divide = selectedOperation,
           value2 == .zero {
            resultState = .failure(.divideByZero)
            return
        }

        let result: Double = {
            switch selectedOperation {
            case .addition:
                return value1 + value2
            case .subtraction:
                return value1 - value2
            case .multiplication:
                return value1 * value2
            case .divide:
                return value1 / value2
            }
        }()

        resultState = .success(result)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
