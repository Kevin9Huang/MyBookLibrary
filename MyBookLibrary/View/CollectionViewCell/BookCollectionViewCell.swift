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
    
    func updateCellWith(_ book: inout Book) {
        bookId = book.id
        bookTitleLabel.text = book.title
        
        if let imageData = book.localImageData,
           let image = UIImage(data: imageData) {
            bookImageView.image = image
            print("found local data for title: \(book.title)")
        } else if let bookCoverUrl = URL(string: book.cover) {
            bookImageView.setImageFromUrl(url: bookCoverUrl)
            if let imageData = bookImageView.image?.pngData() {
                book.localImageData = imageData
            }
            
        }
        updateFavoriteStatus()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bookTitleLabel.text = ""
        bookImageView.image = nil
        setFavourite(false)
    }
    
    @IBAction func favouriteTapped(_ sender: Any) {
        guard let bookId = bookId else { return }
        favoritesManager.toggleFavorite(for: bookId)
        updateFavoriteStatus()
    }
    
    private func updateFavoriteStatus() {
        guard let bookId = bookId else { return }
        let isFavorite = favoritesManager.isFavorite(bookId: bookId)
        setFavourite(isFavorite)
    }
    
    private func setFavourite(_ isFavorite: Bool) {
        let favoriteText = isFavorite ? "Favorite" : "Set Favorite"
        let color = isFavorite ? UIColor.systemTeal : UIColor.clear
        saveToFavouriteButton.setTitle(favoriteText, for: .normal)
        saveToFavouriteButton.backgroundColor = color
    }
}
