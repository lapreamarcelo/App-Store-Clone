//
//  AppDetailController.swift
//  AppStore
//
//  Created by Marcelo Laprea on 5/18/17.
//  Copyright © 2017 AvilaTek. All rights reserved.
//

import Foundation
import UIKit

class AppDetailController: UICollectionViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = UIColor.white
        
    }
    
}


class AppDetailHeader: UICollectionViewCell{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        
    }
}
