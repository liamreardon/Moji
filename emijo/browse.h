//
//  browse.h
//  emijo
//
//  Created by 60Degree on 12/6/13.
//  Copyright (c) 2013 60Degree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "topCharts.h"
#import "setTags.h"
#import "searchMojis.h"

@interface browse : UIViewController<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
{
    AppDelegate *__appDelegate;
    
    float __x;
    float __y;
    float __w;
    float __h;
    float __padding;
}

@property (nonatomic, retain) UITableView *categoriesTable;
@property (nonatomic, retain) NSMutableArray *categories;
@property (nonatomic, retain) UITextField *__textfieldTxt;

@property (nonatomic, retain) UIView *__searchViewHolder;


//. Select Category when submit to app
@property (nonatomic) BOOL selectCat;
@property (nonatomic, retain) NSString *postUrl;

- (void) addNavigationLeftButton;

- (void) addSearchBox;
- (void) addTableView;


@end
