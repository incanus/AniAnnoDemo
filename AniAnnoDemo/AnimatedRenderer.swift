import MapKit

class AnimatedRenderer: MKPolygonRenderer {

    var imageA: UIImage!
    var imageB: UIImage!
    var timer: NSTimer!
    var flipped: Bool!

    override init(polygon: MKPolygon) {
        super.init(polygon: polygon)

        imageA = {
            UIGraphicsBeginImageContext(CGSize(width: 256, height: 256))
            let c = UIGraphicsGetCurrentContext()
            CGContextSetFillColorWithColor(c, UIColor.redColor().CGColor)
            CGContextFillRect(c, CGRect(x: 0, y: 0, width: 128, height: 256))
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return image
            }()
        imageB = {
            UIGraphicsBeginImageContext(CGSize(width: 256, height: 256))
            let c = UIGraphicsGetCurrentContext()
            CGContextSetFillColorWithColor(c, UIColor.redColor().CGColor)
            CGContextFillRect(c, CGRect(x: 128, y: 0, width: 128, height: 256))
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return image
            }()

        fillColor = UIColor(patternImage: imageA)
        strokeColor = UIColor.blackColor()
        lineDashPattern = [2, 4]
        lineWidth = 2
        alpha = 0.25

        flipped = false

        timer = NSTimer.scheduledTimerWithTimeInterval(0.25,
            target: self,
            selector: "fireTimer:",
            userInfo: nil,
            repeats: true)
    }

    func fireTimer(timer: NSTimer) {
        if (flipped!) {
            fillColor = UIColor(patternImage: imageA)
            flipped = false
        } else {
            fillColor = UIColor(patternImage: imageB)
            flipped = true
        }
    }

}
