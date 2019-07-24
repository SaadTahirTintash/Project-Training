//
//  FCNewsLinkTableViewCell.swift
//  Footy-Crazy
//
//  Created by Tintash on 01/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit
import SwiftLinkPreview
class FCNewsLinkTableViewCell: UITableViewCell, FCImageDownloader , FCNewsLinkDownloader{
    @IBOutlet weak var activityIndicator    : UIActivityIndicatorView!
    @IBOutlet weak var titleLbl             : UILabel!
    @IBOutlet weak var newsImg              : UIImageView!
    @IBOutlet weak var stackView            : UIStackView!
    var shareBtnPressed                     : ((FCNewsFeedDetailVM?)->Void)?
    var viewModel                           : FCNewsFeedDetailVM?
}

extension FCNewsLinkTableViewCell{
    override func prepareForReuse() {
        newsImg.image = nil
    }
    func configure() {
        
        titleLbl.text   = viewModel?.title
        
        activityIndicator.startAnimating()
        loadLink(from: viewModel?.url, success: { [weak self] (response) in
            guard response.url?.absoluteString == self?.viewModel?.url else {
                print("Wrong NewsLink Cell!")
                return
            }
            self?.linkSuccess(response)
        }, failure: failure)
    }
    func linkSuccess(_ response: Response){
        titleLbl.text           = response.title
        if let imgUrlString     = response.image{
            loadImage(from: imgUrlString, success: { [weak self] (downloadedImg, urlString) in
                guard imgUrlString == urlString else{
                    print("Wrong NewsLink Image Cell!")
                    return
                }
                DispatchQueue.main.async {
                    self?.imgSuccess(downloadedImg)
                }
            }) { [weak self](errorMsg) in
                DispatchQueue.main.async {
                    self?.failure(errorMsg)
                }
            }
        } else {
            failure("No Image in response!")
        }
    }
    func imgSuccess(_ downloadedImg: UIImage){
        activityIndicator.stopAnimating()
        newsImg.image = downloadedImg
    }
    func failure(_ errorMsg: String){
        activityIndicator.stopAnimating()
        newsImg.image = FCConstants.EMPTY_IMAGE
        print(errorMsg)
    }
    @IBAction func share(_ sender: Any) {
        shareBtnPressed?(viewModel)
    }
}


