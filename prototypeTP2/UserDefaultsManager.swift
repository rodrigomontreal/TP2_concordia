//: Playground - noun: a place where people can play
//classe c'est un gabarit, un plan pour créer un objet.
import Foundation

class UserDefaultsManager {
    func doesKeyExist(theKey: String) -> Bool {
        if UserDefaults.standard.object(forKey: theKey) == nil {
            return false
        }
        return true
    }
    
    func setKey(theValue:AnyObject, theKey:String) {
        UserDefaults.standard.set(theValue, forKey: theKey)
    }
    func removeKey(theKey: String) {
        UserDefaults.standard.removeObject(forKey: theKey)
    }
    func getValue(theKey: String) -> AnyObject {
        return UserDefaults.standard.object(forKey: theKey) as AnyObject
    }
    
    
}

