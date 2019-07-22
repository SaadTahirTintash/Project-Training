//
//  FCPlayersVC.swift
//  Footy-Crazy
//
//  Created by Tintash on 11/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit
class FCPlayersVC: UIViewController {
    @IBOutlet weak var activityBGView       : UIView!
    @IBOutlet weak var tableView            : UITableView!
    var viewModel                           : FCPlayersVM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = FCPlayersVM([FCPlayersModel]())
        tableView.dataSource = self
        tableView.delegate = self
        registerCells()
        initializeCompletionHandlers()
        viewModel?.getInitialData()

    }
    func registerCells(){
        tableView.register(UINib(nibName: "FCPlayerTableViewCell", bundle: nil), forCellReuseIdentifier: "PlayerCell")
    }
    func initializeCompletionHandlers(){
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
    }
}
extension FCPlayersVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.itemCount ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        checkForMoreData(at: indexPath.row)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell") as? FCPlayerTableViewCell else{
            return UITableViewCell(.clear)
        }
        cell.viewModel = viewModel?.viewModelForDetail(at: indexPath.row)
        cell.configure()
        return cell
    }
    func checkForMoreData(at displayingIndex: Int){
        let totalItems = viewModel?.itemCount ?? 0
        let index = totalItems - displayingIndex
        if index <= 5 {
            viewModel?.getMoreData()
        }
    }
}
extension FCPlayersVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "FCPlayersDetailVCSegue", sender: indexPath.row)
    }    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? FCPlayersDetailVC{
            if let index = sender as? Int{
                vc.viewModel = viewModel?.viewModelForDetail(at: index)
            }
        }
    }
}

