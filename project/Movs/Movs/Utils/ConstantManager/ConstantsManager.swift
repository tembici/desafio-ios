//
//  Constants.swift
//  Project-Swift
//
//  Created by Erico GT on 3/31/17.
//  Copyright © 2017 Atlantic Solutions. All rights reserved.
//

import UIKit

class ConstantsManager{
    
    //MARK: - PLIST KEYS (User Defaults)
    //=======================================================================================================
    public static let PLISTKEY_SAMPLE:String = "plist_sample"
    
    
    //MARK: - SYSTEM NOTIFICATIONS (para observers)
    //=======================================================================================================
    public static let SYSNOT_SAMPLE:String = "sysnot_sample"
    
    
    //MARK: - CHAVES DICIONARIOS (body, response e afins)
    //=======================================================================================================
    public static let SAMPLE_KEY:String = "sample_key"
    
    
    //MARK: - ENDPOINTS SERVICOS WEB
    //=======================================================================================================
    public static let SERVICE_URL_AUTHENTICATE_USER:String = "/api/v1/authenticate/login"
    
    
    //MARK: - DIRETORIOS E ARQUIVOS:
    //=======================================================================================================
    public static let PROFILE_DIRECTORY:String = "AS_ProfileData"
    public static let PROFILE_FILE:String = "AS_ProfileFile"
    
    
    //MARK: - CONSTANTS / TIME:
    //=======================================================================================================
    public static let ANIMA_TIME_SUPER_FAST:Double = 0.1
    public static let ANIMA_TIME_FAST:Double = 0.2
    public static let ANIMA_TIME_NORMAL:Double = 0.3
    public static let ANIMA_TIME_SLOW:Double = 0.5
    public static let ANIMA_TIME_SLOOOW:Double = 1.0
    //
    public static let FONT_NAME_SAMPLE:String = ""
    //
    public static let FONT_SIZE_SAMPLE:CGFloat = 15.0
    
    //MARK: - TEXT_MASKS
    
    public static let TEXT_MASK_DEFAULT_WILD_SYMBOL:String = "#"
    public static let TEXT_MASK_DEFAULT_CHARS_SET:String = "()/.:-_|+"
    public static let TEXT_MASK_CEP:String = "#####-###"
    public static let TEXT_MASK_PHONE:String = "(##) ####-####"
    public static let TEXT_MASK_CELLPHONE:String = "(##) #####-####"
    public static let TEXT_MASK_GENERIC_PHONE:String = "(##) #########"
    public static let TEXT_MASK_CPF:String = "###.###.###-##"
    public static let TEXT_MASK_CNPJ:String = "##.###.###/####-##"
    public static let TEXT_MASK_BIRTHDATE:String = "##/##/####"
    
    //MARK: - COMPUTED
    //=======================================================================================================
    public final var iPad:Bool{
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    
    public final var iPhone:Bool{
        return UIDevice.current.userInterfaceIdiom == .phone
    }
    
    public final var screenSize:CGSize{
        return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
    
}
