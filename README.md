* AnimatingSplitViewController

Usage in IB:
 1) Add a view controller, set as a AnimatingSplitViewController.
 1) (Optional, but expected) Add plain UIView as a container if you want to contain the split view.
 1) Drag in 2 Container views.
 1) Have one implement AnimatingSplitMasterViewController (var splitDelegate:AnimatingSplitViewControllerDelegate!).
 1) Have one implement AnimatingSplitDetailViewController (var splitDelegate:AnimatingSplitViewControllerDelegate!).
 1) Code Master and Detail with calls to AnimatingSplitViewControllerDelegate as desired.

** Simpler implementation

Rather than build constraints in code, build them in IB. The two key views (masterView and detailView) as well as the 
3 Key Constraints would be set as @IBOutlets. This would remove the need for the setupConstraints() method which is 
the most confusing and complex (and problematic?) part of this. Also, the hack(?) to find the masterView and detailView
would be avoided.

Possible enhancements:
 - Add SplitState WideMaster, to enable a full screen master mode.
 - Custom transitions, or match UISplitViewController transitions.
 - Package in library. Well beyond scope of this work.
 - 
