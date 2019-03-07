//
//  addEmoji.h
//  emijo
//
//  Created by 60Degree on 11/29/13.
//  Copyright (c) 2013 60Degree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "ViewController.h"
#import "savedMojis.h"
#import <QuartzCore/QuartzCore.h>

@interface addEmoji : UIViewController<UIGestureRecognizerDelegate, UITextFieldDelegate, UITextViewDelegate>{
    
    AppDelegate *__appDelegate;
    float __x;
    float __y;
    float __w;
    float __h;
    float __padding;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@property (strong) NSManagedObject *__mojiRecord;


@property (nonatomic, retain) UITextField *mojiNameField;

@property (nonatomic, retain) UITextView *textView;
@property (nonatomic, retain) UIScrollView *keyboard;

/* Var for Edit Page */
@property (nonatomic, retain) NSString *mojiName;
@property (nonatomic, retain) NSString *mojiData;
@property (nonatomic, retain) NSString *mojiId;
@property (nonatomic) BOOL edit;

@property (nonatomic, retain) NSMutableArray *__textViewStrArr;

@property (nonatomic, retain) UIView *__elementsHolder;

- (void) addNavigationLeftButton;
- (void) addNavigationRightButton;


@end
