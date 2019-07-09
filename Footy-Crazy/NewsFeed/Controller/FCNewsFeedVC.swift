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
    
    var newsFeedModelArray : [FCNewsFeedModel] = [FCNewsFeedModel]()
    var isFetchingData = false

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        newsFeedModelArray = FCDataManager.shared.newsFeedModelArray        
        registerCells()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
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
    }
}

extension FCNewsFeedVC: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsFeedModelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = newsFeedModelArray[indexPath.row]
        switch model.type {
        case "video":
            let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell") as! FCVideoTableViewCell
            cell.setupCell(model)
            return cell
        case "news_link":
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsLinkCell") as! FCNewsLinkTableViewCell
            cell.setupCell(model)
            return cell
        case "fact":
            let cell = tableView.dequeueReusableCell(withIdentifier: "FactCell") as! FCFactTableViewCell
            cell.setupCell(model)
            return cell
        default:
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
                var startingId = Int(newsFeedModelArray.last?.id ?? "0") ?? 0
                if startingId != 0{
                    startingId += 1
                    FCDataManager.shared.getNewsFeed(key: String(startingId), pageSize: Constants.NEWS_FEED_PAGE_SIZE) { [weak self] (success,newsFeedModelArray) in
                        if let modelArray = newsFeedModelArray{
                            self?.newsFeedModelArray.append(contentsOf: modelArray)
                        }
                        self?.updateTableRows(newsFeedModelArray!)
                        self?.isFetchingData = false
                    }
                }
            }
        }
    }
    
    func updateTableRows(_ modelArray: [FCNewsFeedModel]){
        var indexPathsArray = [IndexPath]()
        for obj in modelArray.enumerated(){
            let index = Int(obj.element.id) ?? 1
            let indexPath = IndexPath(row: index - 1, section: 0)
            indexPathsArray.append(indexPath)
        }
        tableView.beginUpdates()
        tableView.insertRows(at: indexPathsArray, with: .fade)
        tableView.endUpdates()
    }
}
