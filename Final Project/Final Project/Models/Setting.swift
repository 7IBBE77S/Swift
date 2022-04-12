struct Setting: Codable {
  var minNumber: Int = 1
  var maxNumber: Int = 1000
  
  static let `default` = Setting(minNumber: 1, maxNumber: 1000)
}
