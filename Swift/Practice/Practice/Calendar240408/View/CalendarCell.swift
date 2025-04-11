//
//  CalendarCell.swift
//  Practice
//
//  Created by KimRin on 4/8/25.
//

import UIKit

class CalendarCell: UICollectionViewCell {
    
    private let dayLabel = UILabel()
    private let budgetLabel = UILabel()
    private let amountLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        let stackView = UIStackView(arrangedSubviews: [dayLabel, budgetLabel, amountLabel])
        stackView.axis = .vertical
        stackView.spacing = 2
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        contentView.addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])

        dayLabel.font = .systemFont(ofSize: 14, weight: .bold)
        budgetLabel.font = .systemFont(ofSize: 12)
        amountLabel.font = .systemFont(ofSize: 12)
    }

    func bind(_ item: CalendarItem) {
        let day = Calendar.current.component(.day, from: item.date)
        dayLabel.text = "\(day)"
        budgetLabel.text = "예산: \(item.dayBudget)"
        amountLabel.text = "합계: \(item.totalAmount)"

        // 이번 달 아니면 흐리게 표시
        contentView.alpha = item.isThisMonth ? 1.0 : 0.3

        // 배경색 설정
        contentView.backgroundColor = item.backgroundColor

        // 요일 별 색상 (옵션)
        switch item.dayType {
        case .Sunday:
            dayLabel.textColor = .red
        case .Saturday:
            dayLabel.textColor = .blue
        default:
            dayLabel.textColor = .black
        }
    }
}
