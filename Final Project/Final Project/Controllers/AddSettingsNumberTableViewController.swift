import UIKit

class AddSettingsNumberTableViewController: UITableViewController {
  @IBOutlet var startNumber: UILabel!
  @IBOutlet var startNumberPicker: UIPickerView!
  
  @IBOutlet var endNumber: UILabel!
  @IBOutlet var endNumberPicker: UIPickerView!
  
  let gameManager = GameManager.shared
  
  var minNumber = 0
  var maxNumber = 0
  
  var startRange: [Int] = []
  var endRange: [Int] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    gameManager.loadSetting()
    minNumber = gameManager.setting.minNumber
    maxNumber = gameManager.setting.maxNumber
    
    updateStartLabel()
    updateEndLabel()
    
    startRange = (1...100).reduce([]) { $0 + [$1] }
    endRange = (1...1000).reduce([]) { $0 + [$1] }

    startNumberPicker.delegate = self
    endNumberPicker.delegate = self
    startNumberPicker.dataSource = self
    endNumberPicker.dataSource = self
    
    startNumberPicker.selectRow(minNumber - 1, inComponent: 0, animated: true)
    endNumberPicker.selectRow(maxNumber - 1, inComponent: 0, animated: true)
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    
    gameManager.setMinNumber(minNumber)
    gameManager.setMaxNumber(maxNumber)
    gameManager.saveSetting()
  }
  
  func updateStartLabel() {
    startNumber.text = String(minNumber)
  }
  
  func updateEndLabel() {
    endNumber.text = String(maxNumber)
  }

  @IBAction func doneAction(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
}

extension AddSettingsNumberTableViewController: UIPickerViewDelegate {
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    if pickerView === startNumberPicker {
      minNumber = startRange[row]
      startNumber.text = String(minNumber)
    } else if pickerView === endNumberPicker {
      maxNumber = endRange[row]
      endNumber.text = String(maxNumber)
    }
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    if pickerView === startNumberPicker {
      return String(startRange[row])
    } else if pickerView === endNumberPicker {
      return String(endRange[row])
    } else {
      return nil
    }
  }
}

extension AddSettingsNumberTableViewController: UIPickerViewDataSource {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    if pickerView === startNumberPicker {
      return startRange.count
    } else if pickerView === endNumberPicker {
      return endRange.count
    } else {
      return 0
    }
  }
}
