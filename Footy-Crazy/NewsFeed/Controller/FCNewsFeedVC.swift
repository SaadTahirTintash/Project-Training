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
    @IBOutlet weak var tableView    : UITableView!
    var viewModel                   : FCNewsFeedVM?
    var itemHeights                 : [CGFloat]     = [CGFloat](repeating: UITableView.automaticDimension, count: 100)
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewModel()
        configureTableViewDelegates()
        configureTableViewAutoLayout()
        registerCells()
    }
}
extension FCNewsFeedVC{
    func configureViewModel(){
        viewModel = FCNewsFeedVM(FCDataManager.shared.newsFeedData)
        viewModel?.newDataFetched = { [weak self] success in
            self?.newDataFetched(success)
        }
    }
    func configureTableViewDelegates(){
        tableView.dataSource = self
        tableView.delegate   = self
    }
    func configureTableViewAutoLayout(){
//        tableView.rowHeight = UITableView.automaticDimension
//        tableView.estimatedRowHeight = 450
    }
    func newDataFetched(_ success: Bool){
        guard success else { return }
        let rowCount    = tableView.numberOfRows(inSection: 0)
        let range       = rowCount ..< (viewModel?.itemCount ?? 0)
        var indices     = [IndexPath]()
        for i in range {
            indices.append(IndexPath(row: i, section: 0))
        }
        tableView.beginUpdates()
        tableView.insertRows(at: indices, with: .none)
        tableView.endUpdates()
    }
    func registerCells(){
        tableView.register(UINib(nibName: "FCVideoTableViewCell", bundle: nil), forCellReuseIdentifier: "VideoCell")
        tableView.register(UINib(nibName: "FCFactTableViewCell", bundle: nil), forCellReuseIdentifier: "FactCell")
        tableView.register(UINib(nibName: "FCNewsLinkTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsLinkCell")
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
            return videoTableCell(at: indexPath)
        case "news_link":
            return newsLinkTableCell(at: indexPath)
        case "fact":
            return factTableCell(at: indexPath)
        default:
            return UITableViewCell(.clear)
        }
    }
    func checkForMoreData(at displayingIndex: Int){
        let totalItems = viewModel?.itemCount ?? 0
        let index = totalItems - displayingIndex
        if index <= FCConstants.DATA_FETCH_THRESHOLD {
            print("Need Update")
            viewModel?.getMoreData()
        }
    }
    func videoTableCell(at indexPath: IndexPath)->UITableViewCell{
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell") as? FCVideoTableViewCell else{
            return UITableViewCell(.clear)
        }
        cell.viewModel          = viewModel?.viewModelForDetail(at: indexPath.row)
        cell.shareBtnPressed    = {[weak self] (model) in self?.share(model)}
        cell.configure()
        return cell
    }
    func newsLinkTableCell(at indexPath: IndexPath)->UITableViewCell{
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsLinkCell") as? FCNewsLinkTableViewCell else{
            return UITableViewCell(.clear)
        }
        let cellVM              = viewModel?.viewModelForDetail(at: indexPath.row)
        cell.viewModel          = cellVM
        cell.shareBtnPressed    = {[weak self] (model) in self?.share(model)}
        cell.configure()
        
        return cell
    }
    func factTableCell(at indexPath: IndexPath)->UITableViewCell{
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FactCell") as? FCFactTableViewCell else{
            return UITableViewCell(.clear)
        }
        let cellVM              = viewModel?.viewModelForDetail(at: indexPath.row)
        cell.viewModel          = cellVM
        cell.shareBtnPressed    = {[weak self] (model) in self?.share(model)}
        cell.configure()
        if let imageUrl = cellVM?.url{
            cell.activityIndicator.startAnimating()
            if let cache = FCCacheManager.shared.getImage(imageUrl){
                cell.setImage(cache)
            }else {
                FCUtilities.shared.loadImage(from: imageUrl, success: { [weak self](downloadedImg) in
                    FCCacheManager.shared.setImage(imageUrl, downloadedImg)
                    if let updateCell = self?.tableView.cellForRow(at: indexPath) as? FCFactTableViewCell{
                        updateCell.setImage(downloadedImg)
                    }else{
                        print("Wrong cell")
                    }
                }) { (errorMsg) in
                    print(errorMsg)
                }
            }
        }
        return cell
    }
}
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
extension FCNewsFeedVC{
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("willDisplay: \(indexPath.row)")
        if itemHeights[indexPath.row] == UITableView.automaticDimension {
            itemHeights[indexPath.row] = cell.bounds.height
        }
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        print("estimatedHeightForRowAt: \(indexPath.row)")
        return itemHeights[indexPath.row]
    }
}
extension FCNewsFeedVC{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? FCFactDetailVC{
            if let index = sender as? Int{
                vc.viewModel = viewModel?.viewModelForDetail(at: index)
            }
        } else if let vc = segue.destination as? FCVideoDetailVC{
            if let index = sender as? Int{
                vc.viewModel = viewModel?.viewModelForDetail(at: index)
            }
        } else if let vc = segue.destination as? FCNewsLinkDetailVC{
            if let index = sender as? Int{
                vc.viewModel = viewModel?.viewModelForDetail(at: index)
            }
        }
    }
}
extension FCNewsFeedVC{
    func share(_ newsFeedDetailVM: FCNewsFeedDetailVM?){
        let text = [newsFeedDetailVM?.title,newsFeedDetailVM?.url,newsFeedDetailVM?.description]
        FCUtilities.shared.shareContent(self, text as [Any])
    }
}
