//
//  Reusable.swift
//  MoneyDiary
//
//  Created by KimRin on 2/16/25.
//

import Foundation
/// 자주 쓰는 코드들 모음집


//MARK: - CEll id generator
protocol CellReusable {
    static var id: String { get }
    
}

extension CellReusable {
    static var id: String {
        String(describing: self)
    }
}


//MARK: - HexColor generator

extension UIColor {
    
    convenience init(hexCode: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hexCode.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        
        assert(hexFormatted.count == 6, "Invalid hex code used.")
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
}
