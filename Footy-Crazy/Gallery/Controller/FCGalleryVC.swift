//
//  FCGalleryVC.swift
//  Footy-Crazy
//
//  Created by Tintash on 11/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit

class FCGalleryVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var galleryModelArray : [FCGalleryModel] = [FCGalleryModel]()
    var isFetchingData = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        isFetchingData = true
        registerCells()
        FCDataManager.shared.getGallery(startingKey: Constants.GALLERY_STARTING_KEY, pageSize: Constants.GALLERY_INITIAL_PAGE_SIZE){[weak self](success, modelArray) in
            if success, let array = modelArray{
                self?.galleryModelArray.append(contentsOf: array)
                self?.collectionView.reloadData()
            }
            self?.isFetchingData = false
        }
    }
    
    func registerCells(){
        collectionView.register(UINib(nibName: "FCGalleryCell", bundle: nil), forCellWithReuseIdentifier: "GalleryCell")        
    }
}

//Collection View DataSource
extension FCGalleryVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return galleryModelArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCell", for: indexPath) as! FCGalleryCell
        cell.setupCell(galleryModelArray[indexPath.row])
        return cell
    }
}

//Cell Delegates
extension FCGalleryVC: UICollectionViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentYOffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYOffset
        if distanceFromBottom < height{
            //reached end of table
            if !isFetchingData{
                isFetchingData = true
                var startingId = galleryModelArray.last?.id ?? 0
                if startingId != 0{
                    startingId += 1
                    FCDataManager.shared.getGallery(startingKey: String(startingId), pageSize: Constants.GALLERY_PAGE_SIZE) { [weak self](success, galleryModelArray) in
                        guard success, let modelArray = galleryModelArray else{
                            self?.isFetchingData = false
                            return
                        }
                        self?.galleryModelArray.append(contentsOf: modelArray)
                        self?.updateRows(modelArray)
                        self?.isFetchingData = false
                    }
                }
            }
        }
    }
    
    func updateRows(_ modelArray: [FCGalleryModel]){
        var indexPathsArray = [IndexPath]()
        for obj in modelArray.enumerated(){
            let index = obj.element.id
            let indexPath = IndexPath(row: index - 1, section: 0)
            indexPathsArray.append(indexPath)
        }
        collectionView?.performBatchUpdates({
            collectionView.insertItems(at: indexPathsArray)
        }, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //perform segue
        performSegue(withIdentifier: "GalleryImageDetailVCSegue", sender: indexPath.row)
    }
}

//Segue
extension FCGalleryVC{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? FCGalleryDetailVC{
            if let index = sender as? Int{
                let model = galleryModelArray[index]
                vc.model = model
            }
        }
    }
}

//Desiging collection cell
extension FCGalleryVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 25, left: 25, bottom: 25, right: 25)
    }
}
