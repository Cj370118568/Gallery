import UIKit
import AVFoundation

public struct Config {

  public struct PageIndicator {
    public static var backgroundColor: UIColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
    public static var textColor: UIColor = UIColor.lightGray
  }

  public struct Camera {

    public static var recordLocation: Bool = false

    public struct ShutterButton {
      public static var numberColor: UIColor = UIColor(red: 54/255, green: 56/255, blue: 62/255, alpha: 1)
        public static var buttonColor: UIColor = UIColor(red: 111/255, green: 131/255, blue: 237/255, alpha: 1)
    }

    public struct BottomContainer {
      public static var backgroundColor: UIColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.8)
    }

    public struct StackView {
      public static let imageCount: Int = 4
    }
    
    public static var imageLimit: Int = 1
    
    public static var isGifSupport = false
  }

    
    
  public struct Grid {

    public struct CloseButton {
      public static var tintColor: UIColor = UIColor(red: 97/255, green: 120/255, blue: 240/255, alpha: 1)
    }

    public struct ArrowButton {
      public static var tintColor: UIColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1)
    }

    public struct FrameView {
      public static var fillColor: UIColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
      public static var borderColor: UIColor = UIColor(red: 97/255, green: 120/255, blue: 240/255, alpha: 1)
    }

    struct Dimension {
      static let columnCount: CGFloat = 3
      static let cellSpacing: CGFloat = 3
    }
  }

  public struct EmptyView {
    public static var image: UIImage? = Bundle.image("gallery_empty_view_image")
    public static var textColor: UIColor = UIColor(red: 102/255, green: 118/255, blue: 138/255, alpha: 1)
  }

  public struct Permission {
    public static var image: UIImage? = Bundle.image("gallery_permission_view_camera")
    public static var textColor: UIColor = UIColor(red: 102/255, green: 118/255, blue: 138/255, alpha: 1)

    public struct Button {
      public static var textColor: UIColor = UIColor.white
      public static var highlightedTextColor: UIColor = UIColor.lightGray
      public static var backgroundColor = UIColor(red: 40/255, green: 170/255, blue: 236/255, alpha: 1)
    }
  }

  public struct Font {

    public struct Main {
      public static var light: UIFont = UIFont.systemFont(ofSize: 1)
      public static var regular: UIFont = UIFont.systemFont(ofSize: 1)
      public static var bold: UIFont = UIFont.boldSystemFont(ofSize: 1)
      public static var medium: UIFont = UIFont.boldSystemFont(ofSize: 1)
    }

    public struct Text {
      public static var regular: UIFont = UIFont.systemFont(ofSize: 1)
      public static var bold: UIFont = UIFont.boldSystemFont(ofSize: 1)
      public static var semibold: UIFont = UIFont.boldSystemFont(ofSize: 1)
    }
  }

  public struct VideoEditor {

    public static var quality: String = AVAssetExportPresetHighestQuality
    public static var savesEditedVideoToLibrary: Bool = false
    public static var maximumDuration: TimeInterval = 15
    public static var portraitSize: CGSize = CGSize(width: 360, height: 640)
    public static var landscapeSize: CGSize = CGSize(width: 640, height: 360)
  }
}
