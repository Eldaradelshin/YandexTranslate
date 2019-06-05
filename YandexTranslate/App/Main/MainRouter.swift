import Foundation

class MainRouter: MainRouterProtocol {

  weak var view: MainViewProtocol!

  required init(view: MainViewProtocol) {
    self.view = view
  }
}
