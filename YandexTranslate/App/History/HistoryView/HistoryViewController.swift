import UIKit

class HistoryViewController: UIViewController, HistoryViewProtocol {

  var presenter: HistoryPresenterProtocol!
  let configurator: HistoryConfiguratorProtocol = HistoryConfigurator()


  @IBOutlet weak var historyTableView: UITableView!

  func setupDelegates() {
    historyTableView.dataSource = self
    historyTableView.delegate = self
  }

  func reloadTableView() {
    historyTableView.reloadData()
  }

  func present(controller: UIViewController) {
    self.show(controller, sender: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupDelegates()
    configurator.configure(with: self)
    presenter.configureView()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
   presenter.configureView()

  }

}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return presenter.translations.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let word = presenter.translations.reversed()[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TranslateCell
    cell.configureWith(translation: word)
    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let word = presenter.translations.reversed()[indexPath.row]
    presenter.cellDidTap(word: word)
  }

  
}
