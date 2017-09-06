import UIKit
import AVFoundation

protocol CameraViewDelegate: class {
  func cameraView(_ cameraView: CameraView, didTouch point: CGPoint)
}

class CameraView: UIView, UIGestureRecognizerDelegate {

  lazy var closeButton: UIButton = self.makeCloseButton()
  lazy var flashButton: TripleButton = self.makeFlashButton()
  lazy var rotateButton: UIButton = self.makeRotateButton()
  fileprivate lazy var bottomContainer: UIView = self.makeBottomContainer()
  lazy var bottomView: UIView = self.makeBottomView()
  lazy var stackView: StackView = self.makeStackView()
  lazy var shutterButton: ShutterButton = self.makeShutterButton()
  lazy var doneButton: UIButton = self.makeDoneButton()
  lazy var focusImageView: UIImageView = self.makeFocusImageView()
  lazy var tapGR: UITapGestureRecognizer = self.makeTapGR()
  lazy var rotateOverlayView: UIView = self.makeRotateOverlayView()
  lazy var shutterOverlayView: UIView = self.makeShutterOverlayView()
  lazy var blurView: UIVisualEffectView = self.makeBlurView()

  var timer: Timer?
  var previewLayer: AVCaptureVideoPreviewLayer?
  weak var delegate: CameraViewDelegate?

  // MARK: - Initialization

  override init(frame: CGRect) {
    super.init(frame: frame)

    backgroundColor = UIColor.black
    setup()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Setup

  func setup() {
    addGestureRecognizer(tapGR)

    [closeButton, flashButton, rotateButton, bottomContainer].forEach {
      addSubview($0)
    }

    [bottomView, shutterButton, flashButton, rotateButton].forEach {
      bottomContainer.addSubview($0)
    }

    [stackView, doneButton].forEach {
      bottomView.addSubview($0 as! UIView)
    }

    [closeButton].forEach {
      $0.g_addShadow()
    }

    rotateOverlayView.addSubview(blurView)
    insertSubview(rotateOverlayView, belowSubview: rotateButton)
    insertSubview(focusImageView, belowSubview: bottomContainer)
    insertSubview(shutterOverlayView, belowSubview: bottomContainer)

    closeButton.g_pin(on: .top, constant:18.5)
    closeButton.g_pin(on: .left,constant:12)
//    closeButton.g_pin(size: CGSize(width: 44, height: 44))
    
    

    

    bottomContainer.g_pinDownward()
    bottomContainer.g_pin(height: 118)
    bottomView.g_pinEdges()

    stackView.g_pin(on: .centerY,constant:-3)
    stackView.g_pin(on: .right,view:shutterButton, on:.left , constant: -15)
    stackView.g_pin(size: CGSize(width: 56, height: 56))

    shutterButton.g_pinCenter()
    shutterButton.g_pin(size: CGSize(width: 60, height: 60))
    
    flashButton.g_pin(on: .centerY, view: shutterButton)
    flashButton.g_pin(on: .right, constant: -56)
    flashButton.g_pin(size: CGSize(width: 13, height: 20))
    
    rotateButton.g_pin(on: .centerY, view: shutterButton)
    rotateButton.g_pin(on: .left, constant: 56)
    rotateButton.g_pin(size: CGSize(width: 19, height: 19))
    
    doneButton.g_pin(on: .centerY)
    doneButton.g_pin(on: .left,view:shutterButton,on:.right, constant: 15)

    rotateOverlayView.g_pinEdges()
    blurView.g_pinEdges()
    shutterOverlayView.g_pinEdges()
  }

  func setupPreviewLayer(_ session: AVCaptureSession) {
    guard previewLayer == nil else { return }

    let layer = AVCaptureVideoPreviewLayer(session: session)
    layer?.autoreverses = true
    layer?.videoGravity = AVLayerVideoGravityResizeAspectFill

    self.layer.insertSublayer(layer!, at: 0)
    layer?.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height - 118)

    previewLayer = layer
  }

  // MARK: - Action

  func viewTapped(_ gr: UITapGestureRecognizer) {
    let point = gr.location(in: self)

    focusImageView.transform = CGAffineTransform.identity
    timer?.invalidate()
    delegate?.cameraView(self, didTouch: point)

    focusImageView.center = point

    UIView.animate(withDuration: 0.5, animations: {
      self.focusImageView.alpha = 1
      self.focusImageView.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
    }, completion: { _ in
      self.timer = Timer.scheduledTimer(timeInterval: 1, target: self,
        selector: #selector(CameraView.timerFired(_:)), userInfo: nil, repeats: false)
    })
  }

  // MARK: - Timer

  func timerFired(_ timer: Timer) {
    UIView.animate(withDuration: 0.3, animations: {
      self.focusImageView.alpha = 0
    }, completion: { _ in
      self.focusImageView.transform = CGAffineTransform.identity
    })
  }

  // MARK: - UIGestureRecognizerDelegate
  override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    let point = gestureRecognizer.location(in: self)

    return point.y > closeButton.frame.maxY
      && point.y < bottomContainer.frame.origin.y
  }

  // MARK: - Controls

  func makeCloseButton() -> UIButton {
    let button = UIButton(type: .custom)
//    button.setImage(Bundle.image("gallery_close"), for: UIControlState())
    
    button.setTitle("取消", for: .normal)
    button.setTitleColor(UIColor.white, for: .normal)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    button.tintColor = Config.Grid.CloseButton.tintColor
    
    return button
  }

  func makeFlashButton() -> TripleButton {
    let states: [TripleButton.State] = [
      TripleButton.State(title: "Gallery.Camera.Flash.Off".g_localize(fallback: ""), image: Bundle.image("gallery_camera_flash_off")!),
      TripleButton.State(title: "Gallery.Camera.Flash.On".g_localize(fallback: ""), image: Bundle.image("gallery_camera_flash_on")!),
      TripleButton.State(title: "Gallery.Camera.Flash.Auto".g_localize(fallback: ""), image: Bundle.image("gallery_camera_flash_auto")!)
    ]

    let button = TripleButton(states: states)

    return button
  }

  func makeRotateButton() -> UIButton {
    let button = UIButton(type: .custom)
    button.setImage(Bundle.image("gallery_camera_rotate"), for: UIControlState())

    return button
  }

  func makeBottomContainer() -> UIView {
    let view = UIView()
    view.backgroundColor = UIColor.white
    return view
  }

  func makeBottomView() -> UIView {
    let view = UIView()
    view.backgroundColor = Config.Camera.BottomContainer.backgroundColor
    view.alpha = 0

    return view
  }

  func makeStackView() -> StackView {
    let view = StackView()

    return view
  }

  func makeShutterButton() -> ShutterButton {
    let button = ShutterButton()
    button.g_addShadow()

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

  func makeFocusImageView() -> UIImageView {
    let view = UIImageView()
    view.frame.size = CGSize(width: 110, height: 110)
    view.image = Bundle.image("gallery_camera_focus")
    view.backgroundColor = .clear
    view.alpha = 0

    return view
  }

  func makeTapGR() -> UITapGestureRecognizer {
    let gr = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_:)))
    gr.delegate = self

    return gr
  }

  func makeRotateOverlayView() -> UIView {
    let view = UIView()
    view.alpha = 0

    return view
  }

  func makeShutterOverlayView() -> UIView {
    let view = UIView()
    view.alpha = 0
    view.backgroundColor = UIColor.white

    return view
  }

  func makeBlurView() -> UIVisualEffectView {
    let effect = UIBlurEffect(style: .dark)
    let blurView = UIVisualEffectView(effect: effect)

    return blurView
  }

}
