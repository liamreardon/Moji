//
//  EditProfileView.h
//  emijo
//
//  Created by karamvir singh on 30/01/14.
//  Copyright (c) 2014 60Degree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface EditProfileView : UIViewController<UITextFieldDelegate, UITextViewDelegate>
{
    AppDelegate *__appDelegate;
    
    float __x;
    float __y;
    float __w;
    float __h;
    float __padding;
}

@property (nonatomic, retain) UIScrollView *__scrollView;

@property (nonatomic, retain) UITextField *__firstNameTF;
@property (nonatomic, retain) UITextField *__lastNameTF;
@property (nonatomic, retain) UITextField *__emailTF;
@property (nonatomic, retain) UITextField *__userNameTF;
@property (nonatomic, retain) UITextView *__statusTV;

@property (strong) NSManagedObject *__userRecord;

- (void) addNavigationLeftButton;
- (void) addNavigationRightButton;

- (void) initializeVariables;

- (void) addScrollView;
- (void) addFirstName;
- (void) addLastName;
- (void) addEmail;
- (void) addUserName;
- (void) addStatus;


- (UIView *) returnTextFieldView:(NSString *)__placeHolder f:(CGRect)__frame tf:(UITextField *)__textField b:(BOOL)__withBorder;

@end
