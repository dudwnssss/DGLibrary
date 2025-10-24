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
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel, isbnLabel, priceLabel])
        stackView.axis = .vertical
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
        thumbnailImageView.image = nil
        titleLabel.text = nil
        subtitleLabel.text = nil
        isbnLabel.text = nil
        priceLabel.text = nil
    }
    
    func configureCell(with book: BookSearchModel.Fetch.ViewModel.DisplayedBook) {
        titleLabel.text = book.title
        subtitleLabel.text = book.subTitle
        isbnLabel.text = book.isbn13
        priceLabel.text = book.price
    }
    
    private func setupUI () {
        self.contentView.addSubview(horizontalStackView)
        
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            horizontalStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            horizontalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            horizontalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            horizontalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
}

@available(iOS 17.0, *)
#Preview {
    BookSearchTableViewCell()
}
