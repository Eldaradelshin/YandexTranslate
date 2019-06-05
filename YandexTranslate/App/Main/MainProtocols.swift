import Foundation

protocol MainConfiguratorProtocol: class {
  func configure(with viewController: MainViewController)
}

protocol MainPresenterProtocol: class {
  var router: MainRouterProtocol! { get set }
  var langCodes:[LanguageCode]  { get set }
  func configureView()
  func setFromCode(code: LanguageCode)
  func setToCode(code: LanguageCode)
  func searchButtonClicked(with text: String)
  func changeLangButtonCLicked()
  func getTranslationPath() -> String
}

protocol MainRouterProtocol: class {

}

protocol MainViewProtocol: class {
  func changeLanguages()
  func setStartLanguages()
  func setFrom(language: String)
  func setTo(language: String)
  func showAlert(title: String, description: String)
  func setTranslation(text: String)
  func changeTranslateAndTranslated()
}

protocol MainInteractorProtocol: class {
  func translateText(text: String, completion: @escaping (Result<TextResponse, Error>) -> Void)
  func search(text:String) -> Translate?
  func saveText(text: String, lang: String, translation: String)
}
