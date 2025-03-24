//
//  UIHelper.swift
//  SignUpTemplate
//
//  Created by KimRin on 3/17/25.
//

import Foundation
import UIKit

class UIHelper {
    
    func socialSignInButton (image: String) -> UIButton {
        let button = UIButton()
        button.setImage(UIImage(named: image), for: .normal)
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        return button
    }
    
    func getScreenWidth() -> CGFloat {
        if let window = UIApplication.shared.windows.first {
            let safeAreaInsets = window.safeAreaInsets
            
            // Safe Area 값 출력
            print("📱 Safe Area 상단 여백: \(safeAreaInsets.top) px")
            print("📱 Safe Area 하단 여백: \(safeAreaInsets.bottom) px")
            print("📱 Safe Area 좌측 여백: \(safeAreaInsets.left) px")
            print("📱 Safe Area 우측 여백: \(safeAreaInsets.right) px")
            
            // Safe Area에 포함된 실제 화면 크기 (포인트 단위)
            let screenWidth = UIScreen.main.bounds.width
            let screenHeight = UIScreen.main.bounds.height
            
            let safeAreaWidth = screenWidth - (safeAreaInsets.left + safeAreaInsets.right)
            let safeAreaHeight = screenHeight - (safeAreaInsets.top + safeAreaInsets.bottom)

            // 출력
            print("📱 Safe Area 포함 화면 너비: \(safeAreaWidth) px")
            print("📱 Safe Area 포함 화면 높이: \(safeAreaHeight) px")
        }
        return UIScreen.main.bounds.width
        
    }
    
    
}
