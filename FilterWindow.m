//
//  FilterWindow.m
//  WindowMouse3
//
//  Created by 菊川 真理子 on 11/05/10.
//  Copyright 2011 北陸先端科学技術大学院大学. All rights reserved.
//

#import "FilterWindow.h"
#import "FilterSetting.h"
#import "FilterView.h"


@implementation FilterWindow
-(NSWindowCollectionBehavior)collectionBehavior{
	/* 
	 NSWindowCollectionBehaviorMoveToActiveSpace-
		アプリケーションをアクティブにしたときSpaceを切り替えずにアクティブなスペースに移動する
	 NSWindowCollectionBehaviorStationary-
		Spaces,Expose両方でデスクトップのようにふるまう
	 */
	return NSWindowCollectionBehaviorMoveToActiveSpace | NSWindowCollectionBehaviorStationary | NSWindowCollectionBehaviorIgnoresCycle;
}

/* キーウィンドウにならない */
-(BOOL)canBecomeKeyWindow{
	return NO;
}

/* メインウィンドウにならない */
-(BOOL)canBecomeMainWindow{
	return NO;
}

/* ウィンドウはマウスウィンドウを無視する */
-(BOOL)ignoresMouseEvents{
	return YES;
}

@end
