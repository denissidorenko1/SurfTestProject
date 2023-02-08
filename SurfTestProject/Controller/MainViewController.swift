//
//  ViewController.swift
//  SurfTestProject
//
//  Created by Denis on 02.02.2023.
//

import UIKit

// MARK: - протокол с методом вызова алерта
protocol HasAlert: AnyObject {
    func showAlert(alertTitle: String, message: String, closeText: String)
}

final class MainViewController: UIViewController {

    // MARK: - перегрузки методов
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        setupImageView()
        setupScrollableContentView()
        setupFooter()
    }

    // поддерживаем только портретную ориентацию
    override public var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    // MARK: - настройка вьюшек
    private func setupScrollView() -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.frame = CGRect(x: 0, y: 0, width: view.bounds.width,
                                  height: view.bounds.height)
        scrollView.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height + 100)
        scrollView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        return scrollView
    }

    private func setupScrollableContentView() {
        let modalView = GroupView(frame: CGRect(x: 0, y: view.bounds.height * 0.30,
                width: view.bounds.width, height: view.bounds.height + 200),
                secondCarouselData: InternshipData.shared.getData(section: .second))
        let scrollView = setupScrollView()
        scrollView.addSubview(modalView)
        view.addSubview(scrollView)
    }

    private func setupFooter() {
        let footer = FooterView(frame: CGRect(x: 0, y: view.bounds.height - 60 - 58, width: view.bounds.width, height: 60))
        footer.delegate = self
        view.addSubview(footer)
    }

    private func setupImageView() {
        let backgroundImage = UIImageView(image: UIImage(named: "backgroundImage"))
        view.addSubview(backgroundImage)
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            backgroundImage.leftAnchor.constraint(equalTo: view.leftAnchor),
            backgroundImage.rightAnchor.constraint(equalTo: view.rightAnchor),
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        backgroundImage.clipsToBounds = true
        backgroundImage.contentMode = .scaleAspectFill
        NSLayoutConstraint.activate(constraints)
    }
}

// MARK: - расширение с имплементацией протокола вызова алерта
extension MainViewController: HasAlert {
    public func showAlert(alertTitle: String, message: String, closeText: String) {
        let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: closeText, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
