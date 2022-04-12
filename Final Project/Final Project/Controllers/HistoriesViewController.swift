import UIKit

final class HistoriesViewController: UITableViewController {
  let gameStore = GameStore()
  var games: [Game] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()

    games = gameStore.load()
    tableView.reloadData()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard
      segue.identifier == "HistoryDetail",
      let cell = sender as? UITableViewCell,
      let indexPath = tableView.indexPath(for: cell),
      let tv = segue.destination as? HistoryDetailViewController
    else { return }
      
    let game = games[indexPath.row]
    tv.game = game
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return games.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath)
    let game = games[indexPath.row]
    cell.textLabel?.text = "Game #\(indexPath.row + 1) - (\(game.playersCount) players)"
    
    let df = DateFormatter()
    df.dateStyle = .long
    df.timeStyle = .short
    cell.detailTextLabel?.text = df.string(from: game.date)

    return cell
  }
  
  @IBAction func dismiss(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
}
