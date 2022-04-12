import UIKit

final class HistoryDetailViewController: UITableViewController {
  enum Section: CaseIterable {
    case info, detail
    
    var title: String {
      switch self {
      case .info:
        return "The Game Information"
      case .detail:
        return "The Game Logs"
      }
    }
  }
  
  let sections = Section.allCases

  var game: Game!
  var histories: [Guess] {
    return game.guesses
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return sections.count
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let _section = sections[section]
    switch _section {
    case .info:
      return 3
    case .detail:
      return histories.count
    }
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let section = sections[indexPath.section]
    let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryDetail", for: indexPath)
    
    switch section {
    case .info:
      switch indexPath.row {
      case 0:
        cell.textLabel?.text = "Number to Guess: \(game.guessNumber)"
      case 1:
        cell.textLabel?.text = "Range: \(game.minNumber) ~ \(game.maxNumber)"
      case 2:
        cell.textLabel?.text = "Number of Players: \(game.playersCount)"
      default:
        break
      }
      
    case .detail:
      let guess = histories[indexPath.row]
      
      if guess.number == guess.targetNumber {
        cell.textLabel?.text = "Player \(guess.player) Wins: \(guess.targetNumber)"
      } else {
        cell.textLabel?.text = "Player \(guess.player) Guessed: \(guess.number)"
      }
    }
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return sections[section].title
  }
}
