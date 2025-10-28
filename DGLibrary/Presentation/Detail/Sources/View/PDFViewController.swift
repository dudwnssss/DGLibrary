//
//  PDFViewController.swift
//  DGLibrary
//
//  Created by 임영준 on 10/27/25.
//

import PDFKit

final class PDFViewController: UIViewController {
    private let pdfURL: URL
    
    private let pdfView: PDFView = {
        let pdfView = PDFView()
        pdfView.autoScales = true
        pdfView.displayMode = .singlePageContinuous
        pdfView.displayDirection = .vertical
        return pdfView
    }()
    
    private let indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    init(pdfURL: URL) {
        self.pdfURL = pdfURL
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = pdfView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadPDF()
    }
    
    private func loadPDF() {
        indicator.startAnimating()
        Task.detached { [weak self] in
            guard let self else { return }
            if let document = PDFDocument(url: pdfURL) {
                await MainActor.run { [weak self] in
                    guard let self else { return }
                    indicator.stopAnimating()
                    pdfView.document = document
                }
            } else {
                await MainActor.run { [weak self] in
                    guard let self else { return }
                    indicator.stopAnimating()
                    presentAlert()
                }
            }
        }
    }
    
    private func setupUI() {
        view.addSubview(indicator)
        
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc private func openExternal() {
        UIApplication.shared.open(pdfURL)
    }
    
    private func presentAlert() {
        let alert = UIAlertController(
            title: "Unable to Preview",
            message: "This file cannot be previewed in the app. Would you like to open it in your browser?",
            preferredStyle: .alert
        )
        
        let cancelAction = UIAlertAction(
            title: "Cancel",
            style: .cancel
        ) { [weak self] _ in
            self?.dismiss(animated: true)
        }
        
        let openAction = UIAlertAction(
            title: "Open in Browser",
            style: .default
        ) { [weak self] _ in
            guard let self = self else { return }
            UIApplication.shared.open(pdfURL)
            self.dismiss(animated: true)
        }
        
        alert.addAction(cancelAction)
        alert.addAction(openAction)
        
        present(alert, animated: true)
    }
}
