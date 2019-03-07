//
//  StickerSubCatView.h
//  emijo
//
//  Created by karamvir singh on 14/01/14.
//  Copyright (c) 2014 60Degree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "StickersView.h"

@interface StickerSubCatView : UIViewController <UITableViewDataSource, UITableViewDelegate>{
    
    AppDelegate *__appDelegate;
    
    float __x;
    float __y;
    float __w;
    float __h;
    float __padding;
}

@property (nonatomic, assign) int __catIndex;

- (void) addNavigationLeftButton;

@property (nonatomic, retain) UITableView *__tableView;
- (void) addTabelView;
@end
