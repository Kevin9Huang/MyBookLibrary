//
//  UIImageView+DownloadImage.swift
//  MyBookLibrary
//
//  Created by Kevin Huang on 11/08/24.
//

import UIKit

extension UIImageView {
    func setImageFromUrl(url: URL) {
        downloadImage(from: url)
    }
    
    private func downloadImage(from url: URL) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = UIImage(data: data)
            }
        }
    }
    
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
