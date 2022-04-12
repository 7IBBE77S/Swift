import Foundation

final class GameStore {
  let fileManager = FileManager.default
  
  var documentsUrl: URL {
    return fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
  }
  
  var savedUrl: URL {
    return documentsUrl.appendingPathComponent("games").appendingPathExtension("plist")
  }
  
  var savedSettingUrl: URL {
    return documentsUrl.appendingPathComponent("settings").appendingPathExtension("plist")
  }
  
  func save(_ game: Game) {
    var histories = load()
    histories += [game]
    
    let encoder = PropertyListEncoder()
    let data = try! encoder.encode(histories)
    
    try! data.write(to: savedUrl)
  }
  
  func load() -> [Game] {
    guard let data = try? Data(contentsOf: savedUrl) else { return [] }
    
    let decoder = PropertyListDecoder()

    guard let games = try? decoder.decode([Game].self, from: data) else { return [] }
    
    return games
  }
  
  func save(_ setting: Setting) {
    let encoder = PropertyListEncoder()
    let data = try! encoder.encode(setting)
    
    try! data.write(to: savedSettingUrl)
  }
  
  func loadSetting() -> Setting {
    guard let data = try? Data(contentsOf: savedSettingUrl) else { return .default }
    
    let decoder = PropertyListDecoder()

    guard let setting = try? decoder.decode(Setting.self, from: data) else { return .default }
    
    return setting
  }
}
