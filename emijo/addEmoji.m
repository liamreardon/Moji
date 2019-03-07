//
//  addEmoji.m
//  emijo
//
//  Created by 60Degree on 11/29/13.
//  Copyright (c) 2013 60Degree. All rights reserved.
//

#import "addEmoji.h"

@interface addEmoji ()

@end


@implementation addEmoji
@synthesize keyboard,__textViewStrArr;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        __appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
        
        [__appDelegate.__navBarVC setNavigationBarHidden:NO animated:YES];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
    
    [self addNavigationLeftButton];
    [self addNavigationRightButton];
    
    __w = self.view.frame.size.width + 2;
    __h = 30;
    
    __x = -1;
    __y = self.navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height;
    
    UIView *__titleHolder = [[UIView alloc] init];
    __titleHolder.frame = CGRectMake(__x, __y, __w, __h);
    __titleHolder.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
    
    __titleHolder.layer.borderColor = [UIColor colorWithRed:22.0/255.0 green:198.0/255.0 blue:242.0/255.0 alpha:1.0].CGColor;
    __titleHolder.layer.borderWidth = 1.0;
    
    [self.view addSubview:__titleHolder];
    
    _mojiNameField = [[UITextField alloc] initWithFrame:CGRectMake(10, 3, __w - 22, 24)];
    _mojiNameField.font = [UIFont fontWithName:@"HelveticaNeue" size:13.0];
    _mojiNameField.placeholder = @"Moji Name";
    _mojiNameField.textColor = [UIColor colorWithRed:100.0/255.0 green:100.0/255.0 blue:100.0/255.0 alpha:1.0];
    _mojiNameField.delegate = self;
    
    [_mojiNameField setReturnKeyType:UIReturnKeyDone];
    [_mojiNameField setKeyboardType:UIKeyboardTypeASCIICapable];
    [__titleHolder addSubview:_mojiNameField];
    
    
    self.__textViewStrArr = [[NSMutableArray alloc] init];
    
    __x = 0;
    __y = __y + __h;
    __w = self.view.frame.size.width;
    __h = self.view.frame.size.height- __y;
    
    self.__elementsHolder = [[UIView alloc] init];
    self.__elementsHolder.frame = CGRectMake(__x, __y, __w, __h);
    self.__elementsHolder.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:self.__elementsHolder];
    
    
    __appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    self.managedObjectContext = __appDelegate.managedObjectContext;
    
    /*Moji Name Field */
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(5, 5, self.view.frame.size.width - 10, 150)];
    _textView.backgroundColor = [UIColor clearColor];
    _textView.textColor = [UIColor colorWithRed:100.0/255.0 green:100.0/255.0 blue:100.0/255.0 alpha:1.0];
    _textView.font = [UIFont fontWithName:@"HelveticaNeue" size:13.0];
    _textView.delegate = self;
    [_textView becomeFirstResponder];
    [self.__elementsHolder addSubview:_textView];
    
    /* Edit Section Changes */
    
    // Do any additional setup after loading the view from its nib.
    
    //UIBarButtonItem *__actionBtn;
    if(self.edit==YES) {
        self.title = @"Edit Moji";
        _textView.text = self.mojiData;
        _mojiNameField.text = self.mojiName;
      //  __actionBtn = [[UIBarButtonItem alloc] initWithTitle:@"Update" style:UIBarButtonItemStyleBordered target:self action:@selector(updateButtonClicked)];
    } else {
        self.title = @"Add Moji";
        //__actionBtn = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleBordered target:self action:@selector(saveButtonClicked)];
    }
    //self.navigationItem.rightBarButtonItem = __actionBtn;
    /* Edit Section Changes ends*/
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
    UIImage *__normalRight;
    UIImage *__highlightedRight;
    
    if(self.edit==YES) {
        __normalRight = [UIImage imageNamed:@"nav_update_btn.png"];
        __highlightedRight = [UIImage imageNamed:@"nav_update_btn.png"];
    } else {
        __normalRight = [UIImage imageNamed:@"nav_save_btn.png"];
        __highlightedRight = [UIImage imageNamed:@"nav_save_btn.png"];
    }
    
    
    // Set the location (x,y) and size (width,height) of the button
    __rightButton.frame = CGRectMake(0, 0, __normalRight.size.width, __normalRight.size.height);
    
    // Set the button's background to an image
    [__rightButton setBackgroundImage:__normalRight forState:UIControlStateNormal];
    [__rightButton setBackgroundImage:__highlightedRight forState:UIControlStateHighlighted];
    
    // Add the target-action for the touch event
    
    if(self.edit==YES) {
        [__rightButton addTarget:self action:@selector(updateButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    } else {
        [__rightButton addTarget:self action:@selector(saveButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:__rightButton];
    [self.navigationItem setRightBarButtonItem:backButtonItem animated:NO];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [_mojiNameField resignFirstResponder];
        [_textView becomeFirstResponder];
    return YES;
}


/*Save Button */

-(BOOL)saveButtonClicked {
    
    NSTimeInterval timeStamp = [[NSDate date] timeIntervalSince1970];
    // NSTimeInterval is defined as double
    NSNumber *timeStampObj = [NSNumber numberWithDouble: timeStamp];
    
    
    //NSLog(@"%@",timeStampObj);
    
    NSString *errorMessage = nil;
    UITextField *errorField;
    
    if(!_mojiNameField.text || [_mojiNameField.text isEqualToString:@""])
    {
        errorMessage = @"Please enter Moji Name";
        errorField = _mojiNameField;
        [__appDelegate alert:errorMessage withObject:@"Failed"];
        return false;
    }
    
    /* Save to Core Data*/
    
    //  1
    NSManagedObject * newEntry = [NSEntityDescription insertNewObjectForEntityForName:@"Mojis" inManagedObjectContext:self.managedObjectContext];
    //  2
    //NSString *timeInMiliseconds = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]];
    
    [newEntry setValue:_textView.text forKey:@"data"];
    [newEntry setValue:_mojiNameField.text forKey:@"name"];
    [newEntry setValue:[NSString stringWithFormat:@"%@",timeStampObj] forKey:@"id"];
    [newEntry setValue:[NSDate date] forKey:@"created"];
    
    //  3
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    
    savedMojis *savedView = [[savedMojis alloc] initWithNibName:@"savedMojis" bundle:nil];
    [self.navigationController pushViewController:savedView animated:YES];
    
    [self.view endEditing:YES];
    return YES;
}

/********** Save Button */

/*Update Button */

-(BOOL)updateButtonClicked {
    
    NSTimeInterval timeStamp = [[NSDate date] timeIntervalSince1970];
    // NSTimeInterval is defined as double
    NSNumber *timeStampObj = [NSNumber numberWithDouble: timeStamp];
    
    NSString *errorMessage = nil;
    UITextField *errorField;
    
    if(!_mojiNameField.text || [_mojiNameField.text isEqualToString:@""])
    {
        errorMessage = @"Please enter Moji Name";
        errorField = _mojiNameField;
        [__appDelegate alert:errorMessage withObject:@"Failed"];
        return false;
    }
    
    
    if (self.__mojiRecord) {
        /* Save to Core Data*/
        
        //  2
        //NSString *timeInMiliseconds = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]];
        
        [self.__mojiRecord setValue:_textView.text forKey:@"data"];
        [self.__mojiRecord setValue:_mojiNameField.text forKey:@"name"];
        [self.__mojiRecord setValue:[NSString stringWithFormat:@"%@",timeStampObj] forKey:@"id"];
        [self.__mojiRecord setValue:[NSDate date] forKey:@"created"];
        
        //  3
        NSError *error;
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
    }else{
        /* Save to Core Data*/
        
        //  1
        NSManagedObject * newEntry = [NSEntityDescription insertNewObjectForEntityForName:@"Mojis" inManagedObjectContext:self.managedObjectContext];
        //  2
        NSString *timeInMiliseconds = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]];
        
        [newEntry setValue:_textView.text forKey:@"data"];
        [newEntry setValue:_mojiNameField.text forKey:@"name"];
        [newEntry setValue:timeInMiliseconds forKey:@"id"];
        [newEntry setValue:[NSDate date] forKey:@"created"];
        
        //  3
        NSError *error;
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
    }
    
   
    
    
//    /* Update to Core Data*/
//    FMDatabase *db = [__appDelegate openDb];
//    NSString *updateStr = [NSString stringWithFormat:@"UPDATE zmojis SET zname = '%@', zdata = '%@' WHERE z_pk = '%@'", _mojiNameField.text, _textView.text, self.mojiId];
//    [db executeUpdate:updateStr];
//    [db close];
    
    savedMojis *savedView = [[savedMojis alloc] initWithNibName:@"savedMojis" bundle:nil];
    [self.navigationController pushViewController:savedView animated:YES];
    [self.view endEditing:YES];
    return YES;
}

/********** Update Button */


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
