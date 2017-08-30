import UIKit
import Photos

class GridView: UIView {

  // MARK: - Initialization

  lazy var topView: UIView = self.makeTopView()
  lazy var bottomView: UIView = self.makeBottomView()
  lazy var bottomBlurView: UIVisualEffectView = self.makeBottomBlurView()
  lazy var arrowButton: ArrowButton = self.makeArrowButton()
  lazy var collectionView: UICollectionView = self.makeCollectionView()
  lazy var closeButton: UIButton = self.makeCloseButton()
  lazy var doneButton: UIButton = self.makeDoneButton()
  lazy var emptyView: UIView = self.makeEmptyView()

  // MARK: - Initialization

  override init(frame: CGRect) {
    super.init(frame: frame)

    setup()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Setup

  func setup() {
    backgroundColor = UIColor.white

    [collectionView, bottomView, topView, emptyView].forEach {
      addSubview($0)
    }

    [closeButton, arrowButton].forEach {
      topView.addSubview($0)
    }

    [bottomBlurView, doneButton].forEach {
      bottomView.addSubview($0 as! UIView)
    }

    topView.g_pin(on: .top, constant:15)
    topView.g_pin(height: 64)
    topView.g_pin(on: .left)
    topView.g_pin(on: .right)
    bottomView.g_pinDownward()
    bottomView.g_pin(height: 80)

    emptyView.g_pinEdges(view: collectionView)
    collectionView.g_pin(on: .left, constant: 12)
    collectionView.g_pin(on: .right, constant: -12)
    collectionView.g_pin(on: .bottom)
    collectionView.g_pin(on: .top, view: topView, on: .bottom, constant: 1)

    bottomBlurView.g_pinEdges()

    closeButton.g_pin(on: .centerY, view: topView)
    closeButton.g_pin(on: .left, constant:12)
    closeButton.g_pin(size: CGSize(width: 40, height: 40))
    
    arrowButton.g_pin(on: .centerX, view: topView)
    arrowButton.g_pin(on: .centerY, view: topView)
//    arrowButton.g_pinCenter(view: topView)
    arrowButton.g_pin(height: 40)

    doneButton.g_pin(on: .centerY)
    doneButton.g_pin(on: .right, constant: -38)
  }

  // MARK: - Controls

  func makeTopView() -> UIView {
    let view = UIView()
    view.backgroundColor = UIColor.white

    return view
  }

  func makeBottomView() -> UIView {
    let view = UIView()

    return view
  }

  func makeBottomBlurView() -> UIVisualEffectView {
    let view = UIVisualEffectView(effect: UIBlurEffect(style: .light))

    return view
  }

  func makeArrowButton() -> ArrowButton {
    let button = ArrowButton()
    button.layoutSubviews()

    return button
  }

  func makeGridView() -> GridView {
    let view = GridView()

    return view
  }

  func makeCloseButton() -> UIButton {
    let button = UIButton(type: .custom)
//    button.setImage(Bundle.image("gallery_close")?.withRenderingMode(.alwaysTemplate), for: UIControlState())
    button.setTitle("取消", for: .normal)
    button.setTitleColor(Config.Grid.CloseButton.tintColor, for: .normal)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    button.tintColor = Config.Grid.CloseButton.tintColor

    return button
  }

  func makeDoneButton() -> UIButton {
    let button = UIButton(type: .system)
    button.setTitleColor(UIColor(red: 97/255, green: 120/255, blue: 240/255, alpha: 1), for: UIControlState())
    button.setTitleColor(UIColor.lightGray, for: .disabled)
    button.titleLabel?.font = Config.Font.Text.regular.withSize(16)
    button.setTitle("Gallery.Done".g_localize(fallback: "完成"), for: UIControlState())
    
    return button
  }

  func makeCollectionView() -> UICollectionView {
    let layout = UICollectionViewFlowLayout()
    layout.minimumInteritemSpacing = 2
    layout.minimumLineSpacing = 2

    let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
    view.backgroundColor = UIColor.white

    return view
  }

  func makeEmptyView() -> EmptyView {
    let view = EmptyView()
    view.isHidden = true

    return view
  }
}
