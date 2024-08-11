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
    
    static let identifier = "BookCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateCellWith(_ book: Book) {
        bookTitleLabel.text = book.title
        
        if let bookCoverUrl = URL(string: book.cover) {
            bookImageView.setImageFromUrl(url: bookCoverUrl)
        }
        saveToFavouriteButton.layer.cornerRadius = 10
    }
    
    @IBAction func favouriteTapped(_ sender: Any) {
        print("@@@@ favourite tapped")
    }
}
