//
//  ImageService.swift
//  FlickrClient
//
//  Created by Oleksandr Hozhulovskyi on 11.05.2020.
//  Copyright © 2020 Oleksandr Hozhulovskyi. All rights reserved.
//

import UIKit

class ImageService {
    func imageFromURL(_ url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            let result: Result<UIImage, Error>
            
            if let error = error {
                result = .failure(error)
            } else if let data = data,
                let image = UIImage(data: data) {
                result = .success(image)
            } else {
                result = .failure(ImageServiceError.wrongData)
            }
            
            DispatchQueue.main.async {
                completion(result)
            }  
        }
        .resume()
    }
}

enum ImageServiceError: String, Error {
    case wrongData
}
