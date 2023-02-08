//
//  FooterView.swift
//  SurfTestProject
//
//  Created by Denis on 03.02.2023.
//

import UIKit

// MARK: - объявление класса футера
final class FooterView: UIView {

    weak var delegate: HasAlert?
    // MARK: - создание текста и кнопки
    private lazy var wantToJoinText: UILabel = {
        let label = UILabel()
        label.text = "Хочешь к нам?"
        let font = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .caption1), size: 14)
        label.font = font
        label.textColor = UIColor(red: 0.588, green: 0.584, blue: 0.608, alpha: 1)
        return label
    }()

    // кнопка не имеет состояния, так как посчитал это нелогичным 
    private lazy var sendApplicationButton: UIButton = {
        let button = UIButton()
        button.setTitle("Отправить заявку", for: .normal)
        button.titleLabel?.font = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .caption2), size: 16)
        button.layer.cornerRadius = 30
        button.backgroundColor = UIColor(red: 0.192, green: 0.192, blue: 0.192, alpha: 1)
        button.addTarget(self, action: #selector(sendApplication), for: .touchUpInside)
        return button
    }()

    // MARK: - инициализация
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(wantToJoinText)
        self.addSubview(sendApplicationButton)
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupConstraints() {
        wantToJoinText.translatesAutoresizingMaskIntoConstraints = false
        sendApplicationButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            // горизонталь
            wantToJoinText.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            sendApplicationButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),

            // вертикаль
            wantToJoinText.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            sendApplicationButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),

            // задать высоту элементов
            wantToJoinText.heightAnchor.constraint(equalToConstant: 60),
            sendApplicationButton.heightAnchor.constraint(equalToConstant: 60),

            // задать ширину элементов
            sendApplicationButton.widthAnchor.constraint(equalToConstant: 219),
            wantToJoinText.widthAnchor.constraint(equalToConstant: 100)
        ])
    }

    // MARK: - метод obj-c
    @objc func sendApplication() {
        guard let alertableDelegate = delegate else { return }
        alertableDelegate.showAlert(alertTitle: "Поздравляем!", message: "Ваша заявка успешно отправлена!", closeText: "Закрыть")
    }
}
