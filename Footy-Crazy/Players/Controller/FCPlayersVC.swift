//
//  FCPlayersVC.swift
//  Footy-Crazy
//
//  Created by Tintash on 11/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit

class FCPlayersVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var viewModel: FCPlayersVM?
    
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
        viewModel?.initialDataCompletionHandler = {[weak self](success) in
            if success{
                self?.tableView.reloadData()
            }
        }
        viewModel?.moreDataCompletionHandler = {[weak self](success, indexPathArray) in
            if success{
                if let indexPathArray = indexPathArray{
                    self?.tableView.beginUpdates()
                    self?.tableView.insertRows(at: indexPathArray, with: .fade)
                    self?.tableView.endUpdates()
                }
            }
        }
    }
}

//Tableview Datasource
extension FCPlayersVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.itemCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell") as! FCPlayerTableViewCell
        cell.viewModel = viewModel?.viewModelForDetail(at: indexPath.row)
        cell.configure()
        return cell
    }
    
    
}

//Tableview Delegate
extension FCPlayersVC: UITableViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentYOffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYOffset
        if distanceFromBottom < height{
            //reached end of table
            viewModel?.getMoreData()
        }
    }
}

//Segue
extension FCPlayersVC{
    
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

