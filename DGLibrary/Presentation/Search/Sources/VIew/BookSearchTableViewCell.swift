//
//  BookSearchTableViewCell.swift
//  DGLibrary
//
//  Created by 임영준 on 10/24/25.
//

import UIKit

final class BookSearchTableViewCell: UITableViewCell {
    static let reuseIdentifier = "BookSearchTableViewCell"
    
    private let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .secondarySystemBackground
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
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
    
    private let isbnLabel: UILabel = {
        let label = UILabel()
        return label
    }()
        
    private let priceLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let urlLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [titleLabel, subtitleLabel, isbnLabel, priceLabel, urlLabel]
        )
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()

    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [thumbnailImageView, verticalStackView])
        stackView.axis = .horizontal
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnailImageView.cancelImageLoad()
        thumbnailImageView.image = nil
        titleLabel.text = nil
        subtitleLabel.text = nil
        isbnLabel.text = nil
        priceLabel.text = nil
    }
    
    func configureCell(with book: BookSearchModel.DisplayedBook) {
        thumbnailImageView.setImage(with: book.imageURL)
        titleLabel.text = book.title
        subtitleLabel.text = book.subtitle
        isbnLabel.text = book.isbn13
        priceLabel.text = book.price
        urlLabel.text = book.detailURL?.absoluteString
    }
    
    private func setupUI () {
        self.contentView.addSubview(horizontalStackView)
        
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            horizontalStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            horizontalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            horizontalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            horizontalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            thumbnailImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            thumbnailImageView.widthAnchor.constraint(equalTo: thumbnailImageView.heightAnchor)
        ])
    }
}

@available(iOS 17.0, *)
#Preview {
    BookSearchTableViewCell()
}
