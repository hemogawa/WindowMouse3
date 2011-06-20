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

#define MODE_SPOT 0
#define MODE_LINE 1

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
	_spot_mode = MODE_LINE;
	return self;
}
/* NSViewにdeallocって関数があって、それを実行するための関数らしい... */
-(void)dealloc{
	[super dealloc];
}

/* drawRectって関数に書いてある描画処理が読み込まれる */
-(void)drawRect: (NSRect)rect{
	NSRect frame =[self frame];
	//CGContextRef context = NSCurrentGraphicsPort();
	[[NSColor colorWithDeviceRed:0.0 green:0.0 blue:0.0 alpha:0.5] set];
	//CGRect frameCG = *(CGRect *)&frame;
	//CGContextSetRGBFillColor(context, 0.0, 0.0, 0.0, 0.5);
	/*
	 void NSRectFill(NSRect rect) {
		CGContextRef context=NSCurrentGraphicsPort(); //コンテキスト取得
		CGContextSaveGState(context);	//直前のグラフィックの状態を保存
		CGContextSetBlendMode(context,kCGBlendModeCopy);	//四角形が上書きされてる仕組みとみた
		CGContextFillRect(NSCurrentGraphicsPort(),rect);
		CGContextRestoreGState(context);
	 }
	 */
	NSRectFill([self frame]);
	//CGContextFillRect(context, frameCG);
	[[NSColor colorWithDeviceRed:0.0 green:0.0 blue:0.0 alpha:0.0] set];
	NSRectFill(_spot_rect);
	//CGContextSetRGBFillColor(context, 1.0, 0.0, 0.0, 0.5);
	//[[NSBezierPath bezierPathWithOvalInRect:_spot_rect] fill];
	//CGRect spotCG = *(CGRect *)&_spot_rect;
	//CGContextAddRect(context, spotCG);
	//CGContextEOFillPath(context);
}

-(void)setSetting:(FilterSetting *)setting{
	_setting = setting;
}

-(void)mouseMoved:(NSEvent *)theEvent{
	//NSLog(@"move");
	NSPoint eventLocation = [theEvent locationInWindow];
	_spot_loc = [self convertPoint:eventLocation fromView:nil];
	[self makeSpot];
}

-(void)makeSpot{
	_spot_size = (CGFloat)[FilterSetting size];
	//NSLog(@"make!%f!%f",_spot_size,(float)_spot_loc.x);
	if(_spot_mode == MODE_SPOT){
		_spot_rect.origin.x = _spot_loc.x - _spot_size;
		_spot_rect.origin.y = _spot_loc.y - _spot_size;
		_spot_rect.size.width = _spot_size * 2;
		_spot_rect.size.height = _spot_size * 2;
	}
	if(_spot_mode == MODE_LINE){
		_spot_rect.origin.x = 0;
		_spot_rect.origin.y = _spot_loc.y - _spot_size;
		_spot_rect.size.width = [self frame].size.width;
		_spot_rect.size.height = _spot_size * 2;
	}
	//_spot_rect = NSMakeRect(_spot_loc.x-_spot_size/2, _spot_loc.y-_spot_size/2, _spot_size, _spot_size);
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

-(BOOL)acceptsFirstMouse:(NSEvent *)theEvent{
	return YES;
}

@end
