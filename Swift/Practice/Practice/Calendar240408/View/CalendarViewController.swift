//
//  CalVC.swift
//  Practice
//
//  Created by KimRin on 4/8/25.
//

import UIKit

import RxSwift
import RxCocoa
import RxDataSources


class CalendarViewController: UIViewController {
    
    private var dataSource: RxCollectionViewSectionedReloadDataSource<CalendarSectionModel>!

    private let disposeBag = DisposeBag()
    private let viewModel = CalVM()
    private let collectionView: UICollectionView = {
        let layout = CalendarViewController.createLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.backgroundColor = .white
        return collectionView
    }()
    private let currentMonthRelay = BehaviorRelay<Date>(value: Date())

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        
    }

    private func setupUI() {
        


        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.95),
            collectionView.heightAnchor.constraint(equalToConstant: 500)
        ])

        collectionView.register(CalendarCell.self, forCellWithReuseIdentifier: "CalendarCell")
        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = false // ❗️groupPaging 사용 중엔 false 유지
    }
    
    
    private func bindViewModel() {
        let input = CalVM.Input(currentMonth: currentMonthRelay.asObservable())
        let output = viewModel.transform(input: input)

        self.dataSource = RxCollectionViewSectionedReloadDataSource<CalendarSectionModel> (
            configureCell: { _, collectionView, indexPath, item in
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: "CalendarCell",
                    for: indexPath
                ) as! CalendarCell
                cell.bind(item) // ⬅️ CalendarItem 데이터를 셀에 넘김
                return cell
            }
        )

        output.sections
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }

}


extension CalendarViewController {
    //왜 전역으로?
    static func createLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0 / 7.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let horizontalGroupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0 / 6.0) // 6줄 구성
        )
        let horizontalGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: horizontalGroupSize,
            repeatingSubitem: item,
            count: 7
        )

        let verticalGroupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let verticalGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: verticalGroupSize,
            subitems: Array(repeating: horizontalGroup, count: 6)
        )
        
        let section = NSCollectionLayoutSection(group: verticalGroup)
        section.orthogonalScrollingBehavior = .groupPaging
        return UICollectionViewCompositionalLayout(section: section)
    }
}


extension CalendarViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
        let center = CGPoint(x: visibleRect.midX, y: visibleRect.midY)

        guard let indexPath = collectionView.indexPathForItem(at: center),
              let item = try? dataSource.model(at: indexPath) as? CalendarItem else {
            return
        }

        let newMonth = DateManager.shared.getFirstDayInMonth(date: item.date)
        currentMonthRelay.accept(newMonth)
    }
    
}
