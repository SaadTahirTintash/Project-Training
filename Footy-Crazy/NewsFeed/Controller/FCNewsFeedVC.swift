//
//  NewsFeedVC.swift
//  Footy-Crazy
//
//  Created by Tintash on 28/06/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit

class FCNewsFeedVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var newsFeedModel : FCNewsFeedModel = FCNewsFeedModel()
    var isFetchingData = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        if let objects = FCDataManager.shared.newsFeedModel.objects{
            newsFeedModel.objects?.append(contentsOf: objects)
        }
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
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unregisterObserver()
    }
    
    func getKeyID(_ obj: Any?)->Int{
        if let model = obj as? FCVideoModel{
            return Int(model.id) ?? 0
        } else if let model = obj as? FCFactModel{
            return Int(model.id) ?? 0
        } else if let model = obj as? FCNewsLinkModel{
            return Int(model.id) ?? 0
        }
        return 0
    }
}

extension FCNewsFeedVC: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsFeedModel.objects?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let video = newsFeedModel.objects?[indexPath.row] as? FCVideoModel{
            let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell") as! FCVideoTableViewCell
            cell.titleLabel.text = video.title
            cell.videoView.load(withVideoId: video.url, playerVars:["playsinline":1])
            cell.descriptionLabel.text = video.description
            return cell
        }else if let fact = newsFeedModel.objects?[indexPath.row] as? FCFactModel{
            let cell = tableView.dequeueReusableCell(withIdentifier: "FactCell") as! FCFactTableViewCell
            cell.titleLabel.text = fact.title
            cell.imgView?.loadImage(from: URL(string: fact.imageUrl)!)
            cell.factLabel.text = fact.fact
            return cell
        }else if let newsLink = newsFeedModel.objects?[indexPath.row] as? FCNewsLinkModel{
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

//UITableView delegate
extension FCNewsFeedVC: UITableViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentYOffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYOffset
        if distanceFromBottom < height{
            //reached end of table
            if !isFetchingData{
                isFetchingData = true
                var startingId = getKeyID(newsFeedModel.objects?.last)
                if startingId != 0{
                    startingId += 1
                    FCDataManager.shared.getNewsFeed(key: String(startingId), pageSize: Constants.NEWS_FEED_PAGE_SIZE) { [weak self] (success,newsFeedModel) in
                        if let objects = newsFeedModel?.objects{
                            self?.newsFeedModel.objects?.append(contentsOf: objects)
                        }
//                        self?.tableView.reloadData()
                        self?.updateTableRows(newsFeedModel!)
                        self?.isFetchingData = false
                    }
                }
            }
        }
    }
    
    func updateTableRows(_ model: FCNewsFeedModel){
        var indexPathsArray = [IndexPath]()
        for obj in model.objects!{
            let index = getKeyID(obj)
            let indexPath = IndexPath(row: index - 1, section: 0)
            indexPathsArray.append(indexPath)
        }
        tableView.beginUpdates()
        tableView.insertRows(at: indexPathsArray, with: .fade)
        tableView.endUpdates()
    }
}

//observers
extension FCNewsFeedVC{
    func unregisterObserver(){
    }
}
