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
    
    //MARK:- Outlets
    @IBOutlet weak var tableView    : UITableView!
    
    //MARK:- Public Properties
    var viewModel                   : FCNewsFeedVM?
    var cellHeightsDictionary       : [Int: CGFloat] = [:]
    
    //MARK:- Class Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewModel()
        configureTableViewDelegates()
        configureTableViewAutoLayout()
        registerCells()
    }
}

//MARK:- Extension
extension FCNewsFeedVC {
    
    func configureViewModel() {
        viewModel = FCNewsFeedVM(FCDataManager.shared.getNewsFeedData())
        viewModel?.newDataFetched = { [weak self] success in
            self?.newDataFetched(success)
        }
    }
    
    func configureTableViewDelegates() {
        tableView.dataSource = self
        tableView.delegate   = self
    }
    
    func configureTableViewAutoLayout() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 450
    }
    
    func newDataFetched(_ success: Bool) {
        
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
        
        tableView.register(UINib(nibName: FCConstants.NIBS.video, bundle: nil),
                           forCellReuseIdentifier: FCConstants.CELL_IDENTIFIERS.video)
        tableView.register(UINib(nibName: FCConstants.NIBS.fact, bundle: nil),
                           forCellReuseIdentifier: FCConstants.CELL_IDENTIFIERS.fact)
        tableView.register(UINib(nibName: FCConstants.NIBS.newsLink, bundle: nil),
                           forCellReuseIdentifier: FCConstants.CELL_IDENTIFIERS.newsLink)
    }
}

//MARK:- Table View DataSource
extension FCNewsFeedVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.itemCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let type = viewModel?.getType(of: indexPath.row) else{
            return tableView.defaultCell()
        }
        checkForMoreData(at: indexPath.row)
        
        switch type {
        case FCNewsFeedObjectType.video:
            return videoTableCell(at: indexPath)
        case FCNewsFeedObjectType.news_link:
            return newsLinkTableCell(at: indexPath)
        case FCNewsFeedObjectType.fact:
            return factTableCell(at: indexPath)
        default:
            return tableView.defaultCell()
        }
    }
    
    func checkForMoreData(at displayingIndex: Int) {
        
        let totalItems = viewModel?.itemCount ?? 0
        let index = totalItems - displayingIndex
        if index <= FCConstants.DATA_FETCH_THRESHOLD {
            viewModel?.getMoreData()
        }
    }
    
    func videoTableCell(at indexPath: IndexPath)->UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FCConstants.CELL_IDENTIFIERS.video) as? FCVideoTableViewCell else{
            return tableView.defaultCell()
        }
        
        cell.viewModel = viewModel?.viewModelForDetail(at: indexPath.row)
        cell.shareBtnPressed    = {[weak self] (model) in self?.share(model)}
        cell.configure()
        return cell
    }
    
    func newsLinkTableCell(at indexPath: IndexPath)->UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FCConstants.CELL_IDENTIFIERS.newsLink) as? FCNewsLinkTableViewCell else{
            return tableView.defaultCell()
        }
        
        cell.viewModel = viewModel?.viewModelForDetail(at: indexPath.row)
        cell.shareBtnPressed    = {[weak self] (model) in self?.share(model)}
        cell.configure()
        return cell
    }
    
    func factTableCell(at indexPath: IndexPath)->UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FCConstants.CELL_IDENTIFIERS.fact) as? FCFactTableViewCell else{
            return tableView.defaultCell()
        }
        
        cell.viewModel = viewModel?.viewModelForDetail(at: indexPath.row)
        cell.shareBtnPressed    = {[weak self] (model) in self?.share(model)}
        cell.configure()
        return cell
    }
    
}

//MARK:- Table View Delegate
extension FCNewsFeedVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let type = viewModel?.getType(of: indexPath.row) {
            switch type {
            case FCNewsFeedObjectType.news_link:
                performSegue(withIdentifier: FCConstants.SEGUES.newsLinkDetailVC, sender: indexPath.row)
            case FCNewsFeedObjectType.video:
                performSegue(withIdentifier: FCConstants.SEGUES.videoDetailVC, sender: indexPath.row)
            case FCNewsFeedObjectType.fact:
                performSegue(withIdentifier: FCConstants.SEGUES.factDetailVC, sender: indexPath.row)
            default:
                print(FCConstants.ERRORS.segueError)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cellHeightsDictionary[indexPath.row] = cell.bounds.height
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if cellHeightsDictionary[indexPath.row] != nil{
            return cellHeightsDictionary[indexPath.row] ?? UITableView.automaticDimension
        }
        return UITableView.automaticDimension
    }
}

//MARK:- Segue
extension FCNewsFeedVC {
    
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

//MARK:- Sharing Content
extension FCNewsFeedVC: FCShareContent {
    
    func share(_ newsFeedDetailVM: FCNewsFeedDetailVM?){
        let text = [newsFeedDetailVM?.title,newsFeedDetailVM?.url,newsFeedDetailVM?.description]
        shareContent(self, text as [Any])
    }
}
