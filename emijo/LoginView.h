//
//  LoginView.h
//  emijo
//
//  Created by karamvir singh on 17/01/14.
//  Copyright (c) 2014 60Degree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface LoginView : UIControl<UITextFieldDelegate>{
    AppDelegate *__appDelegate;
    float __x;
    float __y;
    float __w;
    float __h;
    float __padding;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@property(nonatomic, retain) UITextField *__Username;
@property(nonatomic, retain) UITextField *__Password;

@property(nonatomic, retain) UIButton *__loginBtn;

@property(nonatomic, assign) BOOL __newUserClicked;

- (void) initializeVariables;
- (void) drawElements;

- (void) addCustomNavigation;
- (void) addUserName;
- (void) addPassword;

- (void) addLoginBtn;
- (void) addForgotPasswordBtn;

- (UIView *) returnTextFieldView:(NSString *)__placeHolder f:(CGRect)__frame tf:(UITextField *)__textField;

- (BOOL) checkFields:(NSString *)__UsernameVal p:(NSString *)__PasswordVal;

@property (nonatomic, retain) UIActivityIndicatorView *__loadingView;

@end
