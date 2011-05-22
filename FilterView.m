//
//  filterView.m
//  WindowMouse1
//
//  Created by 菊川 真理子 on 11/04/25.
//  Copyright 2011 北陸先端科学技術大学院大学. All rights reserved.
//

#import "FilterView.h"
#import "FilterSetting.h"
#import "FilterWindow.h"


@implementation FilterView
-(id)initWithFrame:(NSRect)frameRect{
	self = [super initWithFrame:frameRect];
	if (self) {
		//initialization
		_tracking_area = [[NSTrackingArea alloc] initWithRect:frameRect
													  options:(NSTrackingMouseMoved | NSTrackingActiveAlways)
														owner:self
													 userInfo:nil];
		[self addTrackingArea:_tracking_area];
	}
	_spot_size = 300;
	_spot_loc.x=10; _spot_loc.y=10;
	_setting = [[FilterSetting alloc]init];
	return self;
}
/* NSViewにdeallocって関数があって、それを実行するための関数らしい... */
-(void)dealloc{
	[super dealloc];
}

/* drawRectって関数に書いてある描画処理が読み込まれる */
-(void)drawRect: (NSRect)rect{
	[[NSColor colorWithDeviceRed:0.0 green:0.0 blue:0.0 alpha:0.5] set];
	NSRectFill([self frame]);
	[[NSColor colorWithDeviceRed:0.0 green:0.0 blue:0.0 alpha:0.0] set];
	NSRectFill(_spot_rect);
}

-(void)setSetting:(FilterSetting *)setting{
	_setting = setting;
}

-(void)mouseDown:(NSEvent *)theEvent{
	NSLog(@"mouseDown");
	[filterWindow setLevel:NSNormalWindowLevel - 1];
[self setNeedsDisplay:YES];
}
-(void)mouseUp:(NSEvent *)theEvent{
	//[_setting stop];
	//_spot_size -=10;
	//[self makeSpot];
	//[_setting setMouseSwitch:YES];
	//[_setting windowEquipment];
	NSLog(@"mouseup");
}

-(void)mouseMoved:(NSEvent *)theEvent{
	//NSLog(@"move");
	NSPoint eventLocation = [theEvent locationInWindow];
	_spot_loc = [self convertPoint:eventLocation fromView:nil];
	[self makeSpot];
}

-(void)makeSpot{
	_spot_size = [FilterSetting size];
	//NSLog(@"make!%d!%f",_spot_size,(float)_spot_loc.x);
	_spot_rect = NSMakeRect(_spot_loc.x-_spot_size/2, _spot_loc.y-_spot_size/2, _spot_size, _spot_size);
	[self setNeedsDisplay:YES];	//再描画	
}

/*
 メニュー選択は受け取るし，メニューに応じた値の変更もする
 makeSpotの呼出もできるが，何故か_spot_rectを実行しようとしない*/
 -(IBAction)change_spot_size:(id)sender{
	NSInteger changeTag;
	if([sender isKindOfClass:[NSSegmentedControl class]]){
		changeTag = [sender selectedSegment];
	}else{
		changeTag = [sender tag];
	}
	switch (changeTag) {
		case 0:
			_spot_size +=10;
			break;
		case 1:
			_spot_size -=10;
			break;
		default:
			break;
	}
	[self makeSpot];
}

-(void)setSize:(NSInteger)newSize{
	_spot_size = newSize;
	[self makeSpot];
}

@end
