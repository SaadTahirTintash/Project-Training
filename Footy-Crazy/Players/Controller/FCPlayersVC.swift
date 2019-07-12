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
    var playersModelArray: [FCPlayersModel] = [FCPlayersModel]()
    var isFetchingData = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        isFetchingData = true
        registerCells()
        FCDataManager.shared.getPlayers(startingKey: Constants.PLAYERS_STARTING_KEY, pageSize: Constants.PLAYERS_INITIAL_PAGE_SIZE){[weak self](success, modelArray) in
            guard success, let array = modelArray else{
                self?.isFetchingData = false
                return
            }
            self?.playersModelArray.append(contentsOf: array)
            self?.tableView.reloadData()
            self?.isFetchingData = false
        }
    }
    
    func registerCells(){
        tableView.register(UINib(nibName: "FCPlayerTableViewCell", bundle: nil), forCellReuseIdentifier: "PlayerCell")
    }
}

//Tableview Datasource
extension FCPlayersVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playersModelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell") as! FCPlayerTableViewCell
        cell.setupCell(playersModelArray[indexPath.row])
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
            if !isFetchingData{
                isFetchingData = true
                var startingId = playersModelArray.last?.id ?? 0
                if startingId != 0{
                    startingId += 1
                    FCDataManager.shared.getPlayers(startingKey: String(startingId), pageSize: Constants.PLAYERS_PAGE_SIZE) { [weak self](success, playersModelArray) in
                        guard success, let modelArray = playersModelArray else{
                            self?.isFetchingData = false
                            return
                        }
                        self?.playersModelArray.append(contentsOf: modelArray)
                        self?.updateRows(modelArray)
                        self?.isFetchingData = false
                    }
                }
            }
        }
    }
    
    func updateRows(_ modelArray: [FCPlayersModel]){
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
extension FCPlayersVC{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "FCPlayersDetailVCSegue", sender: indexPath.row)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? FCPlayersDetailVC{
            if let index = sender as? Int{
                let model = playersModelArray[index]
                vc.model = model
            }
        }
    }
}

