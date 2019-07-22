//
//  FCCitiesLocationVC.swift
//  Footy-Crazy
//
//  Created by Tintash on 18/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit

class FCCitiesLocationVC: UIViewController {

    @IBOutlet weak var activityBGView       : UIView!
    @IBOutlet weak var tableView            : UITableView!
    var viewModel                           : FCCitiesLocationVM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = FCCitiesLocationVM([FCCitiesLocationModel]())
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
        registerCells()
        initializeCompletionHandlers()
        DispatchQueue.global().async {[weak self] in
            self?.viewModel?.getInitialData()
        }
    }
    
    func registerCells(){
        tableView.register(UINib(nibName: "FCCitiesLocationCell", bundle: nil), forCellReuseIdentifier: "FCCitiesLocationCell")
    }
    
    func initializeCompletionHandlers(){
        viewModel?.initialDataFetched = {[weak self]success in
            self?.activityBGView.isHidden = true
            if success{
                DispatchQueue.main.async {[weak self] in
                    self?.tableView.reloadData()
                }                
            }
        }
    }
}

extension FCCitiesLocationVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.itemCount ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FCCitiesLocationCell") as? FCCitiesLocationCell else{
            return UITableViewCell(.clear)
        }
        cell.viewModel = viewModel?.viewModelForDetail(at: indexPath.row)
        cell.configure()
        return cell
    }
}
