//
//  AddBookViewController.swift
//  MyBookLibrary
//
//  Created by Kevin Huang on 12/08/24.
//

import Foundation
import UIKit

final class AddBookViewController: UIViewController {
    @IBOutlet weak var uploadBookButton: UIButton!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var publicationTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    
    private let bookSaver: BookSaverProtocol = BookSaverManager()
    
    static func make() -> AddBookViewController {
        let className = String(describing: self)
        return AddBookViewController(nibName: className, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        saveButton.layer.cornerRadius = 15
    }
    
    private func setupView() {
        setBorderColorTo(titleTextField)
        setBorderColorTo(authorTextField)
        setBorderColorTo(descriptionTextField)
        setBorderColorTo(publicationTextField)
    }
    
    private func setBorderColorTo(_ view: UIView) {
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
    }
    @IBAction func onSaveTapped(_ sender: Any) {
        guard let title = titleTextField.text,
              let author = authorTextField.text,
              let bookDescription = descriptionTextField.text,
              let publicationDate = publicationTextField.text,
              !title.isEmpty,
              !author.isEmpty,
              !bookDescription.isEmpty,
              !publicationDate.isEmpty
        else {
            self.showAlert(
                title: "Warning",
                message: "All fields must be filled"
            )
            return
        }
        //TODO: change id to UUID
        //TODO: set publication date with date picker
        let book = Book(id: Int.random(in: 1...1000), title: title, author: author, bookDescription: bookDescription, cover: "", publicationDate: Date())
        bookSaver.saveBook(book) {
            showAlert(title: "Information", message: "Book saved successfully")
        }
    }
    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
