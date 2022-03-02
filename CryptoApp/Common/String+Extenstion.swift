//
//  String+Extenstion.swift
//  CryptoApp
//
//  Created by Brajesh Kumar on 20/02/22.
//

import UIKit

extension String {
    func parse(precision: Int = 2) -> String {
        let number = NSNumber(value: Double(self) ?? 0.0)
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = precision
        formatter.maximumFractionDigits = precision
        return formatter.string(from: number) ?? ""
    }
    
    func attributedString(textColor: UIColor) -> NSAttributedString {
       return NSAttributedString(string: self, attributes: [NSAttributedString.Key.foregroundColor : textColor])
    }
    
}
