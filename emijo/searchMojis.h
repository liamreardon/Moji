//
//  searchMojis.h
//  emijo
//
//  Created by karamvir singh on 06/01/14.
//  Copyright (c) 2014 60Degree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "singleMoji.h"


@interface searchMojis : UIViewController<UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>{
    AppDelegate *__appDelegate;
    
    float __x;
    float __y;
    float __w;
    float __h;
    float __padding;
}

@property (nonatomic, retain) NSString *searchText;
@property (nonatomic, retain) UITableView *searchTable;
@property (nonatomic, retain) NSMutableDictionary *results;

@property (nonatomic, retain) UITextField *__textfieldTxt;

@property (nonatomic, retain) UIView *__searchViewHolder;

@property (nonatomic, retain) UIActivityIndicatorView *__loadingView;

- (void) addNavigationLeftButton;

- (void) addSearchBox;
- (void) addTableView;

@end
