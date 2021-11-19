//
//  ContentView.swift
//  WeSplit
//
//  Created by Victor Colen on 17/11/21.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 1
    @State private var tipPercentage = 10
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [0, 5, 10, 15, 20]
    
    var totalAmount: Double {
        let selectedTip = Double(tipPercentage)
        let tipValue = checkAmount / 100 * selectedTip
        
        return checkAmount + tipValue
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 1)
        
        return totalAmount / peopleCount
    }
    
    var localCurrency = {
        Locale.current.currencyCode ?? "USD"
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: localCurrency()))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                } header: {
                    Text("Check amount")
                }
                
                Section {
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(1..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<101) {
                            Text($0, format: .percent)
                        }
                    }
                }
                
                Section {
                    Text(totalAmount, format: .currency(code: localCurrency()))
                } header: {
                    Text("Total")
                }
                
                Section {
                    Text(totalPerPerson, format: .currency(code: localCurrency()))
                } header: {
                    Text("Amount per person")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
