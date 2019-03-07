//
//  ExtraView.h
//  MojiFree
//
//  Created by karamvir singh on 24/01/14.
//  Copyright (c) 2014 karamvir singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface InfoView : UIViewController{
    AppDelegate *__appDelegate;
    float __x;
    float __y;
    float __w;
    float __h;
    float __padding;
}

- (void) addNavigationLeftButton;

@property (nonatomic, retain) UITextView *__textView;
- (void) addTextView;


@end