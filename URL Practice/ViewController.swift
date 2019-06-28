//
//  ViewController.swift
//  URL Practice
//
//  Created by Denis Bystruev on 28/06/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var urlTextField: UITextField!
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://apple.com")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            guard let string = String(data: data, encoding: .utf8) else { return }
            print(#line, #function, data)
            print(string)
        }
        
        task.resume()
    }
    
    @IBAction func getPictureButtonPressed(_ sender: UIButton) {
        guard let urlString = urlTextField.text else { return }
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                if let error = error {
                    print(#line, #function, error.localizedDescription)
                }
                return
            }
            guard let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
        
        task.resume()
    }
    
}

