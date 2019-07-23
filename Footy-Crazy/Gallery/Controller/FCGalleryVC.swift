//
//  FCGalleryVC.swift
//  Footy-Crazy
//
//  Created by Tintash on 11/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit
class FCGalleryVC: UIViewController {
    @IBOutlet weak var activityBGView       : UIView!
    @IBOutlet weak var collectionView   : UICollectionView!
    var viewModel                       : FCGalleryVM?
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewModel()
        configureCollectionViewDelegates()
        registerCells()        
    }
}
extension FCGalleryVC{
    func configureViewModel(){
        viewModel = FCGalleryVM([FCGalleryModel]())
        viewModel?.initialDataFetched = { [weak self](success) in
            if success{
                self?.activityBGView.isHidden = true
                self?.collectionView.reloadData()
            }
        }
        viewModel?.newDataFetched = { [weak self] success in
            guard success else { return }
            let rowCount    = (self?.collectionView.numberOfItems(inSection: 0) ?? 0)
            let range       = rowCount ..< (self?.viewModel?.itemCount ?? 0)
            var indices     = [IndexPath]()
            for i in range {
                indices.append(IndexPath(row: i, section: 0))
            }
            self?.collectionView.insertItems(at: indices)
        }
        viewModel?.getInitialData()
    }
    func configureCollectionViewDelegates(){
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    func registerCells(){
        collectionView.register(UINib(nibName: "FCGalleryCell", bundle: nil), forCellWithReuseIdentifier: "GalleryCell")        
    }
}
extension FCGalleryVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.itemCount ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        checkForMoreData(at: indexPath.row)
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCell", for: indexPath) as? FCGalleryCell else{
            return UICollectionViewCell(.clear)
        }
        let cellVM = viewModel?.viewModelForDetail(at: indexPath.row)
        cell.viewModel = cellVM
        if let imageUrl = cellVM?.imageUrl{
            if let cache = FCCacheManager.shared.getImage(imageUrl){
                cell.setImage(cache)
            }else {
                FCUtilities.shared.loadImage(from: imageUrl, success: { (downloadedImg) in
                    FCCacheManager.shared.setImage(imageUrl, downloadedImg)
                    if let updateCell = collectionView.cellForItem(at: indexPath) as? FCGalleryCell{
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
        if index <= FCConstants.DATA_FETCH_THRESHOLD {
            print("Need Update")
            viewModel?.getMoreData()
        }
    }
}
extension FCGalleryVC: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "GalleryImageDetailVCSegue", sender: indexPath.row)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? FCGalleryDetailVC{
            if let index = sender as? Int{                
                vc.viewModel = viewModel?.viewModelForDetail(at: index)
            }
        }
    }
}
extension FCGalleryVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / CGFloat(FCConstants.GALLERY_CONSTANTS.CELL_ROW_COUNT) - 1
        return CGSize(width: width, height: width)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
}


