import Foundation

class HistoryRouter: HistoryRouterProtocol {

  weak var view: HistoryViewProtocol!

  required init(view: HistoryViewProtocol) {
    self.view = view
  }

  func presentDetailView(with word: Translate) {
    print(word.name)
    let controller = DetailViewController.configureControllerWith(word: word)
    view.present(controller: controller)
  }
}
