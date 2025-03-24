//
//  signInView.swift
//  SignUpTemplate
//
//  Created by KimRin on 3/17/25.
//

import Foundation
import UIKit

import SnapKit

class SignInView: UIView {
    
    let logoImage: UIImageView = UIImageView()
    
    let kakaoButton: UIButton = UIHelper().socialSignInButton(image: "kakao")
    let naverButton: UIButton = UIHelper().socialSignInButton(image: "naver")
    let appleButton: UIButton = UIHelper().socialSignInButton(image: "apple")
    let googleButton: UIButton = UIHelper().socialSignInButton(image: "google")
    lazy var loginStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [appleButton, googleButton, kakaoButton, naverButton])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
        
    }()
    
    let emailButton: UIButton = UIButton()
    let lookAroundButton: UIButton = UIButton()
    
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
        self.backgroundColor = .white
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        [
            appleButton,
            googleButton,
            kakaoButton,
            naverButton
            
        ].forEach { UIButton in
            self.addSubview(UIButton)
        }
        
        appleButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(60)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        
    }
    
}
