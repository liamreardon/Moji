//
//  singleMoji.h
//  emijo
//
//  Created by karamvir singh on 06/01/14.
//  Copyright (c) 2014 60Degree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "StarRatingView.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>

@interface singleMoji : UIViewController{
    AppDelegate *__appDelegate;
    
    float __x;
    float __y;
    float __w;
    float __h;
    float __padding;
}

@property (nonatomic, retain) NSString *emojiText;
@property (nonatomic, retain) NSString *emojiTitle;

@property (nonatomic, retain) UIScrollView *__holderSV;
@property(nonatomic, retain) UITextView *__textView;

- (void) addNavigationLeftButton;
- (void) addNavigationRightButton;

-(UIImage*) makeImage;



@end