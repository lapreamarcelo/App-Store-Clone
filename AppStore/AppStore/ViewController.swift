//
//  ViewController.swift
//  AppStore
//
//  Created by Marcelo Laprea on 5/16/17.
//  Copyright © 2017 AvilaTek. All rights reserved.
//

import UIKit

class FeaturedAppsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let cellId = "cellId"
    private let largeCellId = "largeCellId"
    private let headerId = "headerId"
    
    var featuredApps: FeaturedApps?
    var appCategories: [AppCategory]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Featured Apps"
        
        //appCategories = AppCategory.sampleAppCategories()
        AppCategory.fetchFeaturedApps { (featuredApps) in
            self.featuredApps = featuredApps
            self.appCategories = featuredApps.appCategories
            self.collectionView?.reloadData()
        }
        
        //Background color
        collectionView?.backgroundColor = UIColor.white
        //For CollectionView we have to register the cell that we created
        collectionView?.register(CategoryCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(LargeCategoryCell.self, forCellWithReuseIdentifier: largeCellId)
        //This is the header
        collectionView?.register(Header.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 2{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: largeCellId, for: indexPath) as! LargeCategoryCell
            cell.appCategory = appCategories?[indexPath.item]
            cell.featuredAppController = self
            return cell
        }
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? CategoryCell
        cell?.featuredAppController = self
        cell?.appCategory = appCategories?[indexPath.item]
        return cell!
    }
    
    
    func showAppDetailForApp(app: App){
        let layout = UICollectionViewFlowLayout()
        let appDetailController = AppDetailController(collectionViewLayout: layout)
        navigationController?.pushViewController(appDetailController, animated: true)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = appCategories?.count{
            return count
        }
        return 0
    }
    
    //We can change de height and width of the cells with this methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.item == 2{
            return CGSize(width: view.frame.width, height: 160)
        }
        
        return CGSize(width: view.frame.width, height: 230)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 120)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! Header
        
        header.appCategory = featuredApps?.bannerCategory
        
        return header
    }
    
}


class Header: CategoryCell{
    
    let cellId = "bannerCellId"
    
    override func setupViews() {
        appsCollectionView.dataSource = self
        appsCollectionView.delegate = self
        
        appsCollectionView.register(BannerCell.self, forCellWithReuseIdentifier: cellId)
        
        addSubview(appsCollectionView)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": appsCollectionView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": appsCollectionView]))
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? AppCell
        cell?.app = appCategory?.apps?[indexPath.item]
        return cell!
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 2 + 50, height: frame.height)
    }
}


private class BannerCell: AppCell{
    
    override func setupViews(){
        imageView.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
        imageView.layer.borderWidth = 0.5
        imageView.layer.cornerRadius = 0
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": imageView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": imageView]))
    }
}

class LargeCategoryCell: CategoryCell{
    
    private let largeAppCellId = "LargeAppCellId"
    
    override func setupViews(){
        super.setupViews()
        appsCollectionView.register(LargeAppCell.self, forCellWithReuseIdentifier: largeAppCellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: largeAppCellId, for: indexPath) as? AppCell
        cell?.app = appCategory?.apps?[indexPath.item]
        return cell!
        
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: frame.height - 32)
    }
}


private class LargeAppCell: AppCell{
    
     override func setupViews(){
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": imageView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-2-[v0]-14-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": imageView]))
    }
}
