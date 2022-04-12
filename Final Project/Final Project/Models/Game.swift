import Foundation

struct Game: Codable {
  var date: Date = .init()
  var playersCount: Int = 0
  var guessNumber: Int = 0
  let minNumber: Int
  let maxNumber: Int
  let minPlayer: Int = 2
  let maxPlayer: Int = 50
  var guesses: [Guess] = []
}
