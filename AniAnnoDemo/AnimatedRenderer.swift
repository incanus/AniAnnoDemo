import MapKit

class AnimatedRenderer: MKPolygonRenderer {

    var image: UIImage!
    var timer: NSTimer!
    var size: CGFloat!

    override init(polygon: MKPolygon) {
        super.init(polygon: polygon)

        image = UIImage(named: "mapbox.png")
        size = image.size.width

        fillColor = UIColor(patternImage: image)
        strokeColor = UIColor.blackColor()
        lineDashPattern = [2, 4]
        lineWidth = 2
        alpha = 0.25

        timer = NSTimer.scheduledTimerWithTimeInterval(5.0,
            target: self,
            selector: "fireTimer:",
            userInfo: nil,
            repeats: true)
    }

    func fireTimer(timer: NSTimer) {
        if (size > 10 * self.image.size.width) {
            size = self.image.size.width
        }
        let rect = CGRect(x: 0,
            y: 0,
            width:  size * 1.1,
            height: size * 1.1)
        UIGraphicsBeginImageContext(rect.size)
        image.drawInRect(rect)
        fillColor = UIColor(patternImage: UIGraphicsGetImageFromCurrentImageContext())
        UIGraphicsEndImageContext()
        size = rect.size.width
    }

}
