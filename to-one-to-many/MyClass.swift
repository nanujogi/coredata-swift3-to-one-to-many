//
//  MyClass.swift
//  jacob
//
//  Created by Nanu Jogi on 11/08/17.
//  Copyright © 2017 GL. All rights reserved.
//

import Foundation
import UIKit
import SystemConfiguration

public class MyClass {
    
    // From Hacking with Swift by Paul Hudson all his books rocks!

    // MARK: - Get Documents directory path
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        // print ("paths = \(paths)")
        let documentsDirectory = paths[0]
        // print ("documentsDirectory = \(documentsDirectory)")
        return documentsDirectory
        
    } // end of getDocumentsDirectory
    
    
    // MARK: - Get date from String
    func GetDateFromString(DateStr: String)-> Date {
        let calendar = NSCalendar(identifier: NSCalendar.Identifier.gregorian)
        let DateArray = DateStr.components(separatedBy: "-")
        let components = NSDateComponents()
        components.year = Int(DateArray[2])!
        components.month = Int(DateArray[1])!
        components.day = Int(DateArray[0])! + 1 // +1 because it was decreasing the day by 1 when below line got executed.
        let date = calendar?.date(from: components as DateComponents)
        //       print ("\(date)")
        return date!
    }
    
    // From Hacking with Swift by Paul Hudson all his books rocks!

    // MARK: - Make Attributed String
    func makeAttributedString (title: String, subtitle: String)-> NSAttributedString {
        
        let titleAttributes = [NSFontAttributeName: UIFont.preferredFont(forTextStyle: .body), NSForegroundColorAttributeName: UIColor(red: 0.0, green: 122.0/255, blue: 255/255, alpha: 1.0)]
        
        let subtitleAttributes = [NSFontAttributeName: UIFont.preferredFont(forTextStyle: .subheadline)]
        
        let titleString = NSMutableAttributedString(string: "\(title)\n", attributes: titleAttributes)
        let subtitlesString = NSAttributedString(string: "\(subtitle)", attributes: subtitleAttributes)
        titleString.append(subtitlesString)
        
        return titleString
    }
    
    /*:
     Found at stack overflow
     **seealso**
     [Stack overflow]:
     https://stackoverflow.com/questions/39558868/check-internet-connection-ios-10
     */
    
    func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
    
} // end of MyClass

// Thank you Jacob Bart for your codes it rocks at github!
// MARK: - My Alert
extension UIViewController {
    
    func myalert(mytitle title: String, msg mymessage: String) {
        let ac = UIAlertController(title: title, message: mymessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(ac, animated: true)
    } // end of myalert
}
