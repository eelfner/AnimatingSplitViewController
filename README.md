* AnimatingSplitViewController

This project has 2 examples (Targets) of using the AnimationSplitViewController.

AniSplitView - Has constraints created in code. Not recommended, but kinda cool because it configures itself.
AniSplitViewSimple - The constraints must be set in IB and the IBOutlets set for the views and 3 primary constraints.

** AniSplit

Usage in IB:
 1) Add a view controller, set as a AnimatingSplitViewController.
 1) (Optional, but expected) Add plain UIView as a container if you want to contain the split view.
 1) Drag in 2 Container views.
 1) Have one implement AnimatingSplitMasterViewController (var splitDelegate:AnimatingSplitViewControllerDelegate!).
 1) Have one implement AnimatingSplitDetailViewController (var splitDelegate:AnimatingSplitViewControllerDelegate!).
 1) Code Master and Detail with calls to AnimatingSplitViewControllerDelegate as desired.

** AniSplitSimple

Rather than build constraints in code, this project has them set in IB. This is the way I intend to use this code.
The two key views (masterView and detailView) as well as the 3 Key Constraints are set as @IBOutlets. This removes
the need for the setupConstraints() method which is the most confusing and complex (and problematic?) part of this. 
Also, the hack(?) to find the masterView and detailView is avoided.

** Notes on UISplitViewController

 - Seems a bit strange
 - Does not follow size classes
 - requires UINavigationControllers
 - Hard to customize

Possible enhancements:
 - Add SplitState WideMaster, to enable a full screen master mode.
 - Custom transitions, or match UISplitViewController transitions.
 - Package in library. Well beyond scope of this work.
 - 
