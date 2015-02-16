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
                if let features = NSJSONSerialization.JSONObjectWithData(data,
                    options: nil, error: nil) as? NSDictionary {

                    var shapeCoordinates: [CLLocationCoordinate2D] = []

                    for feature: NSDictionary in features["features"] as Array {
                        if let pointCoordinates = (feature["geometry"] as NSDictionary)["coordinates"] as? Array<Double> {
                            let annotation = MKPointAnnotation()
                            annotation.coordinate = CLLocationCoordinate2D(latitude: pointCoordinates[1],
                                longitude: pointCoordinates[0])
                            annotation.title = "Point \(map.annotations.count + 1)"
                            map.addAnnotation(annotation)

                            shapeCoordinates.append(annotation.coordinate)
                        }
                    }

                    let shape = MKPolygon(coordinates: &shapeCoordinates, count: shapeCoordinates.count)
                    map.addOverlay(shape)

                    map.showAnnotations(map.annotations, animated: false)
                }
            }
        }
    }

    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        if overlay.isKindOfClass(MKPolygon) {
            let renderer = MKPolygonRenderer(overlay: overlay)
            renderer.fillColor = UIColor.orangeColor().colorWithAlphaComponent(0.5)
            renderer.strokeColor = UIColor.blackColor()
            renderer.lineDashPattern = [2, 4]
            renderer.lineWidth = 2

            return renderer
        }

        return nil
    }

}
