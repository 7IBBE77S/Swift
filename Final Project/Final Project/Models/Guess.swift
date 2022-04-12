import Foundation

struct Guess: Codable {
  let number: Int
  let targetNumber: Int
  let player: Int
  let date: Date
}
