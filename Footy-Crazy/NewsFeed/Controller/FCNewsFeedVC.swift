//
//  NewsFeedVC.swift
//  Footy-Crazy
//
//  Created by Tintash on 28/06/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit

/*
 - if you are in this VC, it means we have loaded all the data from the server
 - now we can ask DataManager for any data we want for our app
 - create a tableview in storyboard and fill it using nib cells
 */

class FCNewsFeedVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        registerCells()
    }
    
    func registerCells(){
        tableView.register(UINib(nibName: "FCVideoTableViewCell", bundle: nil), forCellReuseIdentifier: "VideoCell")
        tableView.register(UINib(nibName: "FCFactTableViewCell", bundle: nil), forCellReuseIdentifier: "FactCell")
        tableView.register(UINib(nibName: "FCNewsLinkTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsLinkCell")
        tableView.register(UINib(nibName: "FCEmptyTableViewCell", bundle: nil), forCellReuseIdentifier: "EmptyCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unregisterObserver()
    }
    
}

extension FCNewsFeedVC: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FCDataManager.shared.newsFeedObject.object?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let video = FCDataManager.shared.newsFeedObject.object?[indexPath.row] as? VideoM{
            let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell") as! FCVideoTableViewCell
            cell.titleLabel.text = video.title
            //TODO: load inline video
            cell.descriptionLabel.text = video.description
            return cell
        }else if let fact = FCDataManager.shared.newsFeedObject.object?[indexPath.row] as? FactM{
            let cell = tableView.dequeueReusableCell(withIdentifier: "FactCell") as! FCFactTableViewCell
            cell.titleLabel.text = fact.title
            //TODO: load image
            cell.factLabel.text = fact.fact
            return cell
        }else if let newsLink = FCDataManager.shared.newsFeedObject.object?[indexPath.row] as? NewsLinkM{
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsLinkCell") as! FCNewsLinkTableViewCell
            cell.titleLabel.text = newsLink.title
            //TODO: load news link
            cell.descriptionLabel.text = newsLink.description
            return cell
        }else{
            //this should be an empty cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyCell") as! FCEmptyTableViewCell
            cell.label.text = "No Data!"
            return cell
        }
    }
}

//observers
extension FCNewsFeedVC{
    func registerObserver(){
        FCDataManager.shared.getNewsFeed(){[weak self] (success) in
            self?.tableView.reloadData()
        }
    }
    
    func unregisterObserver(){
        FCDataManager.shared.removeNewsFeedObserver()
    }
}
