//
//  DefaultFormatter.swift
//  network
//
//  Created by Guilherme Ramos on 04/04/20.
//  Copyright © 2020 Guilherme Ramos. All rights reserved.
//

import Foundation

extension DateFormatter {
    private static var `default`: DateFormatter {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale.current
        return formatter
    }

    static func string(from date: Date) -> String {
        return `default`.string(from: date)
    }
}
