## AnimatingSplitViewController

This project has 2 examples (Targets/Apps) of using the AnimationSplitViewController. This is more of
a demonstration of a concept than a widget to plug in to an App.
![Split Examples](./Split3Ex.png)

*Note:* This project only contains the UI manipulations. The data flow is left a job for you. In my App
implementation the data flow ended up pretty clean. Did need to a capture references to the detail
viewcontroller in the AnimatingSplitViewController. Then in storyboard added push detail segue between
master and detail. In code, I implemented shouldPerformSegueWithIdentifier() to pass data to detail view
controller and set the correct display by calling splitDelegate.showDetail(). Note that this method then
returns false. Otherwise, the UIKit framework will create an new instance of the DetailViewController, but
we never need that because we always have one available. This is also why this is done in 
shouldPerformSegueWithIdentifier() instead of prepareForSegue() where the view controller is already created.

 - AniSplitView - Has constraints created in code. Not recommended, but kinda cool because it configures itself.
 - AniSplitViewSimple - The constraints must be set in IB and the IBOutlets set for the views and 3 primary constraints.

This exploration was motivated when I ran into difficulty customizing a UISplitViewController and realize that
it is not very flexible and might not be the correct choice if you do not like the default behavior. Key features I wanted include:

 - Split available on all iPhones in Landscape.
 - No UINavigationController header for detail.
 - Split without overlay on iPad.
 - Play nicely with iOS9 iPad SlideOver and SplitView.

A movie best demonstrates some of these features:
![Example Movie](./SplitViewDemo.mp4)

### AniSplitViewSimple
Rather than build constraints in code, this project has them set in IB. This is the way I intend to use this code.
The two key views (masterView and detailView) as well as the 3 Key Constraints are set as @IBOutlets. This removes
the need for the setupConstraints() method which is the most confusing and complex (and problematic?) part of this. 
Also, the hack(?) to find the masterView and detailView is avoided.

![Split States](./SplitState.png)

### Notes on UISplitViewController

 - Seems a bit strange
 - Does not follow size classes
 - Requires UINavigationControllers
 - Semi custom Push Detail Segue
 - Hard to customize

## AniSplitView

Please note that I decided to NOT persue this implementation although it is pretty neat in that the
wiring up IB is pretty easy and all the constraint work is done in code. But that was turning out to
be more complicated than I wanted to deal with.

Usage in IB:
1. Add a view controller, set as a AnimatingSplitViewController.
2. (Optional, but expected) Add plain UIView as a container if you want to contain the split view.
3. Drag in 2 Container views.
4. Have one implement AnimatingSplitMasterViewController (var splitDelegate:AnimatingSplitViewControllerDelegate!).
5. Have one implement AnimatingSplitDetailViewController (var splitDelegate:AnimatingSplitViewControllerDelegate!).
6. Code Master and Detail with calls to AnimatingSplitViewControllerDelegate as desired.

Possible enhancements:
 - Add SplitState WideMaster, to enable a full screen master mode.
 - Custom transitions, or match UISplitViewController transitions.
 - Package in library. Well beyond scope of this work.
