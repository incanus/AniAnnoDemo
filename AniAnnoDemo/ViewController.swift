import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    var map: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()

        map = MKMapView(frame: view.bounds)
        map.delegate = self
        view.addSubview(map)

        if let path = NSBundle.mainBundle().pathForResource("features", ofType: "json") {
            if let data = NSData(contentsOfFile: path) {
                if let features = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as? NSDictionary {
                    for feature: NSDictionary in features["features"] as Array {
                        if let coordinates = (feature["geometry"] as NSDictionary)["coordinates"] as? Array<Double> {
                            let annotation = MKPointAnnotation()
                            annotation.coordinate = CLLocationCoordinate2D(latitude: coordinates[1], longitude: coordinates[0])
                            annotation.title = "Point \(map.annotations.count + 1)"
                            map.addAnnotation(annotation)
                        }
                    }
                    map.showAnnotations(map.annotations, animated: false)
                }
            }
        }
    }

}
