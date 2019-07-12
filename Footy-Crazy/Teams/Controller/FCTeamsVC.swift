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
    
    var teamsModelArray: [FCTeamsModel] = [FCTeamsModel]()
    var isFetchingData = false

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        isFetchingData = true
        registerCells()
        FCDataManager.shared.getTeams(startingKey: Constants.TEAMS_STARTING_KEY, pageSize: Constants.TEAMS_INITIAL_PAGE_SIZE){[weak self](success, modelArray) in
            guard success, let array = modelArray else{
                self?.isFetchingData = false
                return
            }
            self?.teamsModelArray.append(contentsOf: array)
            self?.tableView.reloadData()
            self?.isFetchingData = false
            
        }
    }
    
    func registerCells(){
        tableView.register(UINib(nibName: "FCTeamTableViewCell", bundle: nil), forCellReuseIdentifier: "TeamCell")
    }
}

//Tableview DataSource
extension FCTeamsVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamsModelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeamCell") as! FCTeamTableViewCell
        cell.setupCell(teamsModelArray[indexPath.row])
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
            if !isFetchingData{
                isFetchingData = true
                var startingId = teamsModelArray.last?.id ?? 0
                if startingId != 0{
                    startingId += 1
                    FCDataManager.shared.getTeams(startingKey: String(startingId), pageSize: Constants.TEAMS_PAGE_SIZE) { [weak self](success, teamsModelArray) in
                        guard success, let modelArray = teamsModelArray else{
                            self?.isFetchingData = false
                            return
                        }
                        self?.teamsModelArray.append(contentsOf: modelArray)
                        self?.updateRows(modelArray)
                        self?.isFetchingData = false
                    }
                }
            }
        }
    }
    
    func updateRows(_ modelArray: [FCTeamsModel]){
        var indexPathsArray = [IndexPath]()
        for obj in modelArray.enumerated(){
            let index = obj.element.id
            let indexPath = IndexPath(row: index - 1, section: 0)
            indexPathsArray.append(indexPath)
        }
        tableView.beginUpdates()
        tableView.insertRows(at: indexPathsArray, with: .fade)
        tableView.endUpdates()
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
                let model = teamsModelArray[index]
                vc.model = model
            }
        }
    }
}
