//
//  BranchButton.swift
//  SurfTestProject
//
//  Created by Denis on 02.02.2023.
//

import UIKit

final class BranchButton: UIButton {
    // MARK: переменная состояния с property observer-ом
    // при изменении состояния меняем цвет фона и текста
    private var isActivated = false {
        didSet {
            switch isActivated {
            case false:
                    backgroundColor = inactiveColor
                    setTitleColor(.black, for: .normal)
            case true:
                    backgroundColor = activeColor
                    setTitleColor(.white, for: .normal)
    }}}

    // набор цветов для состояний
    private var activeColor = UIColor(red: 0.192, green: 0.192, blue: 0.192, alpha: 1)
    private var inactiveColor = UIColor(red: 0.953, green: 0.953, blue: 0.961, alpha: 1)

    // записываем лейбл кнопки, чтобы родитель мог соотнести кнопку с данными, и изменить их
    private var buttonLabelText = ""
    public weak var delegate: ReceivesDataFromButton?

    // MARK: - инициализаторы
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(text: String) {
        self.init(frame: .zero)
        configure(text: text)
    }

    // MARK: - методы
    // метод обновления состояния кнопки извне
    public func refreshButton(title: String, state: Bool) {
        // обновляет текст и состояние кнопки извне
        self.setTitle(title, for: .normal)
        self.buttonLabelText = title
        self.isActivated = state
    }

    // настройка внешнего вида ячейки
    private func configure(text: String) {
        self.backgroundColor = self.inactiveColor
        self.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        self.setTitleColor(.black, for: .normal)

        self.setTitle(text, for: .normal)
        self.titleLabel?.numberOfLines = 1
        self.buttonLabelText = text
        self.layer.cornerRadius = 10
        var configuration = UIButton.Configuration.borderedTinted()
        configuration.cornerStyle = .large
        configuration.contentInsets = .init(top: 12, leading: 24, bottom: 12, trailing: 24)
        // поправить
        configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont(name: "SF Pro Display", size: 14)
            return outgoing
        }
        self.configuration = configuration
        self.sizeToFit()
        self.addTarget(self, action: #selector(toggleState), for: .touchUpInside)
    }

    @objc private func toggleState() {
        isActivated = isActivated ? false : true
        guard let delegate = self.delegate else { return }
        delegate.fetchDataFromButton(text: self.buttonLabelText, isTurnedOn: isActivated)
    }
}
