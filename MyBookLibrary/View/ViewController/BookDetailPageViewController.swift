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
    
    static func make() -> BookDetailPageViewController {
        let className = String(describing: self)
        return BookDetailPageViewController(nibName: className, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureHeartIcon()
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
    
    var selected = false
    @objc
    private func favouriteTapped() {
        selected.toggle()
        if selected {
            heartIcon.image = UIImage(systemName: "heart.fill")
        } else {
            heartIcon.image = UIImage(systemName: "heart")
        }
    }
    
    private func configureBookCoverImage() {
        guard let book, let url = URL(string: book.cover) else { return }
        
        bookImageView.setImageFromUrl(url: url)
    }
}
