import UIKit

class GuessViewController: UIViewController,UITextFieldDelegate {
  @IBOutlet var guessNumber: UILabel!
  @IBOutlet var displayLabelG: UILabel!
  @IBOutlet var playerNumberLabel: UILabel!
  @IBOutlet var numberTextFieldG: UITextField!

    @IBOutlet weak var output: UILabel!
    
    let gameManager = GameManager.shared
  var player = 1
  var currentGuessMin = 0
  var currentGuessMax = 0
  
  var guessingNumber: Int {
    return Int(numberTextFieldG.text ?? "") ?? 0
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.numberTextFieldG.delegate = self;
    currentGuessMin = gameManager.game.minNumber
    currentGuessMax = gameManager.game.maxNumber
    updateRangeLabel()
  }
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       let allowedCharacteers = CharacterSet.decimalDigits
       let characterSet  = CharacterSet(charactersIn: string)
       return allowedCharacteers.isSuperset(of: characterSet)
   }
    @IBAction func numberTextFieldGErrorChecking(_ sender: Any) {
        if ( numberTextFieldG.text == "" ) {
                 displayLabelG.text = "Please enter a number"
        
        }
    }
  @IBAction func didTapOk(_ sender: Any) {
    addGuessLog()
    
    let guess = gameManager.game.guessNumber
    
    switch guessingNumber {
    case guess:
      guard let vc = storyboard?.instantiateViewController(withIdentifier: "WinViewController") as? WinViewController else {
        return
      }
      vc.winPlayer = player
      navigationController?.pushViewController(vc, animated: true)
      
    case gameManager.game.minNumber ..< guess:
      currentGuessMin = guessingNumber
      output.text = "HIGHER!"
        
      
    case guess ..< currentGuessMax:
      currentGuessMax = guessingNumber
      output.text = "LOWER!"
      
    default: break
//      Error.popUpMain(on: self, with: "Error Range", message: "Please enter a number from \(currentGuessMin) to \(currentGuessMax).")
    }
   
    if player + 1 <= gameManager.game.playersCount {
      player += 1
    } else {
      player = 1
    }
    
    
    updateRangeLabel()
    updatePlayerNumberLabel()
  }
  
  func updateRangeLabel() {
    displayLabelG.text = "\(currentGuessMin) and \(currentGuessMax)"
  }
  
  func updatePlayerNumberLabel() {
    playerNumberLabel.text = "Player \(player)"
  }
  
  func addGuessLog() {
    let guess = Guess(number: guessingNumber, targetNumber: gameManager.game.guessNumber, player: player, date: .init())
    gameManager.add(guess)
  }
  
  @IBAction func cancel(_ sender: Any) {
    navigationController?.popToRootViewController(animated: true)
  }
  
}
