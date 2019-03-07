//
//  setTags.h
//  emijo
//
//  Created by karamvir singh on 06/01/14.
//  Copyright (c) 2014 60Degree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "TITokenField.h"
#import "savedMojis.h"

@interface setTags : UIViewController<TITokenFieldDelegate>{
    AppDelegate *__appDelegate;
}

@property (nonatomic, retain) NSString *content;
@property (nonatomic, retain) UITextView *tags;

@property (nonatomic, retain) 	TITokenFieldView * tokenFieldView;

- (void) addNavigationLeftButton;
- (void) addNavigationRightButton;

@end
