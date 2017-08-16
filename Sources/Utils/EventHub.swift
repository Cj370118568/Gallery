import Foundation

class EventHub {

  typealias Action = () -> Void

  static let shared = EventHub()
    
    
  // MARK: Initialization

  init() {}

  var close: Action?
  var doneWithImages: Action?
  var doneWithVideos: Action?
  var stackViewTouched: Action?
    
    //选择了icloud上的图片
    var imageError:Action?
    
    var didLoadCloud:Action?
    
    var didPickSinglePhoto:((UIImage) -> Void)?
    
    var didPickGif:((Data) -> Void)?
}
