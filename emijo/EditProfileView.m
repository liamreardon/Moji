//
//  EditProfileView.m
//  emijo
//
//  Created by karamvir singh on 30/01/14.
//  Copyright (c) 2014 60Degree. All rights reserved.
//

#import "EditProfileView.h"

@interface EditProfileView ()

@end

@implementation EditProfileView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Edit Profile";
        __appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
    
    [self initializeVariables];
    [self addNavigationLeftButton];
    [self addNavigationRightButton];
    
    [self addScrollView];
    
    [self addFirstName];
    [self addLastName];
    [self addEmail];
    [self addUserName];
    [self addStatus];
}

- (void) addNavigationLeftButton
{
    //.. Add Custom left navigation Button
    UIButton *__leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    //.. Button Images
    UIImage *__normalLeft = [UIImage imageNamed:@"nav_back_btn.png"];
    UIImage *__highlightedLeft = [UIImage imageNamed:@"nav_back_btn.png"];
    
    // Set the location (x,y) and size (width,height) of the button
    __leftButton.frame = CGRectMake(0, 0, __normalLeft.size.width, __normalLeft.size.height);
    
    // Set the button's background to an image
    [__leftButton setBackgroundImage:__normalLeft forState:UIControlStateNormal];
    [__leftButton setBackgroundImage:__highlightedLeft forState:UIControlStateHighlighted];
    
    // Add the target-action for the touch event
    [__leftButton addTarget:self action:@selector(leftButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:__leftButton];
    [self.navigationItem setLeftBarButtonItem:backButtonItem animated:NO];
}

- (void) leftButtonClicked:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) addNavigationRightButton
{
    
    //.. Add Custom left navigation Button
    UIButton *__rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    //.. Button Images
    UIImage *__normalRight = [UIImage imageNamed:@"nav_update_btn.png"];
    UIImage *__highlightedRight = [UIImage imageNamed:@"nav_update_btn.png"];
    
    // Set the location (x,y) and size (width,height) of the button
    __rightButton.frame = CGRectMake(0, 0, __normalRight.size.width, __normalRight.size.height);
    
    // Set the button's background to an image
    [__rightButton setBackgroundImage:__normalRight forState:UIControlStateNormal];
    [__rightButton setBackgroundImage:__highlightedRight forState:UIControlStateHighlighted];
    
    // Add the target-action for the touch event
    [__rightButton addTarget:self action:@selector(updateButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *updatedButtonItem = [[UIBarButtonItem alloc] initWithCustomView:__rightButton];
    [self.navigationItem setRightBarButtonItem:updatedButtonItem animated:NO];
    
}

/* Detail Button Clicked*/
-(void)updateButtonClicked
{
    __appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    /* Likes Data from server */
    NSString *bodyData = [NSString stringWithFormat: @"a=updateUserAction&un=%@&status=%@&fn=%@&ln=%@&email=%@&uid=%@",self.__userNameTF.text, self.__statusTV.text,self.__firstNameTF.text, self.__lastNameTF.text, self.__emailTF.text, __appDelegate.__uid];
    
    //NSLog(@"bodyData == %@",bodyData);
    
    NSMutableDictionary *__recieveDict = [[NSMutableDictionary alloc] init];
    __recieveDict = [__appDelegate makeRequest:bodyData];
    
    //NSLog(@"__recieveDict == %@ :::: %@",__recieveDict,[__recieveDict valueForKey:@"success"]);
    if ([[NSString stringWithFormat:@"%@",[__recieveDict valueForKey:@"success"]] isEqualToString:@"true"]) {
        
        NSManagedObjectContext *managedObjectContext = [__appDelegate managedObjectContext];
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"UserInfo"];
        NSMutableArray *__userRecords = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
        
        for (int i = 0; i < [__userRecords count]; i++) {
            self.__userRecord = [__userRecords objectAtIndex:i];
        }
        
        NSError *error = nil;
        // Save the object to persistent store
        if (![managedObjectContext save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
        
        
        NSMutableDictionary *__userDict = [[NSMutableDictionary alloc] init];
        __userDict = [__recieveDict objectForKey:@"data"];
        
        
        /* Save to Core Data*/
        
        //  2
        
        [self.__userRecord setValue:[NSString stringWithFormat:@"%@",self.__userNameTF.text] forKey:@"name"];
        [self.__userRecord setValue:[NSString stringWithFormat:@"%@",self.__statusTV.text] forKey:@"status"];
        [self.__userRecord setValue:[NSString stringWithFormat:@"%@",self.__firstNameTF.text] forKey:@"firstname"];
        [self.__userRecord setValue:[NSString stringWithFormat:@"%@",self.__lastNameTF.text] forKey:@"lastname"];
        [self.__userRecord setValue:[NSString stringWithFormat:@"%@",self.__emailTF.text] forKey:@"email"];
        
        //  3
        
        if (![__appDelegate.managedObjectContext save:&error]) {
            //NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void) initializeVariables
{
    self.__scrollView = [[UIScrollView alloc] init];
    self.__firstNameTF = [[UITextField alloc] init];
    self.__lastNameTF = [[UITextField alloc] init];
    self.__emailTF = [[UITextField alloc] init];
    self.__userNameTF = [[UITextField alloc] init];
    
    self.__statusTV = [[UITextView alloc] init];
}

- (void) addScrollView
{
    __x = 0;
    __y = 0;
    
    __w = self.view.frame.size.width;
    __h = self.view.frame.size.height;
    
    self.__scrollView.frame = CGRectMake(__x, __y, __w, __h);
    self.__scrollView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:self.__scrollView];
}

- (void) addFirstName
{
    __x = 0;
    __y = 0;
    
    __w = self.view.frame.size.width;
    __h = 44;
    
    [self.__scrollView addSubview:[self returnTextFieldView:@"First Name" f:CGRectMake(__x, __y, __w, __h) tf:self.__firstNameTF b:TRUE]];
    
    NSString *__dbStr = [NSString stringWithFormat:@"%@",[__appDelegate.__firstname stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
    
    if (![__dbStr isEqualToString:@""]) {
        self.__firstNameTF.text = __dbStr;
    }
    
    __y = __y + __h;
}


- (void) addLastName
{
    [self.__scrollView addSubview:[self returnTextFieldView:@"Last Name" f:CGRectMake(__x, __y, __w, __h) tf:self.__lastNameTF b:TRUE]];
    
    NSString *__dbStr = [NSString stringWithFormat:@"%@",[__appDelegate.__lastname stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
    
    if (![__dbStr isEqualToString:@""]) {
        self.__lastNameTF.text = __dbStr;
    }
    
    __y = __y + __h;
}

- (void) addEmail
{
    [self.__scrollView addSubview:[self returnTextFieldView:@"Email" f:CGRectMake(__x, __y, __w, __h) tf:self.__emailTF b:TRUE]];
    
    NSString *__dbStr = [NSString stringWithFormat:@"%@",[__appDelegate.__email stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
    
    if (![__dbStr isEqualToString:@""]) {
        self.__emailTF.text = __dbStr;
    }
    
    __y = __y + __h;
}

- (void) addUserName
{
    [self.__scrollView addSubview:[self returnTextFieldView:@"Username" f:CGRectMake(__x, __y, __w, __h) tf:self.__userNameTF b:TRUE]];
    
    NSString *__dbStr = [NSString stringWithFormat:@"%@",[__appDelegate.__username stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
    
    if (![__dbStr isEqualToString:@""]) {
        self.__userNameTF.text = __dbStr;
    }
    
    __y = __y + __h;
}

- (void) addStatus
{
    __x = 10;
    __w = self.view.frame.size.width - 20;
    
    
    self.__statusTV.frame = CGRectMake(__x, __y, __w, __h);
    self.__statusTV.backgroundColor = [UIColor clearColor];
    
    NSString *__dbStr = [NSString stringWithFormat:@"%@",[__appDelegate.__profileStatus stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
    
    if (![__dbStr isEqualToString:@""]) {
        self.__statusTV.text = __dbStr;
    }else
    {
        self.__statusTV.text = @"Add Status";
    }
    
    
    self.__statusTV.textAlignment = NSTextAlignmentLeft;
    self.__statusTV.font = [UIFont fontWithName:@"HelveticaNeue" size:13.0];
    self.__statusTV.textColor = [UIColor colorWithRed:180.0/255.0 green:180.0/255.0 blue:180.0/255.0 alpha:1.0];
    [self.__statusTV setKeyboardType:UIKeyboardTypeAlphabet];
    [self.__statusTV setReturnKeyType:UIReturnKeyDone];
    self.__statusTV.scrollEnabled = FALSE;
    self.__statusTV.delegate = self;
    
    [self.__scrollView addSubview:self.__statusTV];
    
    //.. Set height according content size height
    CGFloat fixedWidth = self.__statusTV.frame.size.width;
    CGSize newSize = [self.__statusTV sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
    CGRect newFrame = self.__statusTV.frame;
    newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
    self.__statusTV.frame = newFrame;
    
    
    self.__scrollView.contentSize = CGSizeMake(self.__scrollView.frame.size.width, newSize.height + self.__statusTV.frame.origin.y);
}

- (UIView *) returnTextFieldView:(NSString *)__placeHolder f:(CGRect)__frame tf:(UITextField *)__textField b:(BOOL)__withBorder
{
    UIView *__view = [[UIView alloc] initWithFrame:__frame];
    
    __textField.frame = CGRectMake(10, ((__view.frame.size.height - 20)/2), (__view.frame.size.width - 20), 20);
    __textField.backgroundColor = [UIColor clearColor];
    __textField.placeholder = __placeHolder;
    __textField.textAlignment = NSTextAlignmentLeft;
    __textField.font = [UIFont fontWithName:@"HelveticaNeue" size:14.0];
    __textField.textColor = [UIColor colorWithRed:140.0/255.0 green:140.0/255.0 blue:140.0/255.0 alpha:1.0];
    [__textField setReturnKeyType:UIReturnKeyDone];
    __textField.delegate = self;
    
    
    if (__textField == self.__emailTF) {
        __textField.keyboardType = UIKeyboardTypeEmailAddress;
    }else{
        __textField.keyboardType = UIKeyboardTypeAlphabet;
    }
    
    __textField.secureTextEntry = NO;
    
//    if (__textField == self.__Password || __textField == self.__RetypePassword) {
//        __textField.secureTextEntry = YES;
//    }else{
//        __textField.secureTextEntry = NO;
//    }
    
    [__view addSubview:__textField];
    
    if (__withBorder) {
        //.. Add Border
        CALayer *grayBottomBorder = [CALayer layer];
        grayBottomBorder.frame = CGRectMake(0, (__view.frame.size.height - 0.5), __view.frame.size.width, 0.5);
        grayBottomBorder.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:1.0].CGColor;
        [__view.layer addSublayer:grayBottomBorder];
    }
    
    
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

#pragma mark -
#pragma mark - UITextView Delegates

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    CGRect __newFrame = self.__scrollView.frame;
    
    __newFrame.origin.y = - 174;
    
    [UIView animateWithDuration:0.3 delay:0.0 options:0 animations:^{
        self.__scrollView.frame = __newFrame;
        
    } completion:^(BOOL finished){
    }];
    
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    
}

- (void) textViewDidChange:(UITextView *)textView{
    //.. Set height according content size height
    CGFloat fixedWidth = self.__statusTV.frame.size.width;
    CGSize newSize = [self.__statusTV sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
    CGRect newFrame = self.__statusTV.frame;
    newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
    self.__statusTV.frame = newFrame;
    
    self.__scrollView.contentSize = CGSizeMake(self.__scrollView.frame.size.width, newSize.height + self.__statusTV.frame.origin.y);
}


- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    
    NSString *__textViewString = [NSString stringWithFormat:@"%@",[textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
    
    if ([__textViewString isEqualToString:@""]) {
        textView.text = @"Add Status";
    }
    
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    //[self setFramesOnTextChange];
    NSCharacterSet *doneButtonCharacterSet = [NSCharacterSet newlineCharacterSet];
    NSRange replacementTextRange = [text rangeOfCharacterFromSet:doneButtonCharacterSet];
    NSUInteger location = replacementTextRange.location;
    
    if (location != NSNotFound){
        
        CGRect __newFrame = self.__scrollView.frame;
        
        __newFrame.origin.y = 0;
        
        [UIView animateWithDuration:0.3 delay:0.0 options:0 animations:^{
            self.__scrollView.frame = __newFrame;
            
        } completion:^(BOOL finished){
        }];
        
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
