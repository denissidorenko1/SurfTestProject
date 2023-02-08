//
//  TwoLineButtonRowView.swift
//  SurfTestProject
//
//  Created by Denis on 07.02.2023.
//

import UIKit

// MARK: - объявление класса
class TwoLineButtonRowView: UIScrollView {
    var data: [InternshipSelection]!

    // MARK: - инициализаторы
    init(frame: CGRect, data: [InternshipSelection]) {
        super.init(frame: frame)
        self.data = data
        let buttonWidthForRow = divideOnTwoRows(data: data)
        let buttonsView = buildButtonsView(buttonRowWidth: buttonWidthForRow)
        buttonsView.backgroundColor = .white
        self.contentSize = buttonsView.bounds.size
        self.addSubview(buttonsView)
        self.showsHorizontalScrollIndicator = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - методы класса
    // расчет ширины кнопки
    private func calculateButtonSizes(data: [InternshipSelection]) -> [CGFloat] {
        var buttonWidth: [CGFloat] = []
        for element in data {
            let width = element.name.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)]).width + 24 + 24
            buttonWidth.append(width)
        }
        return buttonWidth
    }

    // делим длины кнопок на два ряда, второй обязательно короче первого
    private func divideOnTwoRows(data: [InternshipSelection]) -> [[CGFloat]] {
        let buttonWidthArray = calculateButtonSizes(data: data)
        var buttonWidthRows: [[CGFloat]] = [[], []]
        var firstRowLength: CGFloat = 0
        var secondRowLength: CGFloat = 0
        let totalWidth: CGFloat = buttonWidthArray.reduce(0, +)
        for element in buttonWidthArray {
            if firstRowLength < totalWidth / 2 {
                buttonWidthRows[0].append(element)
                firstRowLength += element
            } else {
                buttonWidthRows[1].append(element)
                secondRowLength += element
            }
        }
        return buttonWidthRows
    }

    // используя вычисленные длины кнопок, размещаем их на вью и возвращаем вью с кнопками
    private func buildButtonsView(buttonRowWidth: [[CGFloat]]) -> UIView {
        let view = UIView()
        var leftFirstMargin: CGFloat = 0
        var maxWidth: CGFloat = 0
        var currentIndexOfData = 0
        for (rowIndex, row) in buttonRowWidth.enumerated() {
            for (elementIndex, element) in row.enumerated() {
                let button = BranchButton(text: self.data[currentIndexOfData].name)
                button.frame = CGRect(x: leftFirstMargin, y: CGFloat(rowIndex * 56), width: element, height: 44)
                leftFirstMargin += element + 12
                if maxWidth < leftFirstMargin {
                    maxWidth = leftFirstMargin
                }
                if elementIndex == buttonRowWidth[rowIndex].count - 1 {
                    leftFirstMargin = 0
                }
                currentIndexOfData += 1
                view.addSubview(button)
            }
        }
        view.frame = CGRect(x: 0, y: 0, width: maxWidth, height: CGFloat((buttonRowWidth.count) * 44 + (buttonRowWidth.count - 1) * 12))
        return view
    }
}
