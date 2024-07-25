//
//  ContentView.swift
//  CalculadoraSwiftUI
//
//  Created by Felipe Salviano on 05/07/24.
//

import SwiftUI

struct ContentView: View {
    @State private var display = "0"
    @State private var firstNumber: Double?
    @State private var secondNumber: Double?
    @State private var currentOperation: String?
    
    let buttons: [[String]] = [
        ["C", "⌫", "%", "/"],
        ["7", "8", "9", "*"],
        ["4", "5", "6", "-"],
        ["1", "2", "3", "+"],
        ["0", ".", "=", ""]
    ]
    
    var body: some View {
        ZStack{
            Color.black.edgesIgnoringSafeArea(.all)
        VStack {
            Spacer()
            Text(display)
                .font(.largeTitle)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity, alignment: .trailing)
                .background(Color.gray.opacity(0.5))
                .cornerRadius(10)
                .padding()
            
            ForEach(buttons, id: \.self) { row in
                HStack {
                    ForEach(row, id: \.self){
                        button in
                        if button != ""{
                        Button(action: {
                            self.buttonTapped(button)
                        }){
                            Text(button)
                                .font(.title)
                                .frame(width: self.buttonWidth(button: button), height: self.buttonHeight())
                                .background(self.buttonColor(button: button))
                                .foregroundColor(.white)
                                .cornerRadius(35)
                                .padding(5)
                            }
                        }
                    }
                }
            }
        }
        .padding()
    }
}
    
    func buttonTapped (_ button: String){
        switch button {
        case "0"..."9",".":
            if display == "0" {
                display = button
            } else {
                display.append(button)
            }
        case"+", "-", "*", "/":
            firstNumber = Double(display)
            currentOperation = button
            display = "0"
        case "=":
            if let firstNumber = firstNumber,
               let secondNumber = Double(display),
               let operation = currentOperation { switch operation {
               case "+":
                   display = "\(firstNumber + secondNumber)"
               case "-":
                   display = "\(firstNumber - secondNumber)"
               case "*":
                   display = "\(firstNumber * secondNumber)"
               case "/":
                   display = "\(firstNumber / secondNumber)"
               default: break
               }
            }
            
        case "C":
            display = "0"
            firstNumber = nil
            secondNumber = nil
            currentOperation = nil
        case "⌫":
            if !display.isEmpty{
                display.removeLast()
                if display.isEmpty{
                    display = "0"
                }
            }
        case "%":
            if let number = Double (display){
                display = "\(number / 100)"
            }
        default:
            display = "0"
            firstNumber = nil
            secondNumber = nil
            currentOperation = nil
        }
    }
    
    //funcao para largura dos botoes
    
    func buttonWidth (button: String) -> CGFloat {
        if button == "0"{
            return (UIScreen.main.bounds.width - 5*12) / 2
        }
        return (UIScreen.main.bounds.width - 5 * 12) / 4
    }
    
    //funcao para altura dos botoes
    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - 5 * 12) / 4
    }
    
    //funcao para a cor dos botoes
    func buttonColor (button: String) -> Color{
        switch button {
        case "C", "⌫", "%":
            return Color(red: 255/255, green: 137/255, blue: 0/255)
        case "/", "*", "-", "+":
            return .purple
        default:
            return .gray
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
