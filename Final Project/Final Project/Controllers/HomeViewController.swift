import UIKit

class HomeViewController: UIViewController {
  
  enum Segue: String {
    case play, setting, history
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let identifier = segue.identifier else { return }
    
    switch identifier {
    case Segue.play.rawValue:
      GameManager.shared.start()
    case Segue.setting.rawValue:
      break
    case Segue.history.rawValue:
      break
    default:
      break
    }
  }

}

