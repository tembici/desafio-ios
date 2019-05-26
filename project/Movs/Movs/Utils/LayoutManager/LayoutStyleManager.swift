//
//  LayoutManager.swift
//  Project-Swift
//
//  Created by Erico GT on 04/04/17.
//  Copyright © 2017 Atlantic Solutions. All rights reserved.
//

import UIKit
//import Kingfisher

enum AppStyle: Int {
    case Default    = 0
    case Light      = 1
    case Dark       = 2
    case Special    = 3
}

class LayoutStyleManager:NSObject{
    
    //Properties:
    var style:AppStyle
    
    //Fixed Colors
    
    var color1:UIColor
    var color2:UIColor
    var color3:UIColor
    var color4:UIColor
    
    //Initializers:
    override init(){
        self.style = .Default
        
        //#F7CE5B
        color1 = UIColor.init(red: 247.0/255.0, green: 206.0/255.0, blue: 91.0/255.0, alpha: 1.0)
        
        //#2D3047
        color2 = UIColor.init(red: 45.0/255.0, green: 48.0/255.0, blue: 71.0/255.0, alpha: 1.0)
        
        //#D9971E
        color3 = UIColor.init(red: 217.0/255.0, green: 151.0/255.0, blue: 30.0/255.0, alpha: 1.0)
        
        //#FFFFFF
        color4 = UIColor.init(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    func setStyle(_ style:AppStyle){
        
        //MARK: Para criar aplicações com set de estilos, implementar as variações abaixo:
        switch style {
        case .Default, .Light, .Dark, .Special:
            self.style = .Default
            //TODO: ...
        }
    }
    
}
