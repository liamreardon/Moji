//
//  LikesView.h
//  emijo
//
//  Created by karamvir singh on 21/01/14.
//  Copyright (c) 2014 60Degree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "StarRatingView.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>
#import "singleMoji.h"

@interface LikesView : UIViewController<UITableViewDataSource, UITableViewDelegate>{
    AppDelegate *__appDelegate;
}

@property (nonatomic, retain) UITableView *likesTable;
@property (nonatomic, retain) NSMutableDictionary *likesArray;

@property (nonatomic, retain) UIActivityIndicatorView *__loadingView;

- (void) addNavigationLeftButton;

@end
