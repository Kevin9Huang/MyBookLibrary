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
    @IBOutlet weak var favouriteTapAreaContainerView: UIView!
    @IBOutlet weak var heartImageView: UIImageView!
    
    static let identifier = "BookCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        favouriteTapAreaContainerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(favouriteTapped)))
    }
    
    func updateCellWith(_ book: Book) {
        bookTitleLabel.text = book.title
        bookImageView.setImageFromUrl(url: book.cover)
    }
    
    @objc
    private func favouriteTapped() {
        print("@@@@ favourite tapped")
    }
    
//    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
//        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
//    }
//    
//    private func downloadImage(from url: URL) {
//        print("@@@ Download Started")
//        getData(from: url) { data, response, error in
//            guard let data = data, error == nil else { return }
//            DispatchQueue.main.async() { [weak self] in
//                self?.bookImageView.image = UIImage(data: data)
//            }
//        }
//    }
}
