import UIKit
import Photos
import MobileCoreServices

struct Fetcher {
<<<<<<< HEAD

  // TODO: Why not use screen size?
  static func fetchImages(_ assets: [PHAsset], size: CGSize = CGSize(width: 720, height: 1280)) -> [UIImage] {
    let options = PHImageRequestOptions()
    options.isSynchronous = true

    var images = [UIImage]()
    for asset in assets {
      PHImageManager.default().requestImage(for: asset, targetSize: size, contentMode: .aspectFill, options: options) { image, _ in
        if let image = image {
          images.append(image)
        }
      }
    }

    return images
  }
    
    static func fetchGif(asset:PHAsset) -> Data? {
        let requestOptions = PHImageRequestOptions()
        var data:Data? = nil
        requestOptions.isSynchronous = true
        PHImageManager.default().requestImageData(for: asset, options: requestOptions, resultHandler: { (imageData, UTI, _, _) in
            if let uti = UTI,let data1 = imageData ,
                // you can also use UTI to make sure it's a gif
                UTTypeConformsTo(uti as CFString, kUTTypeGIF) {
                // save data here
                data = data1
            }
        })
        return data
    }
    
=======
>>>>>>> hyperoslo/master
  static func fetchAsset(_ localIdentifer: String) -> PHAsset? {
    return PHAsset.fetchAssets(withLocalIdentifiers: [localIdentifer], options: nil).firstObject
  }
}
