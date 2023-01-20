//
//  ImageLoader.swift
//  Veterinary Clinic
//
//  Created by Yeshvekar.Suresh on 16/01/23.
//

import UIKit

class ImageLoader {

    var cache = NSCache<AnyObject, AnyObject>()

    class var sharedInstance: ImageLoader {
        struct Static {
            static let instance: ImageLoader = ImageLoader()
        }
        return Static.instance
    }

    func imageForUrl(urlString: String, completionHandler:@escaping (_ image: UIImage?, _ url: String) -> ()) {
        let data: NSData? = self.cache.object(forKey: urlString as AnyObject) as? NSData

        if let imageData = data {
            let image = UIImage(data: imageData as Data)
            completionHandler(image, urlString)
            return
        }

        if let url = URL(string: urlString) {
            let downloadTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    if let imageData = data {
                        let image = UIImage(data: imageData)
                        self.cache.setObject(imageData as AnyObject, forKey: urlString as AnyObject)
                        completionHandler(image, urlString)
                    }
                } else {
                    completionHandler(nil, urlString)
                }
            }
            downloadTask.resume()
        } else {
            completionHandler(nil, urlString)
        }
    }
}
