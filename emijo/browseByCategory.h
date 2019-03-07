//
//  browseByCategory.h
//  emijo
//
//  Created by 60Degree on 12/10/13.
//  Copyright (c) 2013 60Degree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface browseByCategory : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    AppDelegate *__appDelegate;
}

@property (nonatomic, retain) NSMutableDictionary *mojis;
@property (nonatomic, retain) UITableView *mojisTable;
@property (nonatomic, retain) NSString *pageTitle;

- (void) addNavigationLeftButton;

@end
