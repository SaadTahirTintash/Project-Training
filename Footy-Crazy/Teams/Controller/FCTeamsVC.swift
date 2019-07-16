//
//  FCTeamsVC.swift
//  Footy-Crazy
//
//  Created by Tintash on 11/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit

class FCTeamsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel: FCTeamsVM?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = FCTeamsVM([FCTeamsModel]())
        tableView.dataSource = self
        tableView.delegate = self
        registerCells()
        initializeCompletionHandlers()
        viewModel?.getInitialData()
    }
    
    func registerCells(){
        tableView.register(UINib(nibName: "FCTeamTableViewCell", bundle: nil), forCellReuseIdentifier: "TeamCell")
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

//Tableview DataSource
extension FCTeamsVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.itemCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TeamCell") as? FCTeamTableViewCell else {
            return UITableViewCell(.clear)
        }
        cell.viewModel = viewModel?.viewModelForDetail(at: indexPath.row)
        cell.configure()
        return cell
    }
}

//Tableview Delegate
extension FCTeamsVC: UITableViewDelegate{
    
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
extension FCTeamsVC{
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
