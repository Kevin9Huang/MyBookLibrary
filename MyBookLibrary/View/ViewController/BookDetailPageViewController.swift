//
//  BookDetailPageViewController.swift
//  MyBookLibrary
//
//  Created by Kevin Huang on 11/08/24.
//

import UIKit

class BookDetailPageViewController: UIViewController {
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var publicationDateLabel: UILabel!
    
    @IBOutlet weak var favouriteTapAreaContainerView: UIView!
    @IBOutlet weak var heartIcon: UIImageView!
    
    var book: Book?
    var onDismiss: (() -> Void)?
    private let favoritesManager = FavoritesManager()
    
    static func make() -> BookDetailPageViewController {
        let className = String(describing: self)
        return BookDetailPageViewController(nibName: className, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureHeartIcon()
        updateFavoriteStatus()
    }
    
    private func configureView() {
        guard let book else { return }
        
        titleLabel.text = book.title
        authorLabel.text = book.author
        descriptionLabel.text = book.bookDescription
        publicationDateLabel.text = book.publicationDate.getCustomFormattedString()
        configureBookCoverImage()
    }
    
    private func configureHeartIcon() {
        favouriteTapAreaContainerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(favouriteTapped)))
    }
    
    private func updateFavoriteStatus() {
        guard let book else { return }
        let isFavorite = favoritesManager.isFavorite(bookId: book.id)
        let image = isFavorite ? "heart.fill" : "heart"
        heartIcon.image = UIImage(systemName: image)
    }
    
    @objc
    private func favouriteTapped() {
        guard let book else { return }
        favoritesManager.toggleFavorite(for: book.id)
        updateFavoriteStatus()
    }
    
    private func configureBookCoverImage() {
        guard let book else { return }
        
        if let imageData = book.localImageData,
           let image = UIImage(data: imageData) {
            bookImageView.image = image

        }
        else if let url = URL(string: book.cover) {
            bookImageView.setImageFromUrl(url: url)
        }
    }
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag, completion: completion)
        
        guard let onDismiss else { return }
        onDismiss()
    }
}
