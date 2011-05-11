//
//  main.m
//  MouseCap
//
//  Created by 菊川 真理子 on 11/01/26.
//  Copyright 2011 北陸先端科学技術大学院大学. All rights reserved.
//

#import <Cocoa/Cocoa.h>


void getActiveApplication(){
	NSWorkspace* workspace = [NSWorkspace sharedWorkspace];	//共有ワークスペースを作成
	NSDictionary* activeApp = [workspace activeApplication];	//アクティブなアプリケーションを取得
	//NSLog([activeApp description]);
	
}

int main(int argc, char *argv[])
{
    return NSApplicationMain(argc,  (const char **) argv);
}
