//
//  FCPlayersVC.swift
//  Footy-Crazy
//
//  Created by Tintash on 11/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit

class FCPlayersVC: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var activityBGView       : UIView!
    @IBOutlet weak var tableView            : UITableView!
    
    //MARK:- Private Properties
    private var cellHeightsDictionary               : [Int: CGFloat] = [:]
    
    //MARK:- Public Properties
    var viewModel                           : FCPlayersVM?
    
    //MARK:- Class Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewModel()
        configureTableViewDelegates()
        registerCells()
    }
}

extension FCPlayersVC {
    
    func configureViewModel(){
        viewModel                       = FCPlayersVM([FCPlayersModel]())
        
        viewModel?.initialDataFetched   = {[weak self](success) in
            if success{
                self?.activityBGView.isHidden = true
                self?.tableView.reloadData()
            }
        }
        
        viewModel?.newDataFetched       = { [weak self] success in
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
        tableView.dataSource    = self
        tableView.delegate      = self
    }
    
    func registerCells() {
        tableView.register(UINib(nibName: FCConstants.NIBS.players, bundle: nil), forCellReuseIdentifier: FCConstants.CELL_IDENTIFIERS.player)
    }
}

//MARK:- Table View DataSource
extension FCPlayersVC: UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.itemCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        checkForMoreData(at: indexPath.row)
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FCConstants.CELL_IDENTIFIERS.player) as? FCPlayerTableViewCell else{
            return tableView.defaultCell()
        }        
        
        cell.viewModel          = viewModel?.viewModelForDetail(at: indexPath.row)
        cell.configure()
        return cell
    }
    
    func checkForMoreData(at displayingIndex: Int) {
        
        let totalItems = viewModel?.itemCount ?? 0
        let index = totalItems - displayingIndex
        if index <= 5 {
            viewModel?.getMoreData()
        }
    }
}

//MARK:- Table View Delegate
extension FCPlayersVC: UITableViewDelegate {
    
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

//MARK:- Segues
extension FCPlayersVC {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: FCConstants.SEGUES.playersDetailVC, sender: indexPath.row)
    }    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? FCPlayersDetailVC{
            if let index = sender as? Int{
                vc.viewModel = viewModel?.viewModelForDetail(at: index)
            }
        }
    }
}

