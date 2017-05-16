//
//  Models.swift
//  AppStore
//
//  Created by Marcelo Laprea on 5/16/17.
//  Copyright © 2017 AvilaTek. All rights reserved.
//

import Foundation
import UIKit

class AppCategory: NSObject{
    
    var name: String?
    var apps: [App]?
    
    static func sampleAppCategories() -> [AppCategory]{
        
        let bestNewAppsCategory = AppCategory()
        bestNewAppsCategory.name = "Best New Apps"
        
        let bestNewGamesCategory = AppCategory()
        bestNewGamesCategory.name = "Best New Games"
        
        var bestNewAppssApps = [App]()
        var bestNewGamesApps = [App]()
        
        //Logig
        let angryBirdApp = App()
        angryBirdApp.name = "Angry Bird"
        angryBirdApp.imageName = "angryBird"
        angryBirdApp.category = "Games"
        angryBirdApp.price = NSNumber(floatLiteral: 3.99)
        bestNewAppssApps.append(angryBirdApp)
        bestNewAppsCategory.apps = bestNewAppssApps
        

        let telepaintApp = App()
        telepaintApp.name = "Telepaint"
        telepaintApp.category = "App"
        telepaintApp.imageName = "angryBird"
        telepaintApp.price = NSNumber(floatLiteral: 2.99)
        bestNewGamesApps.append(telepaintApp)
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
