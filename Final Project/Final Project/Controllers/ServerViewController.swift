import UIKit

class ServerViewController: UIViewController,UITextFieldDelegate {
  @IBOutlet var displayLabelS: UILabel!
  @IBOutlet var okButton: UIButton!
  @IBOutlet var numberTextFieldS: UITextField!
  @IBOutlet weak var rangeLabel: UILabel!
  
  let gameManager = GameManager.shared
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.numberTextFieldS.delegate = self;
    rangeLabel.text = "\(gameManager.game.minNumber) and \(gameManager.game.maxNumber)"
  }
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       let allowedCharacteers = CharacterSet.decimalDigits
       let characterSet  = CharacterSet(charactersIn: string)
       return allowedCharacteers.isSuperset(of: characterSet)
   }
    @IBAction func numberTextFieldSErrorChecking(_ sender: Any) {
        if ( numberTextFieldS.text == "" ) {
                 displayLabelS.text = "Please enter a number"
        
        }
    }
    func validateValue(number : Int) {
    if (gameManager.game.minNumber ... gameManager.game.maxNumber).contains(number) {
      gameManager.setGuessNumber(number)
      performSegue(withIdentifier: "guess", sender: nil)

      displayLabelS.text = " "
    } else {
//      Error.error(on: self)
      displayLabelS.text = "Enter a valid number"
      
      print("Nope! Try again...")
    }
  }
  
  @IBAction func buttonPressedS(_ sender: Any) {
    guard let text = numberTextFieldS.text, let number = Int(text) else { return }
    validateValue(number: number)
  }
  
  @IBAction func cancel(_ sender: Any) {
    navigationController?.popToRootViewController(animated: true)
  }
}
