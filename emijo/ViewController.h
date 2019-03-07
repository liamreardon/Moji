//
//  ViewController.h
//  emijo
//
//  Created by 60Degree on 11/28/13.
//  Copyright (c) 2013 60Degree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "addEmoji.h"
#import "savedMojis.h"
#import "browse.h"
#import "topCharts.h"
#import "submitToApp.h"
#import "UserProfile.h"
#import "StickerCategoriesView.h"

#import "UserRegisterView.h"
#import "LoginView.h"

@interface ViewController : UIViewController<NSURLConnectionDelegate>
{
    AppDelegate *__appDelegate;
    float __x;
    float __y;
    float __w;
    float __h;
    float __padding;
}


@property (nonatomic, retain) UIActivityIndicatorView *activityView;
@property (nonatomic, retain) UIView *loadingView;
@property (nonatomic, retain) UIButton *listingButton;
@property (strong, nonatomic) UIActivityIndicatorView *indicaterView;

@property (nonatomic, retain) UIView *__btnsHolderView;

- (void) addBtnsHolderView;

- (void) addNavigationLeftButton;
- (void) addNavigationRightButton;

- (void) addRegisterScreen;
- (void) removeRegisterScreen;

- (void) addLoginScreen;
- (void) removeLoginScreen;

@end
