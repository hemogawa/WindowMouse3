//
//  filterSetting.h
//  WindowMouse1
//
//  Created by 菊川 真理子 on 11/04/25.
//  Copyright 2011 北陸先端科学技術大学院大学. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class FilterView;
@class FilterWindow;
/* Delegateってプロトコル無いよって文句言われたから<NSWindowDelegate追加> */
@interface FilterSetting : NSObject<NSWindowDelegate> {
	NSWindow *_screen_window;
	FilterView *_screen_view;
	FilterWindow *filterWindow;
	IBOutlet NSSlider *spotSlider;
	IBOutlet NSButton *testButton;
	BOOL mouseSwitch;
}

-(void)windowEquipment;
-(void)stop;
+(void)setSize: (NSInteger)theSize;
-(void)setting;
-(IBAction)changeSpotSize: (id)sender;
+(NSInteger)size;
-(void)setting;
-(IBAction)pushButton:(id)sender;

@end
