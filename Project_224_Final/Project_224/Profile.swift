//
//  Profile.swift
//  Project_224
//
//

import Foundation
import UIKit
import os

/// Property class
class PropertyKey {
    static let image = "image"
    static let name = "name"
}

/// Profile class with two variables of image and name.
class Profile: NSObject, NSCoding {
    var image: UIImage
    var name: String
    /// self initializing image into defaultImage and name into no name.
    override convenience init(){
        self.init(image: #imageLiteral(resourceName: "defaultImage"), name: "no name")
    }
    
    /// To initialize image and name
    init(image: UIImage, name: String) {
        self.image = image
        self.name = name
    }
    
    static let documentsDirectory = FileManager().urls(for:.documentDirectory, in:.userDomainMask).first!
    static let archiveURL =  documentsDirectory.appendingPathComponent("profile")
    
    /// To check if image and name are inserted by a user
    required convenience init?(coder aDecoder: NSCoder){
        guard let image = aDecoder.decodeObject(forKey: PropertyKey.image) as? UIImage else {
            os_log("Missing image", log: OSLog.default, type:.debug)
            return nil
        }
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Missing string", log: OSLog.default, type:.debug)
            return nil
        }
        self.init(image: image, name: name)
    }
    
    /// Encode function for the image and name
    func encode(with aCoder: NSCoder) {
        aCoder.encode(image, forKey:PropertyKey.image)
        aCoder.encode(name, forKey:PropertyKey.name)
    }
}
