import Foundation

class HistoryConfigurator: HistoryConfiguratorProtocol {
  func configure(with viewController: HistoryViewController) {
    let presenter = HistoryPresenter(view: viewController)
    let interactor = HistoryInteractor(presenter: presenter)
    let router = HistoryRouter(view:viewController)

    viewController.presenter = presenter
    presenter.interactor = interactor
    presenter.router = router
  }

}
