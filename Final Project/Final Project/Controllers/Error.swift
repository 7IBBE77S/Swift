import Foundation
import UIKit

enum Error {
    
    public static func popUpMain(on myViewC: UIViewController, with title: String, message: String) {
        let popUpError = UIAlertController(title: title, message: message, preferredStyle: .alert)
        popUpError.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        DispatchQueue.main.async { myViewC.present(popUpError, animated: true) }
    }
    
    
    static func error(on myViewC: UIViewController) {
        popUpMain(on: myViewC, with: "Error", message: "Enter a valid number")
    }
    
    
}
