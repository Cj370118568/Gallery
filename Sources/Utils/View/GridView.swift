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
  lazy var loadingIndicator: UIActivityIndicatorView = self.makeLoadingIndicator()

  // MARK: - Initialization

  override init(frame: CGRect) {
    super.init(frame: frame)

    setup()
    loadingIndicator.startAnimating()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Setup

<<<<<<< HEAD
  func setup() {
    backgroundColor = UIColor.white

    [collectionView, bottomView, topView, emptyView].forEach {
=======
  private func setup() {
    [collectionView, bottomView, topView, emptyView, loadingIndicator].forEach {
>>>>>>> hyperoslo/master
      addSubview($0)
    }

    [closeButton, arrowButton].forEach {
      topView.addSubview($0)
    }

    [bottomBlurView, doneButton].forEach {
      bottomView.addSubview($0 as! UIView)
    }

<<<<<<< HEAD
    topView.g_pin(on: .top, constant:15)
    topView.g_pin(height: 64)
    topView.g_pin(on: .left)
    topView.g_pin(on: .right)
=======
    Constraint.on(
      topView.leftAnchor.constraint(equalTo: topView.superview!.leftAnchor),
      topView.rightAnchor.constraint(equalTo: topView.superview!.rightAnchor),
      topView.heightAnchor.constraint(equalToConstant: 40),

      loadingIndicator.centerXAnchor.constraint(equalTo: loadingIndicator.superview!.centerXAnchor),
      loadingIndicator.centerYAnchor.constraint(equalTo: loadingIndicator.superview!.centerYAnchor)
    )

    if #available(iOS 11, *) {
      Constraint.on(
        topView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor)
      )
    } else {
      Constraint.on(
        topView.topAnchor.constraint(equalTo: topView.superview!.topAnchor)
      )
    }

>>>>>>> hyperoslo/master
    bottomView.g_pinDownward()
    bottomView.g_pin(height: 80)

    emptyView.g_pinEdges(view: collectionView)
<<<<<<< HEAD
    collectionView.g_pin(on: .left, constant: 12)
    collectionView.g_pin(on: .right, constant: -12)
    collectionView.g_pin(on: .bottom)
=======
    
    collectionView.g_pinDownward()
>>>>>>> hyperoslo/master
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

  private func makeTopView() -> UIView {
    let view = UIView()
    view.backgroundColor = UIColor.white

    return view
  }

  private func makeBottomView() -> UIView {
    let view = UIView()

    return view
  }

<<<<<<< HEAD
  func makeBottomBlurView() -> UIVisualEffectView {
    let view = UIVisualEffectView(effect: UIBlurEffect(style: .light))
=======
  private func makeBottomBlurView() -> UIVisualEffectView {
    let view = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
>>>>>>> hyperoslo/master

    return view
  }

  private func makeArrowButton() -> ArrowButton {
    let button = ArrowButton()
    button.layoutSubviews()

    return button
  }

  private func makeGridView() -> GridView {
    let view = GridView()

    return view
  }

  private func makeCloseButton() -> UIButton {
    let button = UIButton(type: .custom)
<<<<<<< HEAD
//    button.setImage(Bundle.image("gallery_close")?.withRenderingMode(.alwaysTemplate), for: UIControlState())
    button.setTitle("取消", for: .normal)
    button.setTitleColor(Config.Grid.CloseButton.tintColor, for: .normal)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
=======
    button.setImage(GalleryBundle.image("gallery_close")?.withRenderingMode(.alwaysTemplate), for: UIControlState())
>>>>>>> hyperoslo/master
    button.tintColor = Config.Grid.CloseButton.tintColor

    return button
  }

  private func makeDoneButton() -> UIButton {
    let button = UIButton(type: .system)
    button.setTitleColor(UIColor(red: 97/255, green: 120/255, blue: 240/255, alpha: 1), for: UIControlState())
    button.setTitleColor(UIColor.lightGray, for: .disabled)
    button.titleLabel?.font = Config.Font.Text.regular.withSize(16)
    button.setTitle("Gallery.Done".g_localize(fallback: "完成"), for: UIControlState())
    
    return button
  }

  private func makeCollectionView() -> UICollectionView {
    let layout = UICollectionViewFlowLayout()
    layout.minimumInteritemSpacing = 2
    layout.minimumLineSpacing = 2

    let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
    view.backgroundColor = UIColor.white

    return view
  }

  private func makeEmptyView() -> EmptyView {
    let view = EmptyView()
    view.isHidden = true

    return view
  }

  private func makeLoadingIndicator() -> UIActivityIndicatorView {
    let view = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    view.color = .gray
    view.hidesWhenStopped = true

    return view
  }
}
