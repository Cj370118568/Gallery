import Foundation
import Photos
import AVFoundation

struct Permission {

<<<<<<< HEAD
  static var hasPermissions: Bool {
    return Photos.hasPermission && Camera.hasPermission
  }

  struct Photos {
    static var hasPermission: Bool {
      return PHPhotoLibrary.authorizationStatus() == .authorized
=======
  enum Status {
    case notDetermined
    case restricted
    case denied
    case authorized
  }

  struct Photos {
    static var status: Status {
      switch PHPhotoLibrary.authorizationStatus() {
      case .notDetermined:
        return .notDetermined
      case .restricted:
        return .restricted
      case .denied:
        return .denied
      case .authorized:
        return .authorized
      }
>>>>>>> hyperoslo/master
    }

    static func request(_ completion: @escaping () -> Void) {
      PHPhotoLibrary.requestAuthorization { status in
        completion()
      }
    }
  }

  struct Camera {
<<<<<<< HEAD
    static var hasPermission: Bool {
      return AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo) == .authorized
=======
    static var needsPermission: Bool {
      return Config.tabsToShow.index(of: .cameraTab) != nil
    }

    static var status: Status {
      switch AVCaptureDevice.authorizationStatus(for: .video) {
      case .notDetermined:
        return .notDetermined
      case .restricted:
        return .restricted
      case .denied:
        return .denied
      case .authorized:
        return .authorized
      }
>>>>>>> hyperoslo/master
    }

    static func request(_ completion: @escaping () -> Void) {
      AVCaptureDevice.requestAccess(for: .video) { granted in
        completion()
      }
    }
  }
}
