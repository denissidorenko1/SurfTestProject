//
//  GroupView.swift
//  SurfTestProject
//
//  Created by Denis on 03.02.2023.
//

import UIKit

final class GroupView: UIView {
    // MARK: - объявление лейблов
    private let internshipTextLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Стажировка в Surf"
        let newFont = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .headline), size: 24)
        label.font = newFont
        label.textColor = UIColor(red: 0.192, green: 0.192, blue: 0.192, alpha: 1)
        return label
    }()

    private let descriptionTextLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Работай над реальными задачами под руководством опытного наставника и получи возможность стать частью команды мечты."
        let newFont = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .caption1), size: 14)

        label.textColor = .lightGray
        label.font = newFont
        label.numberOfLines = 3
        label.textColor = UIColor(red: 0.588, green: 0.584, blue: 0.608, alpha: 1)
        return label
    }()

    private let internshipConditionTextLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Получай стипендию, выстраивай удобный график, работай на современном железе."
        label.textColor = .lightGray
        label.font = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .caption1), size: 14)
        label.numberOfLines = 2
        label.textColor = UIColor(red: 0.588, green: 0.584, blue: 0.608, alpha: 1)
        return label
    }()

    private var firstCollectionView: UICollectionView!

    private lazy var firstDataSource = OneLineCollectionViewDataSource(view: firstCollectionView)

    // MARK: - инициализаторы
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    init(frame: CGRect, secondCarouselData: [InternshipSelection]) {
        super.init(frame: frame)
        setupLabelConstraints()
        setupFirstCollectionView()
        setupAppearance()
        setupSecondCarousel(data: secondCarouselData)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - методы настройки сабвью
    private func setupSecondCarousel(data: [InternshipSelection]) {
        let scrollView = TwoLineButtonRowView(frame: CGRect(x: 20, y: 260, width: self.bounds.width - 20,
            height: 100), data: InternshipData.shared.getData(section: .second))
        scrollView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        self.addSubview(scrollView)
    }

    private func setupAppearance() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 35
    }

    private func setupFirstCollectionView() {
        firstCollectionView = UICollectionView(frame: .zero, collectionViewLayout: setupFlowLayout())
        self.addSubview(firstCollectionView)

        firstCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            firstCollectionView.topAnchor.constraint(equalTo: self.descriptionTextLabel.bottomAnchor, constant: 12),
            firstCollectionView.bottomAnchor.constraint(equalTo: self.descriptionTextLabel.bottomAnchor, constant: 45 + 17),
            firstCollectionView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            firstCollectionView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0)
        ])

        firstCollectionView.dataSource = firstDataSource

        firstCollectionView.register(ButtonCollectionViewCell.self,
                                forCellWithReuseIdentifier: ButtonCollectionViewCell.identifier)

        firstCollectionView.showsHorizontalScrollIndicator = false
        firstCollectionView.backgroundColor = .white
    }

    private func setupFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumInteritemSpacing = 12
        return layout
    }

    private func setupLabelConstraints() {
        self.addSubview(internshipTextLabel)
        self.addSubview(descriptionTextLabel)
        self.addSubview(internshipConditionTextLabel)

        internshipTextLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextLabel.translatesAutoresizingMaskIntoConstraints = false
        internshipConditionTextLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            internshipTextLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            internshipTextLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            internshipTextLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 24),
            internshipTextLabel.heightAnchor.constraint(equalToConstant: 32),

            descriptionTextLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            descriptionTextLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            descriptionTextLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 68),

            internshipConditionTextLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            internshipConditionTextLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            internshipConditionTextLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 208)
        ])
    }
}
