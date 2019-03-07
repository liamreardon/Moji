//
//  savedMojis.h
//  emijo
//
//  Created by 60Degree on 12/3/13.
//  Copyright (c) 2013 60Degree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "addEmoji.h"
#import "browse.h"
#import <MessageUI/MessageUI.h>

@interface savedMojis : UIViewController<UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate>
{
     AppDelegate *__appDelegate;
}

@property (nonatomic, retain) NSMutableArray* mojisArray;
@property (nonatomic, retain) UITableView * mojiTable;
@property (nonatomic, retain) NSString *alertViewHiddenData;
@property (nonatomic, retain) NSString *alertViewHiddenId;

- (void) addNavigationLeftButton;

@end
