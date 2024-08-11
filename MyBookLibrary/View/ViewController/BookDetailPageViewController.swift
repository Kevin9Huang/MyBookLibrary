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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
