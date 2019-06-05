import Foundation

class HistoryInteractor: HistoryInteractorProtocol {

  weak var presenter: HistoryPresenterProtocol!
  let dataService = DataService()

  required init(presenter: HistoryPresenterProtocol) {
    self.presenter = presenter
  }
  func fetchSavedTranslates() -> [Translate] {
    let objects = dataService.fetchTranslations()
    return objects
  }

}
