//
//  NewsFeedVC.swift
//  Footy-Crazy
//
//  Created by Tintash on 28/06/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit
import SafariServices

class FCNewsFeedVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel: FCNewsFeedVM?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = FCNewsFeedVM(FCDataManager.shared.newsFeedModelArray)
        tableView.dataSource = self
        tableView.delegate = self
        registerCells()
        initializeCompletionHandlers()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 450
    }
    
    func registerCells(){
        tableView.register(UINib(nibName: "FCVideoTableViewCell", bundle: nil), forCellReuseIdentifier: "VideoCell")
        tableView.register(UINib(nibName: "FCFactTableViewCell", bundle: nil), forCellReuseIdentifier: "FactCell")
        tableView.register(UINib(nibName: "FCNewsLinkTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsLinkCell")
        tableView.register(UINib(nibName: "FCEmptyTableViewCell", bundle: nil), forCellReuseIdentifier: "EmptyCell")
    }
    
    func initializeCompletionHandlers(){
        viewModel?.newDataFetched = { [weak self] success in
            guard success else { return }
            let rowCount    = (self?.tableView.numberOfRows(inSection: 0) ?? 0)
            let range       = rowCount ..< (self?.viewModel?.itemCount ?? 0)
            var indices     = [IndexPath]()
            for i in range {
                indices.append(IndexPath(row: i, section: 0))
            }
            self?.tableView.beginUpdates()
            self?.tableView.insertRows(at: indices, with: .fade)
            self?.tableView.endUpdates()
        }
    }
}

extension FCNewsFeedVC: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.itemCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let type = viewModel?.getType(of: indexPath.row) else{
            return UITableViewCell(.clear)
        }
        checkForMoreData(at: indexPath.row)
        switch type {
        case "video":
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell") as? FCVideoTableViewCell else{
                return UITableViewCell(.clear)
            }
            cell.shareBtnDelegate = self
            cell.viewModel = viewModel?.viewModelForDetail(at: indexPath.row)
            cell.configure()
            return cell
        case "news_link":
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsLinkCell") as? FCNewsLinkTableViewCell else{
                return UITableViewCell(.clear)
            }
            cell.shareBtnDelegate = self
            cell.viewModel = viewModel?.viewModelForDetail(at: indexPath.row)
            cell.configure()
            return cell
        case "fact":
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FactCell") as? FCFactTableViewCell else{
                return UITableViewCell(.clear)
            }
            cell.shareBtnDelegate = self
            cell.viewModel = viewModel?.viewModelForDetail(at: indexPath.row)
            cell.configure()
            return cell
        default:
            return UITableViewCell(.clear)
        }
    }
    
    func checkForMoreData(at displayingIndex: Int){
        let totalItems = viewModel?.itemCount ?? 0
        let index = totalItems - displayingIndex
        if index <= 5 {
            print("Need Update")
            viewModel?.getMoreData()
        }
    }
}

//UITableView delegate
extension FCNewsFeedVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let type = viewModel?.getType(of: indexPath.row){
            switch type {
            case "news_link":
                performSegue(withIdentifier: "FCNewsLinkDetailVC", sender: indexPath.row)
            case "video":
                performSegue(withIdentifier: "FCVideoDetailVC", sender: indexPath.row)
            case "fact":
                performSegue(withIdentifier: "FCFactDetailVC", sender: indexPath.row)
            default:
                print("Can't perform segue for empty cells")
            }
        }
    }
}

//segue
extension FCNewsFeedVC{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? FCFactDetailVC{
            if let index = sender as? Int{
                vc.viewModel = viewModel?.viewModelForDetail(at: index)
            }
        }
        else if let vc = segue.destination as? FCVideoDetailVC{
            if let index = sender as? Int{
                vc.viewModel = viewModel?.viewModelForDetail(at: index)
            }
        }
        else if let vc = segue.destination as? FCNewsLinkDetailVC{
            if let index = sender as? Int{
                vc.viewModel = viewModel?.viewModelForDetail(at: index)
            }
        }
    }
}

//cell button press protocol
extension FCNewsFeedVC: FCNewsFeedShareButtonDelegate{
    func didPressShareButton(_ newsFeedVM: FCNewsFeedDetailVM?) {
        let text = [newsFeedVM?.title,newsFeedVM?.url,newsFeedVM?.description]
        FCUtilities.shareContent(self, text as [Any])
    }
}
