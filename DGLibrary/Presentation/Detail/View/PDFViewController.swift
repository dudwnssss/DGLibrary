//
//  PDFViewController.swift
//  DGLibrary
//
//  Created by 임영준 on 10/27/25.
//

import PDFKit

final class PDFViewController: UIViewController {
    private let pdfURL: URL
    
    let pdfView: PDFView = {
        let pdfView = PDFView()
        pdfView.backgroundColor = .cyan
        pdfView.autoScales = true
        pdfView.displayMode = .singlePage
        pdfView.displayDirection = .horizontal
        return pdfView
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
        loadPDF()
    }
    
    private func loadPDF() {
        Task.detached { [weak self] in
            guard let self else { return }
            if let document = PDFDocument(url: pdfURL) {
                await MainActor.run { [weak self] in
                    guard let self else { return }
                    pdfView.document = document
                }
            } else {
                await MainActor.run { [weak self] in
                    self?.presentExternalButton()
                }
            }
        }
    }
    
    @objc private func openExternal() {
        UIApplication.shared.open(pdfURL)
    }
    
    private func presentExternalButton() {
        var config = UIButton.Configuration.plain()
        config.title = "외부 브라우저에서 열기"
        let button = UIButton(configuration: config)
        pdfView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        button.addTarget(self, action: #selector(openExternal), for: .touchUpInside)
    }
}
