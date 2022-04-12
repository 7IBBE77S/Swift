import UIKit

final class WinViewController: UIViewController {
  var winPlayer: Int = 0
  
  lazy var backBarButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(didTapBack))
  
  @IBOutlet weak var winLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    winLabel.text = "Player \(winPlayer) win!"
    navigationItem.leftBarButtonItem = backBarButton
    
    GameManager.shared.game.guesses.forEach { print($0) }
    GameManager.shared.saveGame()
  }
  
  @objc func didTapBack() {
    navigationController?.popToRootViewController(animated: true)
  }
  
  @IBAction func didTapPlayAgain(_ sender: Any) {
    guard let targetVC = navigationController?.viewControllers.first(where: { $0 is PlayersViewController }) else { return }
    navigationController?.popToViewController(targetVC, animated: true)
  }
}
