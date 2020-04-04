//
//  ContentView.swift
//  network
//
//  Created by Guilherme Ramos on 03/04/20.
//  Copyright © 2020 Guilherme Ramos. All rights reserved.
//

import SwiftUI

extension Date {
    func date(byAddingYears years: Int) -> Date {
        return date(byAdding: .year, value: years)
    }

    func date(byAddingMonths months: Int) -> Date {
        return date(byAdding: .month, value: months)
    }

    func date(byAddingDays days: Int) -> Date {
        return date(byAdding: .day, value: days)
    }

    func date(byAdding component: Calendar.Component, value: Int) -> Date {
        let date = Calendar.current.date(byAdding: component, value: value, to: self)
        return date ?? Date()
    }
}


struct ContentView: View {
    @State private var history = SymbolHistory()


    var body: some View {
        VStack {
            Text("Hello, World!")
            List(history.list(), id: \.self) { value in
                Text(value)
            }
            .onAppear(perform: self.loadData)
        }
    }



    func loadData() {
        let endpoint: SymbolEndpoint = .get7DaysHistory(base:"USD", to: "BRL")
        NetworkClient.shared.request(endpoint, for: SymbolHistory.self) { (result) in
            switch result {
            case let .success(data):
                self.history = data
            case let .failure(error):
                print(error)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
