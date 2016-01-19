//
//  ViewController.swift
//  tempsvc1
//
//  Created by Eric Elfner on 2016-01-17.
//  Copyright © 2016 Eric Elfner. All rights reserved.
//

import UIKit

// Key sizes
let kIpadSlideOverRight:CGFloat = 256
let kIphone5Width:CGFloat = 320
let kIphone6pWidth:CGFloat = 414
let kIphone4Height:CGFloat = 480
let kIpadSplitLandscapeWidth:CGFloat = 507
let kIphone5Height:CGFloat = 568
let kIphone6Height:CGFloat = 667

enum SplitState {
    case WideMasterDetail
    case WideDetail
    case NarrowMaster
    case NarrowDetail
    
    func splitable() -> Bool {
        return (self == .WideMasterDetail) || (self == .WideDetail)
    }
    func masterIsVisible() -> Bool {
        return (self == .WideMasterDetail) || (self == .NarrowMaster)
    }
}
protocol AnimatingSplitViewControllerDelegate {
    func showDetail()
    func showMaster()
    func hideMaster()
    func masterHasFocus() -> Bool
    func splitState() -> SplitState
}
protocol AnimatingSplitMasterViewController {
    var splitDelegate:AnimatingSplitViewControllerDelegate! {get set}
}
protocol AnimatingSplitDetailViewController {
    var splitDelegate:AnimatingSplitViewControllerDelegate! {get set}
}

class AnimatingSplitViewController: UIViewController {

    // Outlets to the views in the Container controls. Must be set in IB.
    @IBOutlet weak var masterView: UIView!
    @IBOutlet weak var detailView: UIView!
    
    // Controlling variables. Could make @IBInspectable for more generic control.
    private let splitOnWidth:CGFloat = kIphone4Height
    private let masterMinWidth:CGFloat = kIpadSlideOverRight // Recommended
    private let masterMaxWidth:CGFloat = kIphone5Width
    
    // Key Constraints for sizing. If constaints set in IB, these should be @IBOutlets
    @IBOutlet var leadingToMasterConstraint: NSLayoutConstraint!
    @IBOutlet var detailWidthConstraint: NSLayoutConstraint!
    @IBOutlet var masterWidthConstraint: NSLayoutConstraint!
    
    // State Variables
    private var _masterHasFocus = true
    private var _splitState:SplitState = .NarrowMaster
    private var lastFullWidth:CGFloat = 0.0
    
    var constraintsLoaded = false
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _masterHasFocus = true
        lastFullWidth = view.frame.width
        _splitState = .NarrowMaster
    }
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        if !constraintsLoaded {
            updateViewForWidth(view.frame.width) // Must call because no viewWillTransitionToSize: on startup
        }
    }
    // Update on rotations and other size changes like slideover.
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator)
    {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator);
        
        updateViewForWidth(size.width)
    }

    private func updateViewForWidth(width:CGFloat) {
        lastFullWidth = width
        let bIsWide = (lastFullWidth >= splitOnWidth) // Different than size classes
        let bWasWide = _splitState.splitable()
        var newState = _splitState
        
        if bIsWide {
            if bWasWide { // Wide -> Wide
                // No change stay either: .WideMasterDetail : .WideDetail
            }
            else { // Narrow -> Wide
                newState = _masterHasFocus ? .WideMasterDetail : .WideDetail
            }
        }
        else { // -> Narrow
            newState = _masterHasFocus ? .NarrowMaster : .NarrowDetail
        }
        constrainViewForState(newState)
    }
    private func constrainViewForState(state:SplitState) {
        let splitMasterWidth = max(masterMinWidth, min(masterMaxWidth, lastFullWidth / 2.0))
        var masterWidth = CGFloat(0)
        var detailWidth = CGFloat(0)
        var masterOffset = CGFloat(0)
        switch state {
        case .NarrowDetail :
            masterWidth = lastFullWidth
            detailWidth = lastFullWidth
            masterOffset = -lastFullWidth
        case .NarrowMaster :
            masterWidth = lastFullWidth
            detailWidth = lastFullWidth
            masterOffset = CGFloat(0)
        case .WideDetail :
            masterWidth = splitMasterWidth
            detailWidth = lastFullWidth
            masterOffset = -splitMasterWidth
        case .WideMasterDetail :
            masterWidth = splitMasterWidth
            detailWidth = lastFullWidth - splitMasterWidth
            masterOffset = CGFloat(0)
        }
        _splitState = state
        UIView.animateWithDuration(0.5) {
            self.view.layoutIfNeeded()
            self.masterWidthConstraint.constant = CGFloat(masterWidth)
            self.detailWidthConstraint.constant = CGFloat(detailWidth)
            self.leadingToMasterConstraint.constant = CGFloat(masterOffset)
            self.view.layoutIfNeeded()
        }
    }
    
    // Mark: - Segue. 
    // By adding Container controls to a view in IB, you will get prepareForSegue on init and
    // we will wire up delegates to this AnimatingSplitViewController to enable callbacks.
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if var master = segue.destinationViewController as? AnimatingSplitMasterViewController {
            master.splitDelegate = self as AnimatingSplitViewControllerDelegate
        }
        else if var detail = segue.destinationViewController as? AnimatingSplitDetailViewController {
            detail.splitDelegate = self as AnimatingSplitViewControllerDelegate
        }
        else {
            print("Warning: AnimatingSplitViewController found embedded segue that did not conform to AnimatingSplit<Master/Detail>ViewController protocol. Reference not set: \(segue.destinationViewController)")
        }
    }
}
extension AnimatingSplitViewController : AnimatingSplitViewControllerDelegate {
    func showDetail() {
        _masterHasFocus = false
        let bWasSplitable = _splitState.splitable()
        let newState:SplitState = bWasSplitable ? .WideMasterDetail : .NarrowDetail
        constrainViewForState(newState)
    }
    func showMaster() {
        _masterHasFocus = true
        let newState:SplitState = _splitState.splitable() ? .WideMasterDetail : .NarrowMaster
        constrainViewForState(newState)
    }
    func hideMaster() {
        _masterHasFocus = false
        let newState:SplitState = _splitState.splitable() ? .WideDetail : .NarrowDetail
        constrainViewForState(newState)
    }
    func masterHasFocus() -> Bool {
        return _masterHasFocus
    }
    func splitState() -> SplitState {
        return _splitState
    }
}
