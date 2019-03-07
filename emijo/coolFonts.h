//
//  coolFonts.h
//  emijo
//
//  Created by karamvir singh on 06/01/14.
//  Copyright (c) 2014 60Degree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "Extensions.h"


@interface coolFonts : UIViewController<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, MFMailComposeViewControllerDelegate>{
    AppDelegate *__appDelegate;
    float __x;
    float __y;
    float __w;
    float __h;
    float __padding;
}

@property (nonatomic, retain) UITableView *fontsTable;
@property (nonatomic, retain) NSArray *__fontsArr;
@property (nonatomic, retain) UITextView *coolFontText;
@property (nonatomic, retain) UIBarButtonItem *sendButton;

@property (nonatomic, retain) UIButton *keyboardBtn;
@property (nonatomic, retain) UIButton *fontBtn;
@property (nonatomic, retain)  UIColor *textColor;

@property (nonatomic, retain) UIView *toolBar;

@property (nonatomic, retain) NSString *__font;

- (void) addNavigationLeftButton;
- (void) addNavigationRightButton;

@property (nonatomic, retain) NSString *__selectedFontName;

-(UIImage*) makeImage;


@end

