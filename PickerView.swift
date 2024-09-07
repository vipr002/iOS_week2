//
//  PickerView.swift
//  Forelesning3
//
//  Created by Victoria Prigel on 03/09/2024.
//

import SwiftUI

struct PickerView: View {
    @State private var selectedSymbol = SomeSfSymbols.allCases.first! // valgt symbol
    
    var body: some View {
        VStack {
            Picker("Select Symbol", selection: $selectedSymbol) {
                ForEach(SomeSfSymbols.allCases, id: \.self) { sfSymbol in
                    HStack {
                        Image(systemName: sfSymbol.rawValue)
                            .padding(.trailing, 5)
                    }
                }
            }
            .pickerStyle(WheelPickerStyle()) // ønsket PickerStyle
            .frame(height: 150) // høyden på Picker

            Text("Selected symbol: \(selectedSymbol.rawValue)") // Viser valgt symbol
        }
        .background()   // eventuelt endre farge her (.red)
    }
}

#Preview {
    PickerView()
}
