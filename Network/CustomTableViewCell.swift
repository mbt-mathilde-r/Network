import UIKit

class CustomTableViewCell: UITableViewCell {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  static let identifier = "CustomTableViewCell"

  @IBOutlet weak private var titleLabel: UILabel!
  @IBOutlet weak private var bodyLabel: UILabel!

  //----------------------------------------------------------------------------
  // MARK: - Lifecycle
  //----------------------------------------------------------------------------

  override func awakeFromNib() {
    super.awakeFromNib()
    setup()
  }

  private func setup() {
    bodyLabel.numberOfLines = 0
  }

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  func setup(with post: PostModel) {
    titleLabel.text = post.title
    bodyLabel.text = post.body
  }

}
