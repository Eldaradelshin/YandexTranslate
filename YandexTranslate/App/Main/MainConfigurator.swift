import Foundation

class MainConfigurator: MainConfiguratorProtocol {
  func configure(with viewController: MainViewController) {
    let presenter = MainPresenter(view: viewController)
    let interactor = MainInteractor(presenter: presenter)
    let router = MainRouter(view:viewController)

    viewController.presenter = presenter
    presenter.interactor = interactor
    presenter.router = router
  }

}
