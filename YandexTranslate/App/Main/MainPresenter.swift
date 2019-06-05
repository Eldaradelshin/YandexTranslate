import Foundation

class MainPresenter: MainPresenterProtocol {

  // MARK: - Properties

  weak var view: MainViewProtocol!
  var interactor: MainInteractorProtocol!
  var router: MainRouterProtocol!

  var langCodes = [LanguageCode.ru, LanguageCode.en, LanguageCode.de]
  var fromLang = LanguageCode.ru
  var toLang =  LanguageCode.en

  required init(view: MainViewProtocol) {
    self.view = view
  }

  // MARK: - Methods

  func configureView() {
    view.setStartLanguages()
  }

  func searchButtonClicked(with text: String) {
    if text == "" {
      view.showAlert(title: "Ошибка", description: "Введите текст.")
    } else {
      if let savedTranslate = interactor.search(text: text) {
        if savedTranslate.lang == self.getTranslationPath() {
          print("Fetched from memory")
          self.view.setTranslation(text: savedTranslate.translation)
        } else {
          interactor.translateText(text: text) { result in
            switch result {
            case .success(let result):
              DispatchQueue.main.async() {
                self.interactor.saveText(text: text, lang: self.getTranslationPath(), translation: (result.text.first)!)
                self.view.setTranslation(text: result.text.first!)
              }
            case .failure(let error):
              DispatchQueue.main.async() {
                self.view.showAlert(title: "Ошибка", description: error.localizedDescription)
              }
            }
          }
        }
      } else {
      interactor.translateText(text: text) { result in
        switch result {
        case .success(let result):
          DispatchQueue.main.async() {
            self.interactor.saveText(text: text, lang: self.getTranslationPath(), translation: (result.text.first)!)
            self.view.setTranslation(text: result.text.first!)
          }
        case .failure(let error):
           DispatchQueue.main.async() {
            self.view.showAlert(title: "Ошибка", description: error.localizedDescription)
          }
        }
      }
    }
  }
}


  func changeLangButtonCLicked() {
    changePath()
    view.changeLanguages()
    view.changeTranslateAndTranslated()
  }

  func changePath() {
    let buffer = fromLang
    fromLang = toLang
    toLang = buffer
    print(getTranslationPath())
  }

  func getTranslationPath() -> String {
    let from = fromLang.rawValue
    let to = toLang.rawValue
    let path = "\(from)-\(to)"
    return path
  }

  func setFromCode(code: LanguageCode) {
    self.fromLang = code
    view.setFrom(language: code.getNameFor())
  }

  func setToCode(code: LanguageCode) {
    self.toLang = code
    view.setTo(language: code.getNameFor())
  }

}
