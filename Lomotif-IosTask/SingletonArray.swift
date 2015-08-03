//
//  SingletonArray.swift
//  Lomotif-IosTask
//
//  Created by Prasanna V on 04/08/15.
//  Copyright (c) 2015 swift. All rights reserved.
//

import Foundation

class SingletonModelDB {
    
        var arrayOfPlaylistItems:Array<PlaylistModel> = []
        
        class var sharedInstance :SingletonModelDB {
            struct _Singleton {
                static let instance = SingletonModelDB()
            }
            
            return _Singleton.instance
        }
    
}