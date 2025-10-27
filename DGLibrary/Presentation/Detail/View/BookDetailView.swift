//
//  BookDetailView.swift
//  DGLibrary
//
//  Created by 임영준 on 10/26/25.
//

import UIKit

final class BookDetailView: UIView {
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemPink
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let authorsLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let publisherLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let isbn10Label: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let isbn13Label: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let pagesLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let yearLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let descLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            subtitleLabel,
            authorsLabel,
            publisherLabel,
            isbn10Label,
            isbn13Label,
            pagesLabel,
            yearLabel,
            ratingLabel,
            descLabel,
            priceLabel
        ])
        stackView.axis = .vertical
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with book: BookDetailModel.DisplayedBook) {
        titleLabel.text = book.title
        subtitleLabel.text = book.subtitle
        authorsLabel.text = book.authors
        publisherLabel.text = book.publisher
        isbn10Label.text = book.isbn10
        isbn13Label.text = book.isbn13
        pagesLabel.text = book.pages
        yearLabel.text = book.year
        ratingLabel.text = book.rating
        descLabel.text = book.desc
    }
    
    private func setupUI() {
        self.backgroundColor = .white
        
        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        contentView.addSubview(thumbnailImageView)
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            thumbnailImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            thumbnailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            thumbnailImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            thumbnailImageView.heightAnchor.constraint(equalTo: thumbnailImageView.widthAnchor)
        ])
        
        contentView.addSubview(verticalStackView)
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor),
            verticalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            verticalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            verticalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
