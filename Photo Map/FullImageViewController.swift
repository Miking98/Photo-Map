//
//  FullImageViewController.swift
//  Photo Map
//
//  Created by Michael Wornow on 7/6/17.
//  Copyright © 2017 Michael Wornow. All rights reserved.
//

import UIKit

class FullImageViewController: UIViewController {
    
    @IBOutlet weak var photoImageView: UIImageView!
    var photo: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        photoImageView.image = photo
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
