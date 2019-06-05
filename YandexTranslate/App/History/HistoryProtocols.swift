import Foundation
import UIKit

protocol HistoryConfiguratorProtocol: class {
  func configure(with viewController: HistoryViewController)
}

protocol HistoryPresenterProtocol: class {
  var router: HistoryRouterProtocol! { get set }
  var translations: [Translate] { get set }
  
  func configureView()
  func cellDidTap(word: Translate)

}

protocol HistoryRouterProtocol: class {
  func presentDetailView(with word: Translate)
}

protocol HistoryViewProtocol: class {
  func reloadTableView()
  func present(controller: UIViewController)
}

protocol HistoryInteractorProtocol: class {
  func fetchSavedTranslates() -> [Translate]
}
