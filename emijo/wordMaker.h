//
//  wordMaker.h
//  emijo
//
//  Created by karamvir singh on 06/01/14.
//  Copyright (c) 2014 60Degree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>

#import "ReturnWordArt.h"
@interface wordMaker : UIViewController<UITextFieldDelegate, UIPickerViewDelegate>{
    AppDelegate *__appDelegate;
    float __x;
    float __y;
    float __w;
    float __h;
    float __padding;
}

@property (nonatomic, retain) UITextField*word;
@property (nonatomic, retain) UIButton *emotionSelector;

@property (nonatomic, retain) UIButton *makeButton;

//@property (nonatomic, retain) UIPickerView *emotionPicker;
@property (nonatomic, retain) NSArray *emotions;

@property (nonatomic, retain) UIView *__elementsHolder;
@property (nonatomic, retain) UIView *__emoIconsHolderView;

@property (nonatomic, retain) UITextView *__textView;


- (void) addNavigationLeftButton;
- (void) addNavigationRightButton;

- (void) addEmoIconsHolderView;

- (void) showEmoIconsHolderView;
- (void) hideEmoIconsHolderView;

- (void) addTextView;

@end
