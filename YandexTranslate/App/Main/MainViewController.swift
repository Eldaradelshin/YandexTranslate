import Foundation
import UIKit

class MainViewController: UIViewController, MainViewProtocol {

  // MARK: - Properties

  var presenter: MainPresenterProtocol!
  let configurator: MainConfiguratorProtocol = MainConfigurator()

  // MARK: - Views

  @IBOutlet weak var fromLabel: UILabel!
  @IBOutlet weak var toLabel: UILabel!

  @IBOutlet weak var textToTranslateField: UITextField!
  @IBOutlet weak var translatedTextLabel: UILabel!

  @IBOutlet weak var fromPicker: UIPickerView!
  @IBOutlet weak var toPicker: UIPickerView!

  
  @IBAction func searchButton(_ sender: UIButton) {
    presenter.searchButtonClicked(with: textToTranslateField.text ?? "")
  }
  @IBAction func changeTranslationButton(_ sender: Any) {

    presenter.changeLangButtonCLicked()
  }

  // MARK: - Methods

  func changeLanguages() {
    let from = fromLabel.text!
    let to = toLabel.text!
    fromLabel.text = to
    toLabel.text = from
  }

  func setStartLanguages() {
    fromLabel.text = "Русский"
    toLabel.text = "Английский"
  }
  func setFrom(language: String) {
    fromLabel.text = language
  }
  func setTo(language: String) {
    toLabel.text = language
  }
  func setTranslation(text: String) {
    self.translatedTextLabel.text = text
  }
  func showAlert(title: String, description: String) {
      let alertController = UIAlertController(title: title, message: description, preferredStyle: .alert)
      alertController.addAction(UIAlertAction(title: "Закрыть", style: .default))
      self.present(alertController, animated: true, completion: nil)
  }
  func changeTranslateAndTranslated() {
    let buffer = textToTranslateField.text ?? ""
    textToTranslateField.text = translatedTextLabel.text ?? ""
    translatedTextLabel.text = buffer
  }

  func setDelegates() {
    fromPicker.dataSource = self
    toPicker.dataSource = self
    fromPicker.delegate = self
    toPicker.delegate = self
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    configurator.configure(with: self)
    setDelegates()
  }
}

extension MainViewController: UIPickerViewDataSource, UIPickerViewDelegate {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }

  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return presenter.langCodes.count
  }

  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return presenter.langCodes[row].getNameFor()
  }

  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    let selectedRow = presenter.langCodes[row]
    if pickerView.tag == 1 {
      presenter.setFromCode(code: selectedRow)
    }
    if pickerView.tag == 2 {
      presenter.setToCode(code: selectedRow)
    }
  }
}
