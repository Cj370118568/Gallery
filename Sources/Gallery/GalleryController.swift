import UIKit
import AVFoundation

public protocol GalleryControllerDelegate: class {

  func galleryController(_ controller: GalleryController, didSelectImages images: [UIImage])
  func galleryController(_ controller: GalleryController, didSelectVideo video: Video)
  func galleryController(_ controller: GalleryController, requestLightbox images: [UIImage])
  func galleryControllerDidCancel(_ controller: GalleryController)
    func galleryControllerSelectedImageError()
    func didloadCloudImage()
    func didPickSinglePhoto(image:UIImage)
    func didPickGif(data:Data)
}

public class GalleryController: UIViewController, PermissionControllerDelegate {

  lazy var imagesController: ImagesController = self.makeImagesController()
  lazy var cameraController: CameraController = self.makeCameraController()
  lazy var videosController: VideosController = self.makeVideosController()

  public enum Page: Int {
    case images, camera, videos
  }

  lazy var pagesController: PagesController = self.makePagesController()
  lazy var permissionController: PermissionController = self.makePermissionController()
  public weak var delegate: GalleryControllerDelegate?
    
   public var isVideoShow = true
    public var selectedIndex:Page = .camera
    
  // MARK: - Life cycle
    
    
    
    public init(isVideoShow:Bool = true) {
        super.init(nibName: nil, bundle: nil)
        self.isVideoShow = isVideoShow
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  public override func viewDidLoad() {
    super.viewDidLoad()

    setup()

    if Permission.hasPermissions {
      showMain()
    } else {
      showPermissionView()
    }
  }

  deinit {
    Cart.shared.reset()
  }

  public override var prefersStatusBarHidden : Bool {
    return false
  }

  // MARK: - Logic

  public func reload(_ images: [UIImage]) {
    Cart.shared.reload(images)
  }

  func showMain() {
    g_addChildController(pagesController)
  }

  func showPermissionView() {
    g_addChildController(permissionController)
  }

  // MARK: - Child view controller

  func makeImagesController() -> ImagesController {
    let controller = ImagesController()
    controller.title = "Gallery.Images.Title".g_localize(fallback: "图库")
    Cart.shared.add(delegate: controller)

    return controller
  }

  func makeCameraController() -> CameraController {
    let controller = CameraController()
    controller.title = "Gallery.Camera.Title".g_localize(fallback: "照片")
    Cart.shared.add(delegate: controller)

    return controller
  }

  func makeVideosController() -> VideosController {
    let controller = VideosController()
    controller.title = "Gallery.Videos.Title".g_localize(fallback: "视频")

    return controller
  }

  func makePagesController() -> PagesController {
    let controller = self.isVideoShow ? PagesController(controllers: [imagesController, cameraController, videosController]) : PagesController(controllers: [imagesController, cameraController])
    controller.selectedIndex = selectedIndex.rawValue

    return controller
  }

  func makePermissionController() -> PermissionController {
    let controller = PermissionController()
    controller.delegate = self

    return controller
  }

  // MARK: - Setup

  func setup() {
    EventHub.shared.close = { [weak self] in
      if let strongSelf = self {
        strongSelf.delegate?.galleryControllerDidCancel(strongSelf)
      }
    }

    EventHub.shared.doneWithImages = { [weak self] in
      if let strongSelf = self {
        strongSelf.delegate?.galleryController(strongSelf, didSelectImages: Cart.shared.UIImages())
      }
    }

    EventHub.shared.doneWithVideos = { [weak self] in
      if let strongSelf = self, let video = Cart.shared.video {
        strongSelf.delegate?.galleryController(strongSelf, didSelectVideo: video)
      }
    }

    EventHub.shared.stackViewTouched = { [weak self] in
      if let strongSelf = self {
        if Cart.shared.UIImages().count > 0 {
            strongSelf.delegate?.galleryController(strongSelf, requestLightbox: Cart.shared.UIImages())
        }
        
      }
    }
    EventHub.shared.imageError = {
        [weak self] in
        if let strongSelf = self {
            
            strongSelf.delegate?.galleryControllerSelectedImageError()
            
        }
            
    }
    
    EventHub.shared.didLoadCloud = {
        [weak self] in
        if let strongSelf = self {
            strongSelf.delegate?.didloadCloudImage()
        }
    }
    EventHub.shared.didPickSinglePhoto = {
        [weak self] image in
        if let strongSelf = self {
            strongSelf.delegate?.didPickSinglePhoto(image: image)
        }
    }
    
    EventHub.shared.didPickGif = {
        [weak self] data in
        if let strongSelf = self {
            strongSelf.delegate?.didPickGif(data: data)
        }
    }
    
    
    
  }

  // MARK: - PermissionControllerDelegate

  func permissionControllerDidFinish(_ controller: PermissionController) {
    showMain()
    permissionController.g_removeFromParentController()
  }
}
