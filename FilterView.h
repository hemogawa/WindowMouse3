//
//  filterView.h
//  WindowMouse1
//
//  Created by 菊川 真理子 on 11/04/25.
//  Copyright 2011 北陸先端科学技術大学院大学. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class FilterSetting;
@class FilterWindow;
@interface FilterView : NSView {
	FilterSetting *_setting;
	FilterWindow *filterWindow;
	NSTrackingArea *_tracking_area;
	NSRect _spot_rect;
	CGFloat _spot_size;
	NSPoint _spot_loc;
	BOOL _spot_mode;
}

-(void)setSetting:(FilterSetting*)setting;
-(IBAction)change_spot_size:(id)sender;
-(void)makeSpot;
-(void)setSize:(NSInteger)newSize;

@end
