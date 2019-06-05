import UIKit

class TranslateCell: UITableViewCell {

    
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var translationLabel: UILabel!

  func configureWith(translation: Translate) {
    self.nameLabel.text = translation.name
    self.translationLabel.text = translation.translation
  }

}
