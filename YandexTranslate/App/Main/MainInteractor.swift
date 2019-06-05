import Foundation

class MainInteractor: MainInteractorProtocol {

  weak var presenter: MainPresenterProtocol!
  let networkService = NetworkService()
  let dataService = DataService()

  required init(presenter: MainPresenterProtocol) {
    self.presenter = presenter
  }

  func translateText(text: String, completion: @escaping (Result<TextResponse, Error>) -> Void) {
    networkService.translateText(text: text, lang: presenter.getTranslationPath()) { response in
      completion(response)
    }
  }

  func search(text: String) -> Translate? {
   let translation =  dataService.fetchObjectBy(word: text)
    return translation
  }
  
  func saveText(text: String, lang: String, translation: String) {
    dataService.save(text: text, lang: lang, translate: translation)
  }
}
