//
//  FCTeamsVC.swift
//  Footy-Crazy
//
//  Created by Tintash on 11/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit
class FCTeamsVC: UIViewController {
    @IBOutlet weak var activityBGView       : UIView!
    @IBOutlet weak var tableView            : UITableView!
    var viewModel                           : FCTeamsVM?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewModel()
        configureTableViewDelegates()
        registerCells()
    }
}
extension FCTeamsVC{
    func configureViewModel(){
        viewModel = FCTeamsVM([FCTeamsModel]())
        viewModel?.initialDataFetched = {[weak self](success) in
            if success{
                self?.activityBGView.isHidden = true
                self?.tableView.reloadData()
            }
        }
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
        viewModel?.getInitialData()
    }
    func configureTableViewDelegates(){
        tableView.dataSource = self
        tableView.delegate = self
    }
    func registerCells(){
        tableView.register(UINib(nibName: "FCTeamTableViewCell", bundle: nil), forCellReuseIdentifier: "TeamCell")
    }
}
extension FCTeamsVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.itemCount ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        checkForMoreData(at: indexPath.row)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TeamCell") as? FCTeamTableViewCell else {
            return UITableViewCell(.clear)
        }
        let cellVM              = viewModel?.viewModelForDetail(at: indexPath.row)
        cell.viewModel          = cellVM
        cell.configure()
        if let imageUrl = cellVM?.imageUrl{
            if let cache = FCCacheManager.shared.getImage(imageUrl){
                cell.setImage(cache)
            }else {
                FCUtilities.shared.loadImage(from: imageUrl, success: { (downloadedImg) in
                    FCCacheManager.shared.setImage(imageUrl, downloadedImg)
                    if let updateCell = tableView.cellForRow(at: indexPath) as? FCTeamTableViewCell{
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
    func checkForMoreData(at displayingIndex: Int){
        let totalItems = viewModel?.itemCount ?? 0
        let index = totalItems - displayingIndex
        if index <= 5 {
            print("Need Update")
            viewModel?.getMoreData()
        }
    }
}
extension FCTeamsVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "FCTeamsDetailVCSegue", sender: indexPath.row)
    }    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? FCTeamsDetailVC{
            if let index = sender as? Int{
                vc.viewModel = viewModel?.viewModelForDetail(at: index)
            }
        }
    }
}
