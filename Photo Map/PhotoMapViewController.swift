//
//  PhotoMapViewController.swift
//  Photo Map
//
//  Created by Michael Wornow on 7/6/17.
//  Copyright © 2017 Michael Wornow. All rights reserved.
//

import UIKit
import MapKit

class PhotoMapViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, LocationsViewControllerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var cameraButton: UIButton!
    
    var imageTaken: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //one degree of latitude is approximately 111 kilometers (69 miles) at all times.
        let sfRegion = MKCoordinateRegionMake(CLLocationCoordinate2DMake(37.783333, -122.416667),
                                              MKCoordinateSpanMake(0.1, 0.1))
        mapView.setRegion(sfRegion, animated: false)
        mapView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func cameraButtonTouch(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is available 📸")
            vc.sourceType = .camera
        } else {
            print("Camera 🚫 available so we will use photo library instead")
            vc.sourceType = .photoLibrary
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        // Do something with the images (based on your use case)
        imageTaken = editedImage
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true) { 
            self.performSegue(withIdentifier: "tagSegue", sender: self)
        }
    }
    
    func locationsPickedLocation(controller: LocationsViewController, latitude: NSNumber, longitude: NSNumber) {
        let locationCoordinate = CLLocationCoordinate2D(latitude: latitude as! CLLocationDegrees, longitude: longitude as! CLLocationDegrees)
        let annotation = PhotoAnnotation()
        annotation.coordinate = locationCoordinate
        
        let resizeRenderImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
        resizeRenderImageView.layer.borderColor = UIColor.white.cgColor
        resizeRenderImageView.layer.borderWidth = 3.0
        resizeRenderImageView.contentMode = UIViewContentMode.scaleAspectFill
        resizeRenderImageView.image = imageTaken
        
        UIGraphicsBeginImageContext(resizeRenderImageView.frame.size)
        resizeRenderImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let thumbnail = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        annotation.thumbnail = thumbnail
        annotation.photo = imageTaken
        
        mapView.addAnnotation(annotation)
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let detailButton: UIButton = UIButton(type: UIButtonType.detailDisclosure)

        let reuseID = "myAnnotationView"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseID)
        if (annotationView == nil) {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseID)
            annotationView!.canShowCallout = true
        }
        
        annotationView!.rightCalloutAccessoryView = detailButton
        annotationView!.leftCalloutAccessoryView = UIImageView(frame: CGRect(x:0, y:0, width: 50, height:50))
        let imageView = annotationView!.leftCalloutAccessoryView as! UIImageView
        imageView.image = (annotation as! PhotoAnnotation).thumbnail
        annotationView!.image = (annotation as! PhotoAnnotation).thumbnail
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        performSegue(withIdentifier: "fullImageSegue", sender: view)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "tagSegue") {
            let vc = segue.destination as! LocationsViewController
            vc.delegate = self
        }
        else if (segue.identifier == "fullImageSegue") {
            let annotationView = sender as! MKAnnotationView
            let vc = segue.destination as! FullImageViewController
            vc.photo = (annotationView.annotation as! PhotoAnnotation).photo
        }
    }
    

}
