import UIKit

class DetailViewController: UIViewController {

  @IBAction func closeButton(_ sender: UIButton) {
    self.dismiss(animated: true, completion: nil)
  }

  var word: String!
  var translation: String!

  @IBOutlet weak var wordLabel: UILabel!

  @IBOutlet weak var translateLabel: UILabel!

  static func configureControllerWith(word: Translate) -> DetailViewController {

    let storyboard = UIStoryboard(name: "Main", bundle: nil)

    let newController = storyboard.instantiateViewController(withIdentifier: "d") as! DetailViewController
    newController.word = word.name
    newController.translation = word.translation

    return newController
  }


  override func viewDidLoad() {
        super.viewDidLoad()
    self.wordLabel.text = word
    self.translateLabel.text = translation
    }

}
