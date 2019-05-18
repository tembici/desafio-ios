//
//  SplashPresenterBuilder.swift
//  Desafio-Tembici
//
//  Created by Pedro Alvarez on 17/05/19.
//  Copyright © 2019 Pedro Alvarez. All rights reserved.
//

import Foundation

final class SplashPresenterBuilder{
    
    static func make(wireframe: SplashWireframe) -> SplashPresenter{
        
        return SplashPresenter(wireframe: wireframe)
    }
}
