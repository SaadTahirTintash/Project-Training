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
    var viewModel : FCGalleryVM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = FCGalleryVM([FCGalleryModel]())
        collectionView.dataSource = self
        collectionView.delegate = self
        registerCells()
        initializeCompletionHandlers()
        viewModel?.getInitialData()
    }
    
    func registerCells(){
        collectionView.register(UINib(nibName: "FCGalleryCell", bundle: nil), forCellWithReuseIdentifier: "GalleryCell")        
    }
    
    func initializeCompletionHandlers(){
        
        viewModel?.initialDataCompletionHandler = { [weak self](success) in
            self?.collectionView.reloadData()
        }
        
        viewModel?.moreDataCompletionHandler = {[weak self](success, indexPathArray) in
            if success{
                if let indexPathArray = indexPathArray{
                    self?.collectionView.insertItems(at: indexPathArray)
                }
            }
        }
    }
}

//Collection View DataSource
extension FCGalleryVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.itemCount ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCell", for: indexPath) as? FCGalleryCell else{
            return UICollectionViewCell(.clear)
        }
        cell.viewModel = viewModel?.viewModelForDetail(at: indexPath.row)
        cell.configure()
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
            viewModel?.getMoreData()
        }
    }
}

//Segue
extension FCGalleryVC{
    
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

//Desiging collection cell
extension FCGalleryVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / CGFloat(Constants.GALLERY_CELL_ROW_COUNT) - 1
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
}
