import Foundation

class HistoryPresenter: HistoryPresenterProtocol {

  var translations = [Translate]()

  weak var view: HistoryViewProtocol!
  var interactor: HistoryInteractorProtocol!
  var router: HistoryRouterProtocol!

  required init(view: HistoryViewProtocol) {
    self.view = view
  }

  func configureView() {
    translations = interactor.fetchSavedTranslates()
    view.reloadTableView()
  }

  func cellDidTap(word: Translate) {
    router.presentDetailView(with: word)
  }


}
