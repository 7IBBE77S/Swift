import Foundation

final class GameManager {
  
  static let shared = GameManager()
  
  private(set) var game: Game!
  private(set) var setting = Setting()
  
  func start() {
    loadSetting()
    game = Game(date: .init(), playersCount: 0, guessNumber: 0, minNumber: setting.minNumber, maxNumber: setting.maxNumber, guesses: [])
  }
  
  func setPlayersCount(_ count: Int) {
    game.playersCount = count
  }

  func setMinNumber(_ number: Int) {
    setting.minNumber = number
  }
  
  func setMaxNumber(_ number: Int) {
    setting.maxNumber = number
  }
  
  func setGuessNumber(_ number: Int) {
    game.guessNumber = number
  }
  
  func add(_ guess: Guess) {
    game.guesses.append(guess)
  }
  
  func saveGame() {
    guard let game = game else { return }
    
    let store = GameStore()
    store.save(game)
  }
  
  func saveSetting() {
    let store = GameStore()
    store.save(setting)
  }
  
  func loadSetting() {
    let store = GameStore()
    setting = store.loadSetting()
  }
  
}
