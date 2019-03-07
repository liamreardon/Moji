//
//  ViewUserProfile.h
//  emijo
//
//  Created by karamvir singh on 04/02/14.
//  Copyright (c) 2014 60Degree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "AsyncImageView.h"
#import "StarRatingView.h"
#import "singleMoji.h"

@interface ViewUserProfile : UIViewController
{
    AppDelegate *__appDelegate;
    
    float __x;
    float __y;
    float __w;
    float __h;
    float __padding;
}

@property (nonatomic, retain) NSString *__profileUserID;

@property (nonatomic, retain) NSMutableDictionary *__userDict;
@property (nonatomic, retain) NSMutableArray *__mojisDict;

@property (nonatomic, retain) UIScrollView *__scrollView;

@property (nonatomic, retain) UIButton *__profileImgBtn;
@property (nonatomic, retain) UITextField*__nameTextField;
@property (nonatomic, retain) UITextView *__statusTextView;

@property (nonatomic, retain) UIButton *__postsBtn;

@property (nonatomic, retain) AsyncImageView *imageView;

@property (nonatomic, retain) UIView *__postsHolder;

@property (nonatomic, retain) UIActivityIndicatorView *__loadingView;
@property (nonatomic, retain) NSMutableArray* mojisArray;

- (void) addNavigationLeftButton;

- (void) initializeVariables;

- (void) addScrollView;
- (void) addUserProfileImg;
- (void) addUserName;
- (void) addUserStatus;

- (void) addPostsBtn;

- (void) addPostsHolder;

@end
