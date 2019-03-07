//
//  UserRegisterView.h
//  emijo
//
//  Created by karamvir singh on 09/01/14.
//  Copyright (c) 2014 60Degree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "AppDelegate.h"

@interface UserRegisterView : UIControl<UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource>{
    AppDelegate *__appDelegate;
    float __x;
    float __y;
    float __w;
    float __h;
    float __padding;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@property(nonatomic, retain) UIScrollView *__ElementsHolderSV;

@property(nonatomic, retain) UITextField *__FirstName;
@property(nonatomic, retain) UITextField *__LastName;
@property(nonatomic, retain) UITextField *__Email;
@property(nonatomic, retain) UIButton *__Country;
@property(nonatomic, retain) UITextField *__CountryLabel;
@property(nonatomic, retain) UITextField *__Username;
@property(nonatomic, retain) UITextField *__Password;
@property(nonatomic, retain) UITextField *__RetypePassword;

@property(nonatomic, retain) NSArray *__countries;
@property (nonatomic, retain) UIPickerView *__pickerView;
@property (nonatomic, retain) UIView *__pickerViewHolder;

@property (nonatomic, assign) BOOL __isRegisterClicked;
@property (nonatomic, assign) BOOL __isBackClicked;


- (void) initializeVariables;
- (void) drawElements;

- (void) addCustomNavigation;
- (void) addScrollView;

- (void) addFirstName;
- (void) addLastName;
- (void) addEmail;
- (void) addCountry;
- (void) addUserName;
- (void) addPassword;
- (void) addRetypePassword;
- (void) addSelectPicker;
- (void) showSelectPicker;
- (void) selectDonePressed;

- (BOOL) checkFields:(NSString *)__FirstNameVal ln:(NSString *)__LastNameVal e:(NSString *)__EmailVal c:(NSString *)__CountryVal u:(NSString *)__UsernameVal p:(NSString *)__PasswordVal rp:(NSString *)__RetypePasswordVal;

- (BOOL) NSStringIsValidEmail:(NSString *)checkString;

- (UIView *) returnTextFieldView:(NSString *)__placeHolder f:(CGRect)__frame tf:(UITextField *)__textField b:(BOOL)__withBorder;

@property (nonatomic, retain) UIActivityIndicatorView *__loadingView;

@end
