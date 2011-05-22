//
//  filterSetting.m
//  WindowMouse1
//
//  Created by 菊川 真理子 on 11/04/25.
//  Copyright 2011 北陸先端科学技術大学院大学. All rights reserved.
//

#import "FilterSetting.h"
#import "FilterView.h"
#import "FilterWindow.h"


@implementation FilterSetting
-(void)applicationDidFinishLaunching:(NSNotification *)aNotification{
	//[self setting];
	NSLog(@"lanched");
	mouseSwitch = YES;
	[spotSlider setMinValue:0];
	[spotSlider setMaxValue:600];
	[spotSlider setNumberOfTickMarks:4];
	[self windowEquipment];
}

-(void)windowEquipment{
	NSLog(@"window:%@",filterWindow);
	if(filterWindow != nil){
		[filterWindow close];
	}
	NSScreen *main_screen = [NSScreen mainScreen];
	NSRect screenRec = [main_screen frame];
	filterWindow = [[FilterWindow alloc] initWithContentRect:screenRec
												 styleMask:NSBorderlessWindowMask /*& NSNonactivatingPanelMask*/
												   backing:NSBackingStoreBuffered
													 defer:NO
													/*screen:main_screen*/];
	//[filterWindow release];
	[filterWindow setReleasedWhenClosed:NO];	//ウィンドウを閉じた時にメモリを解放
	//[filterWindow setDisplaysWhenScreenProfileChanges:YES];	//スクリーンプロファイルがアップデートされたときウィンドウの内容を更新する
	[filterWindow setDelegate:self];	//Filtersettingに処理を移譲
	//[filterWindow setBackgroundColor:[NSColor clearColor]];
	[filterWindow setOpaque:NO];	//タイトル部分透明
	//NSLog(@"Opaque->"); ([filterWindow isOpaque])?NSLog(@"YES"):NSLog(@"NO");
	[filterWindow setHasShadow:YES];	//影無し
	
	//NSPoint mousePoint;
	//mousePoint = [filterWindow mouseLocationOutsideOfEventStream];
	[filterWindow setIgnoresMouseEvents:YES];	//マウスイベントをうけとらない
	//NSLog(@"ignoresMouseEvents->"); ([filterWindow ignoresMouseEvents])?NSLog(@"YES"):NSLog(@"NO");
	[filterWindow setAcceptsMouseMovedEvents:YES];	//マウスムーブイベントを受け取る
	NSLog(@"acceptsMouseMovedEvents->"); ([filterWindow acceptsMouseMovedEvents])?NSLog(@"YES"):NSLog(@"NO");
	_screen_view = [[[FilterView alloc] initWithFrame:screenRec] autorelease];	//ビューを初期化
	[filterWindow setContentView:_screen_view];	//ビューの中身をウィンドウにセット
	[filterWindow orderFront:self];	//キー・メインウィンドウはそのままでウィンドウを全面に出す
	[filterWindow setLevel:NSScreenSaverWindowLevel - 1];	//ウィンドウをスクリーンセーバーより1つ後ろにする
	//[_screen_view setNeedsDisplay:YES];	//再描画
	[_screen_view setSetting:self];	//viewクラスとsettingクラスを連結？
	
}

/* 各設定の初期値・前回の値を反映 */
-(void)setting{
	Class theClass = [self class];
	[spotSlider setIntegerValue: [theClass size]];
}
-(void)stop{
	[NSApp terminate:self];
}

+(void)setSize: (NSInteger)theSize{
	[[NSUserDefaults standardUserDefaults] setInteger:theSize forKey:@"Size"];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSInteger)size{
	id theSettingsObject = [[NSUserDefaults standardUserDefaults] objectForKey:@"Size"];
	if (theSettingsObject) {
		return [theSettingsObject intValue];
	}
	return 10;
}

-(IBAction)changeSpotSize: (id)sender{
	[[self class] setSize:[sender integerValue]];
	NSLog(@"change");
	[self windowEquipment];
}
-(IBAction)pushButton:(id)sender{
	[self windowEquipment];
	NSLog(@"pushed");
}

@end
