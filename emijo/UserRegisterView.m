//
//  UserRegisterView.m
//  emijo
//
//  Created by karamvir singh on 09/01/14.
//  Copyright (c) 2014 60Degree. All rights reserved.
//

#import "UserRegisterView.h"

@implementation UserRegisterView

@synthesize __ElementsHolderSV, __FirstName, __LastName, __Email, __Country, __CountryLabel, __Username, __Password, __RetypePassword, __countries, __pickerView, __pickerViewHolder, __isRegisterClicked, __loadingView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.__countries = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Countries" ofType:@"plist"]];
        
        self.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
        
        [self initializeVariables];
    }
    return self;
}

- (void) initializeVariables
{
    self.__isBackClicked = FALSE;
    self.__isRegisterClicked = FALSE;
    
    self.__ElementsHolderSV = [[UIScrollView alloc] init];
    
    self.__FirstName = [[UITextField alloc] init];
    self.__LastName = [[UITextField alloc] init];
    self.__Email = [[UITextField alloc] init];
    self.__Country = [UIButton buttonWithType:UIButtonTypeCustom];
    self.__CountryLabel = [[UITextField alloc] init];
    self.__Username = [[UITextField alloc] init];
    self.__Password = [[UITextField alloc] init];
    self.__RetypePassword = [[UITextField alloc] init];
    
    self.__pickerView = [[UIPickerView alloc] init];
    self.__pickerViewHolder = [[UIView alloc] init];
}

- (void) drawElements
{
    [self addScrollView];
    [self addCustomNavigation];
    
    [self addFirstName];
    [self addLastName];
    [self addEmail];
    [self addCountry];
    [self addUserName];
    [self addPassword];
    [self addRetypePassword];
    [self addSelectPicker];
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
    
    
    __w = 70;
    __h = 25;
    
    __x = __navigation.frame.size.width - (__w + 10);
    __y = ((__navigation.frame.size.height - __h)/2) + 10;
    
    
    UIButton *__registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    __registerBtn.frame = CGRectMake(__x, __y, __w, __h);
    __registerBtn.backgroundColor = [UIColor colorWithRed:10.0/255.0 green:60.0/255.0 blue:80.0/255.0 alpha:1.0];
    __registerBtn.layer.cornerRadius = 2;
    __registerBtn.layer.masksToBounds = YES;
    
    [__registerBtn setTitle:@"Register" forState:UIControlStateNormal];
    
    [__registerBtn.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:12.0]];
    
    [__registerBtn addTarget:self action:@selector(registerBtnClicked:) forControlEvents:UIControlEventTouchUpInside];

    [__navigation addSubview:__registerBtn];
    
    
    //.. Add Custom left navigation Button
    UIButton *__leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    //.. Button Images
    UIImage *__normalLeft = [UIImage imageNamed:@"nav_back_btn.png"];
    UIImage *__highlightedLeft = [UIImage imageNamed:@"nav_back_btn.png"];
    
    // Set the location (x,y) and size (width,height) of the button
    __leftButton.frame = CGRectMake(10, ((__navigation.frame.size.height - __normalLeft.size.height)/2) + 10, __normalLeft.size.width, __normalLeft.size.height);
    
    // Set the button's background to an image
    [__leftButton setBackgroundImage:__normalLeft forState:UIControlStateNormal];
    [__leftButton setBackgroundImage:__highlightedLeft forState:UIControlStateHighlighted];
    
    // Add the target-action for the touch event
    [__leftButton addTarget:self action:@selector(leftButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [__navigation addSubview:__leftButton];
}

- (void) leftButtonClicked:(UIButton *)sender
{
    self.__isBackClicked = TRUE;
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}


- (void) registerBtnClicked:(UIButton *)sender
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
    //.. Check fields
    NSString *__FirstNameVal = [NSString stringWithFormat:@"%@",[self.__FirstName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
    
    NSString *__LastNameVal = [NSString stringWithFormat:@"%@",[self.__LastName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
    
    NSString *__EmailVal = [NSString stringWithFormat:@"%@",[self.__Email.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
    
    NSString *__CountryVal = [NSString stringWithFormat:@"%@",[self.__CountryLabel.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
    
    NSString *__UsernameVal = [NSString stringWithFormat:@"%@",[self.__Username.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
    
    NSString *__PasswordVal = [NSString stringWithFormat:@"%@",[self.__Password.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
    
    NSString *__RetypePasswordVal = [NSString stringWithFormat:@"%@",[self.__RetypePassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
    
    if ([self checkFields:__FirstNameVal ln:__LastNameVal e:__EmailVal c:__CountryVal u:__UsernameVal p:__PasswordVal rp:__RetypePasswordVal]) {
        //NSLog(@"All Set");
        
        __appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
        self.managedObjectContext = __appDelegate.managedObjectContext;
        
        /* Likes Data from server */
        NSString *bodyData = [NSString stringWithFormat: @"a=registerUserAction&fn=%@&ln=%@&em=%@&co=%@&un=%@&pass=%@",__FirstNameVal, __LastNameVal, __EmailVal, __CountryVal, __UsernameVal, __PasswordVal];
        
        
       // NSString *bodyData = [NSString stringWithFormat: @"a=registerUserAction&fn=Rakesh&ln=Singh&em=rakesh.singh1234@60degree.com&co=USA&un=ricky28chd0109&pass=123456"];
        
        NSMutableDictionary *__recieveDict = [[NSMutableDictionary alloc] init];
        __recieveDict = [__appDelegate makeRequest:bodyData];
        
        
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
            
            [newEntry setValue:__FirstNameVal forKey:@"firstname"];
            [newEntry setValue:__LastNameVal forKey:@"lastname"];
            [newEntry setValue:__EmailVal forKey:@"email"];
            
            //  3
            NSError *error;
            if (![self.managedObjectContext save:&error]) {
                NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            }
            
            self.__isRegisterClicked = TRUE;
            
            [self sendActionsForControlEvents:UIControlEventValueChanged];
            
        }else{
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"%@",[__recieveDict valueForKey:@"message"]] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            
        }
    }
    
    [self.__loadingView stopAnimating];
}

- (BOOL) checkFields:(NSString *)__FirstNameVal ln:(NSString *)__LastNameVal e:(NSString *)__EmailVal c:(NSString *)__CountryVal u:(NSString *)__UsernameVal p:(NSString *)__PasswordVal rp:(NSString *)__RetypePasswordVal
{
    
    __appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    BOOL __allSet = FALSE;
    
    if ([__FirstNameVal isEqualToString:@""])
    {
        [__appDelegate alert:@"Please enter the First Name" withObject:@"Error"];
    }else if ([__LastNameVal isEqualToString:@""])
    {
        [__appDelegate alert:@"Please enter the Last Name." withObject:@"Error"];
    }else if ([__EmailVal isEqualToString:@""])
    {
        [__appDelegate alert:@"Please enter the Email." withObject:@"Error"];
    }else if ([__CountryVal isEqualToString:@""])
    {
        [__appDelegate alert:@"Please select the country." withObject:@"Error"];
    }else if ([__UsernameVal isEqualToString:@""])
    {
        [__appDelegate alert:@"Please enter the Username." withObject:@"Error"];
    }else if ([__PasswordVal isEqualToString:@""])
    {
        [__appDelegate alert:@"Please enter the Password." withObject:@"Error"];
    }else if ([__RetypePasswordVal isEqualToString:@""])
    {
        [__appDelegate alert:@"Please enter the Retype Password." withObject:@"Error"];
    }else if (![self NSStringIsValidEmail:__EmailVal])
    {
        [__appDelegate alert:@"Please enter the valid Email." withObject:@"Error"];
    }else if (![__PasswordVal isEqualToString:__RetypePasswordVal])
    {
        [__appDelegate alert:@"Password not match" withObject:@"Error"];
    }else if ([__UsernameVal length] < 6) {
        [__appDelegate alert:@"Username will need to be a MINIMUM of 6 characters" withObject:@"Error"];
    }else{
        __allSet = TRUE;
    }
        
    
    return __allSet;
}

-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = YES; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

- (void) addScrollView
{
    __x = 0;
    __y = 64;
    
    __w = self.frame.size.width;
    __h = self.frame.size.height - __y;
    
    self.__ElementsHolderSV.frame = CGRectMake(__x, __y, __w, __h);
    self.__ElementsHolderSV.backgroundColor = [UIColor clearColor];
    
    [self addSubview:self.__ElementsHolderSV];
}

- (void) addFirstName
{
    __x = 0;
    __y = 0;
    
    __w = self.frame.size.width;
    __h = 44;
    
    [self.__ElementsHolderSV addSubview:[self returnTextFieldView:@"First Name" f:CGRectMake(__x, __y, __w, __h) tf:self.__FirstName b:TRUE]];
    
    __y = __y + __h;
}

- (void) addLastName
{
    [self.__ElementsHolderSV addSubview:[self returnTextFieldView:@"Last Name" f:CGRectMake(__x, __y, __w, __h) tf:self.__LastName b:TRUE]];
    
    __y = __y + __h;
}

- (void) addEmail
{
    [self.__ElementsHolderSV addSubview:[self returnTextFieldView:@"Email" f:CGRectMake(__x, __y, __w, __h) tf:self.__Email b:TRUE]];
    
    __y = __y + __h;
}

- (void) addCountry
{
    
    [self.__ElementsHolderSV addSubview:[self returnTextFieldView:@"Country" f:CGRectMake(__x, __y, __w, __h) tf:self.__CountryLabel b:TRUE]];

    
    self.__Country.frame = CGRectMake(__x, __y, __w, __h);
    self.__Country.backgroundColor = [UIColor clearColor];
    
    [self.__Country addTarget:self action:@selector(countryClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.__ElementsHolderSV addSubview:self.__Country];
    
    //.. Add Border
    CALayer *grayBottomBorder = [CALayer layer];
    grayBottomBorder.frame = CGRectMake(0, (self.__Country.frame.size.height - 0.5), self.__Country.frame.size.width, 0.5);
    grayBottomBorder.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:1.0].CGColor;
    [self.__Country.layer addSublayer:grayBottomBorder];
    
    
    UIImage *__arrowImg = [UIImage imageNamed:@"cell_arrow.png"];
    
    //.. Add Arrow Icon
    UIImageView *__arrowIconHolder = [[UIImageView alloc] initWithFrame:CGRectMake((self.__Country.frame.size.width - (__arrowImg.size.width + 10)), ((self.__Country.frame.size.height - __arrowImg.size.height)/2), __arrowImg.size.width, __arrowImg.size.height)];
    
    __arrowIconHolder.image = __arrowImg;
    __arrowIconHolder.backgroundColor = [UIColor clearColor];
    
    [self.__Country addSubview:__arrowIconHolder];
    
    __y = __y + __h;
}

- (void) countryClicked:(UIButton *)sender
{
    [self showSelectPicker];
}

- (void) addUserName
{
    [self.__ElementsHolderSV addSubview:[self returnTextFieldView:@"Username" f:CGRectMake(__x, __y, __w, __h) tf:self.__Username b:TRUE]];
    
    __y = __y + __h;
}

- (void) addPassword
{
    [self.__ElementsHolderSV addSubview:[self returnTextFieldView:@"Password" f:CGRectMake(__x, __y, __w, __h) tf:self.__Password b:TRUE]];
    
    __y = __y + __h;
}

- (void) addRetypePassword
{
    [self.__ElementsHolderSV addSubview:[self returnTextFieldView:@"Retype Password" f:CGRectMake(__x, __y, __w, __h) tf:self.__RetypePassword b:FALSE]];
    
    __y = __y + __h;
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
    
    if (__textField == self.__Email) {
        __textField.keyboardType = UIKeyboardTypeEmailAddress;
    }else{
        __textField.keyboardType = UIKeyboardTypeAlphabet;
    }
    
    if (__textField == self.__Password || __textField == self.__RetypePassword) {
        __textField.secureTextEntry = YES;
    }else{
        __textField.secureTextEntry = NO;
    }
    
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
    
    [self selectDonePressed];
    
    if (textField == self.__Username || textField == self.__Password || textField == self.__RetypePassword) {
        CGRect __newFrame = self.__ElementsHolderSV.frame;
        
        if (textField == self.__Username) {
            __newFrame.origin.y = - 10;
        }else if (textField == self.__Password) {
            __newFrame.origin.y = - 20;
        }else if (textField == self.__RetypePassword) {
            __newFrame.origin.y = - 50;
        }
        
        [UIView animateWithDuration:0.3 delay:0.0 options:0 animations:^{
            self.__ElementsHolderSV.frame = __newFrame;
            
        } completion:^(BOOL finished){
        }];
    }
    
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
    
    if (textField == self.__Username || textField == self.__Password || textField == self.__RetypePassword) {
        CGRect __newFrame = self.__ElementsHolderSV.frame;
        __newFrame.origin.y = 64;
        [UIView animateWithDuration:0.3 delay:0.0 options:0 animations:^{
            self.__ElementsHolderSV.frame = __newFrame;
            
        } completion:^(BOOL finished){
        }];
    }
    
    return YES;
}


#pragma mark -
#pragma mark - Select Picker

- (void) addSelectPicker
{
    self.__pickerView.delegate = self;
    self.__pickerView.showsSelectionIndicator = YES;
    self.__pickerView.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
    
    self.__pickerView.frame = CGRectMake(0, 40, self.frame.size.width, self.__pickerView.frame.size.height);
    [self.__pickerViewHolder addSubview:self.__pickerView];
    
    __x = 0;
    __y = self.frame.size.height;
    __w = self.__pickerView.frame.size.width;
    __h = self.__pickerView.frame.size.height + 40;
    
    self.__pickerViewHolder.frame = CGRectMake(__x, __y, __w, __h);
    
    self.__pickerViewHolder.backgroundColor = [UIColor colorWithRed:20.0/255.0 green:200.0/255.0 blue:240.0/255.0 alpha:1.0];
    
    [self addSubview:self.__pickerViewHolder];
    
    UIButton *__doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    __doneBtn.frame = CGRectMake((self.__pickerViewHolder.frame.size.width - (70 + 10)), 10, 70, 25);
    __doneBtn.backgroundColor = [UIColor redColor];
    __doneBtn.layer.cornerRadius = 2;
    __doneBtn.layer.masksToBounds = YES;
    
    [__doneBtn setTitle:@"Done" forState:UIControlStateNormal];
    
    [__doneBtn.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:12.0]];
    
    [__doneBtn addTarget:self action:@selector(selectDonePressed) forControlEvents:UIControlEventTouchUpInside];
    
    [self.__pickerViewHolder addSubview:__doneBtn];
    
}

- (void) showSelectPicker
{
    
    [self.__FirstName resignFirstResponder];
    [self.__LastName resignFirstResponder];
    [self.__Email resignFirstResponder];
    [self.__Username resignFirstResponder];
    [self.__Password resignFirstResponder];
    [self.__RetypePassword resignFirstResponder];
    
    
    int datePickerHeight = self.__pickerViewHolder.frame.size.height;
    
    __x = 0;
    __y = self.frame.size.height - (datePickerHeight);
    __w = self.__pickerView.frame.size.width;
    __h = self.__pickerView.frame.size.height;
    
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options:0
                     animations:^{
                         
                         self.__pickerViewHolder.frame = CGRectMake(__x, __y, __w, __h);
                         
                     }
                     completion:^(BOOL finished){
                         
                     }];
}

- (void) selectDonePressed
{
    
    __x = 0;
    __y = self.frame.size.height;
    __w = self.__pickerView.frame.size.width;
    __h = self.__pickerView.frame.size.height;
    
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options:0
                     animations:^{
                         
                         self.__pickerViewHolder.frame = CGRectMake(__x, __y, __w, __h);
                     }
                     completion:^(BOOL finished){
                         
                     }];
    self.__isRegisterClicked = FALSE;
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

#pragma mark -
#pragma mark PickerView DataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.__countries.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [[self.__countries objectAtIndex:row] objectForKey:@"name"];
}


#pragma mark PickerView Delegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.__CountryLabel.text = [[self.__countries objectAtIndex:row] objectForKey:@"name"];
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
