//
//  BookCollectionViewCell.swift
//  MyBookLibrary
//
//  Created by Kevin Huang on 11/08/24.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var saveToFavouriteButton: UIButton!
    
    private var bookId: Int?
    static let identifier = "BookCollectionViewCell"
    private let favoritesManager = FavoritesManager()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        saveToFavouriteButton.layer.cornerRadius = 10
        saveToFavouriteButton.layer.borderColor = UIColor.black.cgColor
        saveToFavouriteButton.layer.borderWidth = 1
    }
    
    func updateCellWith(_ book: Book) {
        bookId = book.id
        bookTitleLabel.text = book.title
        
        if let imageData = book.localImageData,
           let image = UIImage(data: imageData) {
            bookImageView.image = image
        } else if let bookCoverUrl = URL(string: book.cover) {
            bookImageView.setImageFromUrl(url: bookCoverUrl)
        }
        updateFavoriteStatus()
    }
    
    @IBAction func favouriteTapped(_ sender: Any) {
        guard let bookId = bookId else { return }
        favoritesManager.toggleFavorite(for: bookId)
        updateFavoriteStatus()
    }
    
    private func updateFavoriteStatus() {
        guard let bookId = bookId else { return }
        let isFavorite = favoritesManager.isFavorite(bookId: bookId)
        let favoriteText = isFavorite ? "Favorite" : "Set Favorite"
        let color = isFavorite ? UIColor.systemTeal : UIColor.clear
        saveToFavouriteButton.setTitle(favoriteText, for: .normal)
        saveToFavouriteButton.backgroundColor = color
    }
}
