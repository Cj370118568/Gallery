import UIKit

protocol PageIndicatorDelegate: class {
  func pageIndicator(_ pageIndicator: PageIndicator, didSelect index: Int)
}

class PageIndicator: UIView {

  let items: [String]
  var buttons: [UIButton]!
  lazy var indicator: UIImageView = self.makeIndicator()
  weak var delegate: PageIndicatorDelegate?

  // MARK: - Initialization

  required init(items: [String]) {
    self.items = items

    super.init(frame: .zero)

    setup()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Layout

  override func layoutSubviews() {
    super.layoutSubviews()

    let width = bounds.size.width / CGFloat(buttons.count)

    for (i, button) in buttons.enumerated() {

      button.frame = CGRect(x: width * CGFloat(i),
                            y: 0,
                            width: width,
                            height: bounds.size.height)
    }

    indicator.frame.size = CGSize(width: width / 1.5, height: 4)
    indicator.frame.origin.y = bounds.size.height - indicator.frame.size.height

    if indicator.frame.origin.x == 0 {
      select(index: 0)
    }
  }

  override func didMoveToSuperview() {
    super.didMoveToSuperview()
  }

  // MARK: - Setup

  func setup() {
    buttons = items.map {
      let button = self.makeButton($0)
      addSubview(button)

      return button
    }

    addSubview(indicator)
  }

  // MARK: - Controls

  func makeButton(_ title: String) -> UIButton {
    let button = UIButton(type: .custom)
    button.setTitle(title, for: UIControlState())
    button.setTitleColor(Config.PageIndicator.textColor, for: .normal)
    let color = UIColor(red: 97/255, green: 120/255, blue: 240/255, alpha: 1)
    button.setTitleColor(color, for: .highlighted)
    button.setTitleColor(color, for: .selected)
    button.backgroundColor = Config.PageIndicator.backgroundColor
    button.addTarget(self, action: #selector(buttonTouched(_:)), for: .touchUpInside)
    button.titleLabel?.font = buttonFont(false)
    
    return button
  }

  func makeIndicator() -> UIImageView {
    let imageView = UIImageView(image: Bundle.image("gallery_page_indicator"))

    return imageView
  }

  // MARK: - Action

  func buttonTouched(_ button: UIButton) {
    let index = buttons.index(of: button) ?? 0
    delegate?.pageIndicator(self, didSelect: index)
    select(index: index)
  }

  // MARK: - Logic

  func select(index: Int) {
    for (i, b) in buttons.enumerated() {
      b.titleLabel?.font = buttonFont(i == index)
        if i == index {
            b.isSelected = true
        }
        else {
            b.isSelected = false
        }
    }

    UIView.animate(withDuration: 0.25, delay: 0,
                               usingSpringWithDamping: 0.7,
                               initialSpringVelocity: 0.5,
                               options: [],
                               animations:
      {
        self.indicator.center.x = self.buttons[index].center.x
      }, completion: nil)
  }

  // MARK: - Helper

  func buttonFont(_ selected: Bool) -> UIFont {
    return selected ? Config.Font.Main.bold.withSize(14) : Config.Font.Main.bold.withSize(14)
  }
}
