//
//  topCharts.h
//  emijo
//
//  Created by 60Degree on 12/6/13.
//  Copyright (c) 2013 60Degree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>

#import "StarRatingView.h"
#import "RatingView.h"

#import "ViewUserProfile.h"

@interface topCharts : UIViewController{
    AppDelegate *__appDelegate;
    float __x;
    float __y;
    float __w;
    float __h;
    float __padding;
}

@property (nonatomic, retain) UIView * tabs;
@property (nonatomic, retain) UIButton * dailyBtn;
@property (nonatomic, retain) UIButton * monthlyBtn;
@property (nonatomic, retain) UIButton * alltimeBtn;

@property (nonatomic, strong) UIScrollView *topCharts;
@property (nonatomic) float  centerWidth;
@property (nonatomic) float  w;

@property (nonatomic, retain) UIActivityIndicatorView *__loadingView;
@property (nonatomic) int loggedInUserId;


@property (nonatomic, retain) StarRatingView* starviewR;
@property (nonatomic) int ratingPercentage;

@property (nonatomic, retain) UIView *__elementsHolder;

//. Top Charts for selected category
@property (nonatomic) BOOL selectCat;
@property (nonatomic, retain) NSString *selectCatName;


- (void) addNavigationLeftButton;

- (void) loadViewData;
- (void) TappedLoadViewData:(NSString *)bodyData;



@end
