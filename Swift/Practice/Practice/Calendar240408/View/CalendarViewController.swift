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

    private var dataSource: RxCollectionViewSectionedReloadDataSource<CalendarSection>!

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
        DispatchQueue.main.async {
            let indexPath = IndexPath(item: 0, section: 1) // 현재 달 기준으로 가운데 이동
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
        }
    }

    private func setupUI() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        collectionView.isPagingEnabled = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.alwaysBounceHorizontal = true
        collectionView.alwaysBounceVertical = false
        collectionView.bounces = false
        collectionView.decelerationRate = .fast
        collectionView.isScrollEnabled = true

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 500)
        ])

        collectionView.register(CalendarCell.self, forCellWithReuseIdentifier: "CalendarCell")
        collectionView.backgroundColor = .white
    }

    private func bindViewModel() {
        let input = CalVM.Input(currentMonth: currentMonthRelay.asObservable())
        let output = viewModel.transform(input: input)

        self.dataSource = RxCollectionViewSectionedReloadDataSource<CalendarSection> (
            configureCell: { _, collectionView, indexPath, item in
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: "CalendarCell",
                    for: indexPath
                ) as! CalendarCell
                cell.bind(item)
                return cell
            }
        )

        output.sections
            .do(onNext: { sections in
                print("🔍 섹션 수: \(sections.count)")
                sections.forEach { print("📆 섹션: \($0.model), 아이템 수: \($0.items.count)") }
            })
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}

extension CalendarViewController {
    static func createLayout() -> UICollectionViewCompositionalLayout {
        let screenWidth = UIScreen.main.bounds.width

        let itemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(screenWidth / 7),
            heightDimension: .absolute(500 / 6)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let horizontalGroupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(screenWidth),
            heightDimension: .absolute(500 / 6)
        )
        let horizontalGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: horizontalGroupSize,
            repeatingSubitem: item,
            count: 7
        )

        let verticalGroupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(screenWidth),
            heightDimension: .absolute(500)
        )
        let verticalGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: verticalGroupSize,
            subitems: Array(repeating: horizontalGroup, count: 6)
        )

        let section = NSCollectionLayoutSection(group: verticalGroup)
        section.orthogonalScrollingBehavior = .groupPagingCentered

        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .horizontal

        return UICollectionViewCompositionalLayout(section: section, configuration: config)
    }
}

extension CalendarViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        let width = scrollView.bounds.width
        let pageIndex = Int(round(offsetX / width))

        guard let sectionModel = try? dataSource.sectionModels[safe: pageIndex] else { return }

        let sectionMonthString = sectionModel.model
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM"
        if let date = formatter.date(from: sectionMonthString) {
            currentMonthRelay.accept(date)
        }
    }
}

extension Array {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
