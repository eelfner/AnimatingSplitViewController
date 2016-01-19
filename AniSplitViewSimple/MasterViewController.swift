//
//  MasterViewController.swift
//  tempsvc1
//
//  Created by Eric Elfner on 2016-01-17.
//  Copyright © 2016 Eric Elfner. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController, AnimatingSplitMasterViewController {

    var splitDelegate:AnimatingSplitViewControllerDelegate!
    
    @IBAction func showDetailAction(sender: AnyObject) {
        splitDelegate.showDetail()
    }
}
