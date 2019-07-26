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
        configureViewModel()
        configureTableViewDelegates()
        configureTableViewAutoLayout()
        registerCells()
    }
    
    func configureViewModel() {
        viewModel = FCCitiesLocationVM([FCCitiesLocationModel]())
        
        viewModel?.initialDataFetched = {[weak self]success in
            self?.activityBGView.isHidden = true
            if success{
                self?.tableView.reloadData()
            }
        }
        
        viewModel?.getInitialData()
    }
    
    func configureTableViewDelegates() {
        tableView.dataSource = self
    }
    
    func configureTableViewAutoLayout() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
    }
    
    func registerCells() {
        tableView.register(UINib(nibName: FCConstants.NIBS.citiesLocation, bundle: nil), forCellReuseIdentifier: FCConstants.CELL_IDENTIFIERS.citiesLocation)
    }
}

extension FCCitiesLocationVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.itemCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FCConstants.CELL_IDENTIFIERS.citiesLocation) as? FCCitiesLocationCell else{
            return tableView.defaultCell()
        }
        cell.viewModel = viewModel?.viewModelForDetail(at: indexPath.row)
        cell.configure()
        return cell
    }
}
