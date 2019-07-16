//
//  FCGalleryImageDetailVC.swift
//  Footy-Crazy
//
//  Created by Tintash on 11/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit

class FCGalleryDetailVC: UIViewController {

    @IBOutlet weak var img: UIImageView!
    var viewModel: FCGalleryDetailVM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
    }
    
    func setupVC(){
        if let urlString = viewModel?.imageUrl{
            if let url = URL(string: urlString){
                img.loadImage(from: url, completion: nil)
            }
        }
    }
    
    @IBAction func share(_ sender: Any?){
        if let downloadedImage = img.image{
            let shareableImg = [downloadedImage]
            FCUtilities.shareContent(self, shareableImg)
        }
    }
}
