//
//  BookViewController.swift
//  MyBookLibrary
//
//  Created by Kevin Huang on 04/08/24.
//

import UIKit

final class BookViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var addBookButton: UIButton!
    
    private var books: [Book] = []
    private let viewModel = BookViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupViewModel()
        setupAddBookButton()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 180, height: 320)
        collectionView.collectionViewLayout = layout
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let nib = UINib(nibName: BookCollectionViewCell.identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: BookCollectionViewCell.identifier)
    }
    private func setupAddBookButton() {
        addBookButton.layer.cornerRadius = addBookButton.frame.width / 2
        addBookButton.setTitle("", for: .normal)
    }
    
    private func setupViewModel() {
        viewModel.onBooksUpdated = { [weak self] in
            guard let self else { return }
            self.books = self.viewModel.books
            self.collectionView.reloadData()
        }
        viewModel.loadBooks()
    }
    
    @IBAction func addBookTapped(_ sender: Any) {
        let addBookVC = AddBookViewController.make()
        addBookVC.onDismiss = { [weak self] in
            self?.viewModel.loadBooks()
        }
        present(addBookVC, animated: true)
    }
}

extension BookViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.identifier, for: indexPath) as? BookCollectionViewCell else {
            return UICollectionViewCell()
        }
        var book = books[indexPath.item]
        cell.updateCellWith(&book)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let book = books[indexPath.item]
        let detailVC = BookDetailPageViewController.make()
        detailVC.book = book
        detailVC.onDismiss = {
            collectionView.reloadData()
        }
        present(detailVC, animated: true)
    }
}

