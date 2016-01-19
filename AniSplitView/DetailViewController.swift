//
//  DetailViewController.swift
//  tempsvc1
//
//  Created by Eric Elfner on 2016-01-18.
//  Copyright © 2016 Eric Elfner. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, AnimatingSplitDetailViewController {

    var splitDelegate:AnimatingSplitViewControllerDelegate!
    
    @IBAction func hideShowMaster() {
        switch splitDelegate.splitState() {
        case .NarrowDetail : splitDelegate.showMaster()
        case .NarrowMaster : print("WTF - How are we in state NarrowMaster"); splitDelegate.showMaster()
        case .WideDetail : splitDelegate.showMaster()
        case .WideMasterDetail : splitDelegate.hideMaster()
        }
    }
}
