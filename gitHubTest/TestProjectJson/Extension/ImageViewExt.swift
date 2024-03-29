//
//  ImageViewExt.swift
//  TestProjectJson
//
//  Created by Вадим Пустовойтов on 30/07/2019.
//  Copyright © 2019 Вадим Пустовойтов. All rights reserved.
//

import UIKit

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit){
    contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
        guard
            let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
            let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
            let data = data, error == nil,
            let image = UIImage(data: data) else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
        }.resume()
        
    }
    
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
                guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
