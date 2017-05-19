//
//  Models.swift
//  AppStore
//
//  Created by Marcelo Laprea on 5/16/17.
//  Copyright © 2017 AvilaTek. All rights reserved.
//

import Foundation
import UIKit


class FeaturedApps: NSObject{
    
    var bannerCategory: AppCategory?
    var appCategories: [AppCategory]?
    
    override func setValue(_ value: Any?, forKey key: String) {
        
        if key == "categories"{
            appCategories = [AppCategory]()

            for dict in value as! [[String: Any]]{
                let appCategory = AppCategory()
                appCategory.setValuesForKeys(dict)
                appCategories?.append(appCategory)
            }
        }else if key == "bannerCategory"{
            bannerCategory = AppCategory()
            bannerCategory?.setValuesForKeys(value as! [String: Any])
        }else{
            super.setValue(value, forKey: key)
        }
    }
    
}

class AppCategory: NSObject{
    
    var name: String?
    var apps: [App]?
    var type: String?
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "apps"{
            
            apps = [App]()
            for dict in value as! [[String: Any]]{
                let app = App()
                app.setValuesForKeys(dict)
                apps?.append(app)
            }
            
        }else{
            super.setValue(value, forKey: key)
        }
    }
    
    static func fetchFeaturedApps(completionHandler: @escaping (FeaturedApps) -> ()) {
        
        let urlString = "http://www.statsallday.com/appstore/featured"
        
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL) { (data, response, error) -> Void in
            
            if error != nil {
                print(error!)
                return
            }
            
            do {
                
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String: Any]
                
                let featuredApps = FeaturedApps()
                featuredApps.setValuesForKeys(json)
                
//                var appCategories = [AppCategory]()
//                
//                for dict in json["categories"] as! [[String: Any]]{
//                    let appCategory = AppCategory()
//                    appCategory.setValuesForKeys(dict)
//                    appCategories.append(appCategory)
//                }
                
                DispatchQueue.main.async(execute: { () -> Void in
                    completionHandler(featuredApps)
                })
                
            } catch let err {
                
                print(err)
                
            }
            
        }.resume()
        
    }
    
    static func sampleAppCategories() -> [AppCategory]{
        
        let bestNewAppsCategory = AppCategory()
        bestNewAppsCategory.name = "Best New Apps"
        
        let bestNewGamesCategory = AppCategory()
        bestNewGamesCategory.name = "Best New Games"
        
        var bestNewAppssApps = [App]()
        var bestNewGamesApps = [App]()
        
        //Logig
        let telepaintApp = App()
        telepaintApp.name = "Telepaint"
        telepaintApp.category = "Entertainment"
        telepaintApp.imageName = "telepaint"
        telepaintApp.price = NSNumber(floatLiteral: 3.99)
        bestNewAppssApps.append(telepaintApp)
        bestNewAppsCategory.apps = bestNewAppssApps
        
        
        let angryBirdApp = App()
        angryBirdApp.name = "Angry Bird"
        angryBirdApp.category = "Games"
        angryBirdApp.imageName = "angryBird"
        angryBirdApp.price = NSNumber(floatLiteral: 2.99)
        bestNewGamesApps.append(angryBirdApp)
        bestNewGamesCategory.apps = bestNewGamesApps
        
        return [bestNewAppsCategory, bestNewGamesCategory]
    }
}

class App: NSObject{
    
    var id: NSNumber?
    var name: String?
    var category: String?
    var imageName: String?
    var price: NSNumber?
    
}
