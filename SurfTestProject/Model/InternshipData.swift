//
//  InternshipData.swift
//  SurfTestProject
//
//  Created by Denis on 06.02.2023.
//

import Foundation

// MARK: - структура с состоянием выбора направления стажировки
struct InternshipSelection {
    let name: String
    var isSelected: Bool
}

// MARK: - перечисление с выбором данных
enum Section {
    case first
    case second
}

// MARK: - протокол для получения и обновления данных
protocol InternshipDataProtocol {
    func getData(section: Section) -> [InternshipSelection]
    func refreshData(newData: [InternshipSelection], section: Section)
}

// MARK: реализация протокола
final class InternshipData: InternshipDataProtocol {
    public static let shared = InternshipData()

    // первый список направлений
    private var internshipsFirst: [InternshipSelection] = [
        InternshipSelection(name: "IOS", isSelected: false),
        InternshipSelection(name: "Android", isSelected: false),
        InternshipSelection(name: "Design", isSelected: false),
        InternshipSelection(name: "Flutter", isSelected: false),
        InternshipSelection(name: "QA", isSelected: false),
        InternshipSelection(name: "PM", isSelected: false)
    ]

    // второй список направлений (для карусели в два ряда)
    private var internshipsSecond: [InternshipSelection] = [
        InternshipSelection(name: "IOS", isSelected: false),
        InternshipSelection(name: "Android", isSelected: false),
        InternshipSelection(name: "Design", isSelected: false),
        InternshipSelection(name: "Flutter", isSelected: false),
        InternshipSelection(name: "QA", isSelected: false),
        InternshipSelection(name: "PM", isSelected: false),
        InternshipSelection(name: "Java", isSelected: false),
        InternshipSelection(name: "Kotlin", isSelected: false),
        InternshipSelection(name: "Go", isSelected: false),
        InternshipSelection(name: "C#", isSelected: false),
        InternshipSelection(name: "Rust", isSelected: false)
    ]

    public func getData(section: Section) -> [InternshipSelection] {
        switch section {
        case .first:
            return internshipsFirst
        case .second:
            return internshipsSecond
        }
    }

    public func refreshData(newData: [InternshipSelection], section: Section) {
        switch section {
        case .first:
            self.internshipsFirst = newData
        case .second:
            self.internshipsSecond = newData
        }
    }
}
