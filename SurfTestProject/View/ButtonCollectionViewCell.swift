//
//  ButtonCollectionViewCell.swift
//  SurfTestProject
//
//  Created by Denis on 04.02.2023.
//

import UIKit

// MARK: - объявление класса с ячейкой
final class ButtonCollectionViewCell: UICollectionViewCell {

    private var button: BranchButton?
    // пришлось прокинуть ссылку от кнопки на датасорс через ячейку
    weak var delegate: ReceivesDataFromButton?

    static let identifier = "ButtonCollectionViewCell"

    // MARK: методы для работы с кнопкой
    private func setup() {
        guard let button = button else {
            return
        }
        button.delegate = self.delegate
        self.contentView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            button.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            button.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            button.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0)
        ])
    }

    public func setButton(text: String, state: Bool) {
        // после инициализации или обновления данных нужно подстроить ячейку под новые размеры
        defer {
            setup()
        }

        // если кнопка не инициализирована, инициализируем ее
        guard let button = button else {
            button = BranchButton(text: text)
            return
        }
        // если кнопка инициализирована, подставим в нее актуальные данные
        button.refreshButton(title: text, state: state)
    }
}
