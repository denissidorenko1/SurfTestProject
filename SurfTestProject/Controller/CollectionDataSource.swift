//
//  CollectionDataSource.swift
//  SurfTestProject
//
//  Created by Denis on 06.02.2023.
//

import UIKit

// MARK: - протокол получения данных о нажатии из кнопки
protocol ReceivesDataFromButton: AnyObject {
    func fetchDataFromButton(text: String, isTurnedOn: Bool)
}

// MARK: - источник данных для первой карусели
final class OneLineCollectionViewDataSource: NSObject, UICollectionViewDataSource {

    // загружаем текст для кнопок и их начальное состояние
    private var internshipData = InternshipData.shared.getData(section: .first)
    private weak var collectionView: UICollectionView?

    init(view: UICollectionView) {
        self.collectionView = view
        super.init()
    }

    // MARK: - реализация протокола UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return internshipData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.collectionView?.dequeueReusableCell(withReuseIdentifier: ButtonCollectionViewCell.identifier,
                                  for: indexPath) as? ButtonCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.delegate = self
        cell.setButton(text: internshipData[indexPath.item].name,
                       state: internshipData[indexPath.item].isSelected)
        return cell
    }
}

// MARK: - расширение, реализующее протокол получения данных о нажатии от кнопки
// также содержит методы, реализующие сдвиг ячейки при активации кнопки
extension OneLineCollectionViewDataSource: ReceivesDataFromButton {
    // метод, вызываемый кнопкой при нажатии
    public func fetchDataFromButton(text: String, isTurnedOn: Bool) {
        internshipData[internshipData.firstIndex { $0.name == text }!].isSelected = isTurnedOn
        // если кнопка активируется, переместим ее на первую позицию в collectionView
        if isTurnedOn {
            moveToFirstPosition(text: text)
        }
        // обновим данные о порядке/состоянии кнопок, чтобы при переиспользовании записать актуальные данные
        InternshipData.shared.refreshData(newData: internshipData, section: .first)
    }

    private func rearrangeData(index: Int, data: inout [InternshipSelection]) {
        // при перемещении выбранной ячейки нужно поменять данные, затронутые при сдвиге
        // выбранная ячейка сдвигается, соответственно требуется сдвинуть все ячейки на 1 позицию, начиная с выбранной
        for swapIndex in stride(from: index, through: 1, by: -1) {
            // выбранная ячейка "всплывает"
            data.swapAt(swapIndex, swapIndex - 1)
            // при перемещении ячейки изменяются позиции ячеек, расположенных левее: пересчитаем размеры
            let cell = collectionView?.cellForItem(at: IndexPath(row: swapIndex, section: 0)) as? ButtonCollectionViewCell
            cell?.setButton(text: data[swapIndex].name, state: data[swapIndex].isSelected)
        }
    }

    // метод для сдвига ячейки с кнопкой в collectionView
    private func moveToFirstPosition(text: String) {
        let index = internshipData.firstIndex { $0.name == text }!
        collectionView?.moveItem(at: IndexPath(row: index, section: 0), to: IndexPath(row: 0, section: 0))
        rearrangeData(index: index, data: &internshipData)
    }
}
