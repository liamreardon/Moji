//
//  LoginView.m
//  emijo
//
//  Created by karamvir singh on 17/01/14.
//  Copyright (c) 2014 60Degree. All rights reserved.
//

#import "LoginView.h"

@implementation LoginView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
        
        [self initializeVariables];
    }
    return self;
}

- (void) initializeVariables
{
    self.__newUserClicked = FALSE;
    
    self.__loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.__Username = [[UITextField alloc] init];
    self.__Password = [[UITextField alloc] init];
}

- (void) drawElements
{
    [self addCustomNavigation];
    
    [self addUserName];
    [self addPassword];
    
    [self addLoginBtn];
    [self addForgotPasswordBtn];
}

- (void) addCustomNavigation
{
    __x = 0;
    __y = 0;
    
    __w = self.frame.size.width;
    __h = 64;
    
    UIView *__navigation = [[UIView alloc] init];
    
    __navigation.frame = CGRectMake(__x, __y, __w, __h);
    __navigation.backgroundColor = [UIColor colorWithRed:20.0/255.0 green:200.0/255.0 blue:240.0/255.0 alpha:1.0];
    
    [self addSubview:__navigation];
    
    
    __w = 65;
    __h = 25;
    
     __x = __navigation.frame.size.width - (__w + 10);
    __y = ((__navigation.frame.size.height - __h)/2) + 10;
    
    
    UIButton *__newUserBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    __newUserBtn.frame = CGRectMake(__x, __y, __w, __h);
    __newUserBtn.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0];
    __newUserBtn.layer.cornerRadius = 2;
    __newUserBtn.layer.masksToBounds = YES;
    
    [__newUserBtn setTitle:@"New User" forState:UIControlStateNormal];
    
    [__newUserBtn.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:12.0]];
    
    [__newUserBtn addTarget:self action:@selector(newUserBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [__navigation addSubview:__newUserBtn];
    
}


- (void) newUserBtnClicked:(UIButton *)sender
{
    self.__newUserClicked = TRUE;
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void) addUserName
{
    __w = self.frame.size.width - 100;
    __h = 44;
    
    __x = (self.frame.size.width - __w)/2;
    __y = 150;
    
    __padding = __x;
    
    [self addSubview:[self returnTextFieldView:@"Username" f:CGRectMake(__x, __y, __w, __h) tf:self.__Username]];
    
    __y = __y + __h + 10;
}


- (void) addPassword
{
    [self addSubview:[self returnTextFieldView:@"Password" f:CGRectMake(__x, __y, __w, __h) tf:self.__Password]];
    
    __y = __y + __h + 10;
}

- (void) addLoginBtn
{
    
    __x = __x + __w;
    
    __h = 50;
    __w = 50;
    
    __x = __x - __w;
    
    //__x = (self.frame.size.width - __w)/2;
    
    self.__loginBtn.frame = CGRectMake(__x, __y, __w, __h);
    self.__loginBtn.backgroundColor = [UIColor colorWithRed:70.0/255.0 green:220.0/255.0 blue:0.0/255.0 alpha:1.0];
    self.__loginBtn.layer.cornerRadius = __h/2;
    self.__loginBtn.layer.masksToBounds = YES;
    
    [self.__loginBtn setTitle:@"Login" forState:UIControlStateNormal];
    
    [self.__loginBtn.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:12.0]];
    
    [self.__loginBtn addTarget:self action:@selector(loginBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.__loginBtn];
}


- (void) loginBtnClicked:(UIButton *)sender
{
    
    /* Loading View */
    self.__loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    self.__loadingView.frame = self.bounds;
    
    self.__loadingView.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.8];
    
    [self.__loadingView startAnimating];
    
    [self addSubview:self.__loadingView];
    
    [self performSelector:@selector(sendDataToServer) withObject:Nil afterDelay:0.2];

}

- (void) sendDataToServer
{
    NSString *__UsernameVal = [NSString stringWithFormat:@"%@",[self.__Username.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
    
    NSString *__PasswordVal = [NSString stringWithFormat:@"%@",[self.__Password.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
    
    if ([self checkFields:__UsernameVal p:__PasswordVal]) {
        //NSLog(@"All Set");
        
        __appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
        self.managedObjectContext = __appDelegate.managedObjectContext;
        
        /* Likes Data from server */
        NSString *bodyData = [NSString stringWithFormat: @"a=loginAction&username=%@&password=%@",__UsernameVal, __PasswordVal];
        
        NSMutableDictionary *__recieveDict = [[NSMutableDictionary alloc] init];
        __recieveDict = [__appDelegate makeRequest:bodyData];
        
         //NSLog(@"__recieveDict == %@",__recieveDict);
        if ([[NSString stringWithFormat:@"%@",[__recieveDict valueForKey:@"success"]] isEqualToString:@"true"]) {
            
            NSMutableDictionary *__userDict = [[NSMutableDictionary alloc] init];
            __userDict = [__recieveDict objectForKey:@"data"];
            
            
            /* Save to Core Data*/
            //  1
            NSManagedObject * newEntry = [NSEntityDescription insertNewObjectForEntityForName:@"UserInfo" inManagedObjectContext:self.managedObjectContext];
            
            //  2
            
            [newEntry setValue:[NSString stringWithFormat:@"%@",[__userDict valueForKey:@"userid"]] forKey:@"id"];
            [newEntry setValue:[NSString stringWithFormat:@"%@",[__userDict valueForKey:@"image"]] forKey:@"img"];
            [newEntry setValue:[NSString stringWithFormat:@"%@",[__userDict valueForKey:@"username"]] forKey:@"name"];
            [newEntry setValue:[NSString stringWithFormat:@"%@",[__userDict valueForKey:@"status"]] forKey:@"status"];
            [newEntry setValue:[NSString stringWithFormat:@"%@",[__userDict valueForKey:@"followers"]] forKey:@"followers"];
            [newEntry setValue:[NSString stringWithFormat:@"%@",[__userDict valueForKey:@"following"]] forKey:@"following"];
            [newEntry setValue:[NSString stringWithFormat:@"%@",[__userDict valueForKey:@"session_token"]] forKey:@"sessionToken"];
            
            [newEntry setValue:[NSString stringWithFormat:@"%@",[__userDict valueForKey:@"firstname"]] forKey:@"firstname"];
            [newEntry setValue:[NSString stringWithFormat:@"%@",[__userDict valueForKey:@"lastname"]] forKey:@"lastname"];
            [newEntry setValue:[NSString stringWithFormat:@"%@",[__userDict valueForKey:@"email"]] forKey:@"email"];

            
            //  3
            
            NSError *error;
            if (![self.managedObjectContext save:&error]) {
                NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            }
            
            //[__appDelegate getUserData];
            
            self.__newUserClicked = FALSE;
            
            [self sendActionsForControlEvents:UIControlEventValueChanged];
            
        }else{
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"%@",[__recieveDict valueForKey:@"message"]] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            
        }
    }
    
    [self.__loadingView stopAnimating];

}

- (BOOL) checkFields:(NSString *)__UsernameVal p:(NSString *)__PasswordVal
{
    
    __appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    BOOL __allSet = FALSE;
    
    if ([__UsernameVal isEqualToString:@""])
    {
        [__appDelegate alert:@"Please enter the Username." withObject:@"Error"];
    }else if ([__PasswordVal isEqualToString:@""])
    {
        [__appDelegate alert:@"Please enter the Password." withObject:@"Error"];
    }else{
        __allSet = TRUE;
    }
    
    
    return __allSet;
}

- (void) addForgotPasswordBtn
{
    __h = 30;
    __w = 120;
    
    UIButton *__forgotPasswordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    __forgotPasswordBtn.frame = CGRectMake(__padding, __y + 10, __w, __h);
    __forgotPasswordBtn.backgroundColor = [UIColor colorWithRed:10.0/255.0 green:60.0/255.0 blue:80.0/255.0 alpha:1.0];
    __forgotPasswordBtn.layer.cornerRadius = 2;
    __forgotPasswordBtn.layer.masksToBounds = YES;
    
    [__forgotPasswordBtn setTitle:@"Forgot Password?" forState:UIControlStateNormal];
    //[__forgotPasswordBtn setTitle:@"Forgot Password?" forState:UIControlStateHighlighted];
    
    [__forgotPasswordBtn.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:12.0]];
    //[__forgotPasswordBtn.titleLabel setTextColor:[UIColor colorWithRed:10.0/255.0 green:60.0/255.0 blue:80.0/255.0 alpha:1.0]];
    
    [__forgotPasswordBtn addTarget:self action:@selector(forgotPasswordBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:__forgotPasswordBtn];
}

- (void) forgotPasswordBtnClicked:(UIButton *)sender
{
    
    UIAlertView* dialog = [[UIAlertView alloc] init];
    [dialog setDelegate:self];
    [dialog setTitle:@"Enter your email id"];
    [dialog setMessage:@" "];
    [dialog addButtonWithTitle:@"Cancel"];
    [dialog addButtonWithTitle:@"OK"];
    dialog.tag = 100;
    
    dialog.alertViewStyle = UIAlertViewStylePlainTextInput;
    [dialog textFieldAtIndex:0].keyboardType = UIKeyboardTypeEmailAddress;
    
    CGAffineTransform moveUp = CGAffineTransformMakeTranslation(0.0, 0.0);
    [dialog setTransform: moveUp];
    [dialog show];

}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //NSLog(@" buttonIndex == %d",buttonIndex);
    
    if (buttonIndex == 1) {
        
        UITextField *__email = [alertView textFieldAtIndex:0];
        
        __appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
        self.managedObjectContext = __appDelegate.managedObjectContext;
        
        /* Likes Data from server */
        NSString *bodyData = [NSString stringWithFormat: @"a=forgotUserAction&email=%@",__email.text];
        
        NSMutableDictionary *__userDict = [[NSMutableDictionary alloc] init];
        __userDict = [[__appDelegate makeRequest:bodyData] objectForKey:@"data"];

    }
}

- (UIView *) returnTextFieldView:(NSString *)__placeHolder f:(CGRect)__frame tf:(UITextField *)__textField
{
    UIView *__view = [[UIView alloc] initWithFrame:__frame];
    
    __view.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0];
    
    __view.layer.cornerRadius = 5.0;
    
    __textField.frame = CGRectMake(10, ((__view.frame.size.height - 20)/2), (__view.frame.size.width - 20), 20);
    __textField.backgroundColor = [UIColor clearColor];
    __textField.placeholder = __placeHolder;
    __textField.textAlignment = NSTextAlignmentLeft;
    __textField.font = [UIFont fontWithName:@"HelveticaNeue" size:14.0];
    __textField.textColor = [UIColor colorWithRed:140.0/255.0 green:140.0/255.0 blue:140.0/255.0 alpha:1.0];
    [__textField setReturnKeyType:UIReturnKeyDone];
    __textField.delegate = self;
    
    if (__textField == self.__Password) {
        __textField.secureTextEntry = YES;
    }else{
        __textField.secureTextEntry = NO;
    }
    
    [__view addSubview:__textField];
    
    return __view;
}


#pragma mark -
#pragma mark - UITextField Delegates

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [UIView animateWithDuration:0.1 animations:^{
        [textField invalidateIntrinsicContentSize];
    }];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@"#"]) {
        return NO;
    }
    else {
        return YES;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
