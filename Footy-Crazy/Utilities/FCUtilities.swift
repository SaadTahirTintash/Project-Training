//
//  FCUtilities.swift
//  Footy-Crazy
//
//  Created by Tintash on 10/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//
//Code review 
// there is no need to use shared instance to call these util functions. You can use add these in protocol extension.
import SafariServices

struct FCUtilities{
    static let shared = FCUtilities()
    private init(){}
}

extension FCUtilities{
    func openLinkInSafari(_ urlString: String,_ nvc: UINavigationController?){
        print("open news link")
        guard let url = URL(string: urlString) else{
            print("Invalid URL")
            return
        }
        let svc = SFSafariViewController(url: url)
        nvc?.present(svc, animated: true, completion: nil)
    }
    func shareContent(_ onVC: UIViewController, _ shareableContent: [Any]){
        let activityViewController = UIActivityViewController(activityItems: shareableContent, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = onVC.view
        onVC.present(activityViewController, animated: true, completion: nil)
    }
    func loadImage(from urlString: String, success: ((_ img: UIImage)->Void)?, failure: ((_ msg: String)->Void)?){
        guard let url = URL(string: urlString) else{
            failure?("Incorrect URL!")
            return
        }
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url){
                if let image = UIImage(data: data){
                    DispatchQueue.main.async {
                        success?(image)
                    }
                } else{
                    DispatchQueue.main.async {
                        failure?("Image downloading failed!")
                    }
                }
            } else{
                DispatchQueue.main.async {
                    failure?("Incorrect URL!")
                }
            }
        }
    }
}
