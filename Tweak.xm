/*
 *    This source code is licensed under the BSD-style license found in the
 *    LICENSE file in the root directory of this source tree.
 *
 *    ULSPOTLIGT iOS
 *	  iOS13
 */


@interface SBRootFolderView : UIView
-(UIView *)todayView;
@end

@interface SpringBoard : NSObject {}
-(void)_simulateLockButtonPress;
@end

@interface SBMainSwitcherViewController
+(id)sharedInstance;
-(BOOL)toggleMainSwitcherNoninteractivelyWithSource:(long long)arg1 animated:(BOOL)arg2;
@end

@interface SBBarSwipeAffordanceView : UIView
@end

@interface WGWidgetWrapperView : UIView
@end

@interface WGWidgetListFooterView : UIView
@end


/**** Disable Spotlight Top UIView ****/

%hook SPUINavigationBar

-(id)initWithFrame:(CGRect)arg1{
	
	//NSLog(@"ULSPOTLIGT 1:%@", %orig());
	return nil; 
}

%end


/**** Disable Spotlight Left Side ****/

%hook SBMainDisplayPolicyAggregator

-(BOOL)_allowsCapabilityTodayViewWithExplanation:(id*)arg1 {

	NSLog(@"ULSPOTLIGT 2:%d", %orig());
    return 0;
}

%end


%hook SBRootFolderView

-(unsigned long long)_leadingCustomPageCount{

	NSLog(@"ULSPOTLIGT 3:%llu", %orig());
	return 0;
}

-(void)_layoutSubviewsForTodayViewWithMetrics:(id*)arg1{

	NSLog(@"ULSPOTLIGT 4");
	[self todayView].hidden = 1;
    %orig;
}

-(BOOL)isTodayViewPageHidden{
	
	NSLog(@"ULSPOTLIGT 5:%d", %orig());
	return 1; 
}

%end


%hook SBSearchGesture

-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(CGPoint *)targetContentOffset{


	//NSLog(@"ULSPOTLIGT 6-1:%f", targetContentOffset->x); 
	//NSLog(@"ULSPOTLIGT 6-2:%f", targetContentOffset->y); 
	//pull down 0,0, pull down and up 0,94

	/**** Lock Device ****/
	if (targetContentOffset->y == 0){

		//NSLog(@"ULSPOTLIGT 6-3");
		[(SpringBoard *)[UIApplication sharedApplication] _simulateLockButtonPress];
	}


	/**** Launch App Switcher ****/
	if (targetContentOffset->y == 94){

		//NSLog(@"ULSPOTLIGT 6-4");
		[[%c(SBMainSwitcherViewController) sharedInstance] toggleMainSwitcherNoninteractivelyWithSource:1 animated:1];
	}

	%orig();
}

%end