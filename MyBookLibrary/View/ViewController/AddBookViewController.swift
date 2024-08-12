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
}
