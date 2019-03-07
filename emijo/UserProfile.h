//
//  UserProfile.h
//  emijo
//
//  Created by karamvir singh on 08/01/14.
//  Copyright (c) 2014 60Degree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "AsyncImageView.h"
#import "TakePhotoOptionsView.h"
#import "StarRatingView.h"
#import "EditProfileView.h"
#import "singleMoji.h"

@interface UserProfile : UIViewController{
    AppDelegate *__appDelegate;
    
    float __x;
    float __y;
    float __w;
    float __h;
    float __padding;
}

@property (nonatomic, retain) TakePhotoOptionsView *__takePhotoOptionsView;

@property (nonatomic, retain) UIScrollView *__scrollView;

@property (nonatomic, retain) UIButton *__profileImgBtn;
@property (nonatomic, retain) UITextField*__nameTextField;
@property (nonatomic, retain) UITextView *__statusTextView;

@property (nonatomic, retain) UIButton *__postsBtn;
@property (nonatomic, retain) UIButton *__likesBtn;

@property (nonatomic, retain) AsyncImageView *imageView;

@property (nonatomic, retain) UIView *__postsAndLikeHolder;
@property (nonatomic, assign) BOOL __isPostActive;

@property (nonatomic, retain) NSMutableDictionary *likesArray;

@property (nonatomic, retain) UIActivityIndicatorView *__loadingView;
@property (nonatomic, retain) NSMutableArray* mojisArray;

@property (nonatomic, retain) UIImageView *__imgView;


@property (strong) NSManagedObject *__userRecord;

- (void) addNavigationLeftButton;
- (void) addNavigationRightButton;

- (void) initializeVariables;

- (void) addScrollView;
- (void) addUserProfileImg;
- (void) addUserName;
- (void) addUserStatus;

- (void) addPostsBtn;
- (void) addLikesBtn;

- (void) addFollowersAndFollowing;
- (void) addPostsAndLikesHolder;


@end
