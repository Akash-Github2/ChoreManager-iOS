//
//  Util.swift
//  ChoreManager
//
//  Created by Akash on 12/19/20.
//

import SwiftUI

extension Date {
    func toCustomString() -> String {
        let dateFormatter = DateFormatter()
        let curLocale: Locale = Locale.current
        let formatString: NSString = DateFormatter.dateFormat(fromTemplate: "h:mm a", options: 0, locale: curLocale)! as NSString
        dateFormatter.dateFormat = formatString as String
        return dateFormatter.string(from: self)
    }
}
