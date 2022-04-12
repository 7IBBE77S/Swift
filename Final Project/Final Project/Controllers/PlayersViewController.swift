import UIKit

final class PlayersViewController: UIViewController,UITextFieldDelegate {
  @IBOutlet weak var rangeLabel: UILabel!
  @IBOutlet var displayLabel: UILabel!
  @IBOutlet var numberTextField: UITextField!
  @IBOutlet var okButton: UIButton!
  
  let gameManager = GameManager.shared
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.numberTextField.delegate = self;
    rangeLabel.text = "\(gameManager.game.minPlayer) and \(gameManager.game.maxPlayer)"
  }
  
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacteers = CharacterSet.decimalDigits
        let characterSet  = CharacterSet(charactersIn: string)
        return allowedCharacteers.isSuperset(of: characterSet)
    }
   
    @IBAction func playersErrorChecking(_ sender: Any) {
       
        if ( numberTextField.text == "" ) {
                 displayLabel.text = "Please enter a number"
        
        }
    }
    
    
    func validateValue(number: Int) {
    if (gameManager.game.minPlayer ... gameManager.game.maxPlayer).contains(number) {
      gameManager.setPlayersCount(number)
      performSegue(withIdentifier: "server", sender: nil)
      
      displayLabel.text = " "
    
           
    }else {
//      Error.error(on: self)
      
      displayLabel.text = "Enter a valid number"
      
      print("Nope! Try again...")
    }
  }
  
  @IBAction func buttonPressed(_ sender: Any) {
    guard let text = numberTextField.text, let number = Int(text) else { return }
    validateValue(number: number)
  }

  @IBAction func cancel(_ sender: Any) {
    navigationController?.popToRootViewController(animated: true)
  }
  
}
