//
//  FullImageViewController.swift
//  Photo Map
//
//  Created by Michael Wornow on 7/6/17.
//  Copyright © 2017 Michael Wornow. All rights reserved.
//

import UIKit

class FullImageViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var photoScrollView: UIScrollView!
    @IBOutlet weak var photoImageView: UIImageView!
    var photo: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        photoScrollView.delegate = self
        photoImageView.image = photo
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // This method is called as the user scrolls
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        // This method is called right as the user lifts their finger
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // This method is called when the scrollview finally stops scrolling.
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return photoImageView
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
