import MapKit

class PointAnnotationView: MKAnnotationView {

    var timer: NSTimer!

    override init(annotation: MKAnnotation, reuseIdentifier: String) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)

        layer.borderColor = UIColor.blackColor().CGColor
        layer.borderWidth = 1
        backgroundColor = UIColor.redColor()
        alpha = 0.9

        frame = CGRect(x: 0, y: 0, width: 30, height: 30)

        let rotation = CGAffineTransformRotate(transform, 3.14159 / 2.0)

        UIView.animateWithDuration(1.0,
            delay: 1.0,
            options: .BeginFromCurrentState | .Repeat | .CurveLinear | .AllowUserInteraction,
            animations: { [unowned self] in
                self.transform = rotation
            },
            completion: nil)

        timer = NSTimer.scheduledTimerWithTimeInterval(1.5,
            target: self,
            selector: "fireTimer:",
            userInfo: nil,
            repeats: true)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func fireTimer(timer: NSTimer) {
        UIView.animateWithDuration(0.75,
            delay: 0.0,
            options: .BeginFromCurrentState | .CurveEaseInOut,
            animations: { [unowned self] in
                if (self.backgroundColor == UIColor.redColor()) {
                    self.backgroundColor = UIColor.greenColor()
                } else if (self.backgroundColor == UIColor.greenColor()) {
                    self.backgroundColor = UIColor.blueColor()
                } else {
                    self.backgroundColor = UIColor.redColor()
                }

                if (self.alpha > 0.1) {
                    self.alpha -= 0.1
                } else {
                    self.alpha = 0.9
                }

                if (self.layer.borderWidth < 8) {
                    self.layer.borderWidth += 1
                } else {
                    self.layer.borderWidth = 1
                }
            },
            completion: nil)
    }

}
