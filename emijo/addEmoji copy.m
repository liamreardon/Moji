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


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        __appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
        self.title = @"Add Emoji";
        [__appDelegate.__navBarVC setNavigationBarHidden:NO animated:YES];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    __appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    self.managedObjectContext = __appDelegate.managedObjectContext;
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor grayColor];
    UIBarButtonItem *__actionBtn = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleBordered target:self action:@selector(saveButtonClicked)];
    self.navigationItem.rightBarButtonItem = __actionBtn;
    
    int w = self.view.frame.size.width;
    int h = self.view.frame.size.height;
    /*Moji Name Field */
    _mojiName = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, w, 20)];
    _mojiName.placeholder = @"Moji Name";
    _mojiName.delegate = self;
    [_mojiName setReturnKeyType:UIReturnKeyDone];
    
    [self.view addSubview:_mojiName];
    
    /* EmojiAnimView*/
    _emojiAnimView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 20, w, h-180)];
    _emojiAnimView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"dark_exa.png"]];
    [self.view addSubview:_emojiAnimView];
    
    _emojiView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, h-200, w, 150)];
    _emojiView.backgroundColor = [UIColor grayColor];
    
    
    self.emojiArray = [[NSArray alloc]
                       initWithObjects:@"icon_angry.png",
                       @"icon_cool.png",
                       @"icon_lol.png",
                       @"icon_cry.png",
                       @"icon_sad.png",
                       @"icon_sweat.png",
                       @"icon_sleep.png",
                       @"icon_music.png",
                       @"icon_razz",
                       @"icon_cool.png",
                       @"icon_lol.png",
                       @"icon_cry.png",
                       @"icon_sad.png",
                       @"icon_sweat.png",
                       @"icon_sleep.png",
                       @"icon_music.png",
                       @"icon_razz",
                       @"icon_cool.png",
                       @"icon_lol.png",
                       @"icon_cry.png",
                       @"icon_sad.png",
                       @"icon_sweat.png",
                       @"icon_sleep.png",
                       @"icon_music.png",
                       @"icon_razz",
                       @"icon_cool.png",
                       @"icon_lol.png",
                       @"icon_cry.png",
                       @"icon_sad.png",
                       @"icon_sweat.png",
                       @"icon_sleep.png",
                       @"icon_music.png",
                       @"icon_razz",
                       @"icon_cool.png",
                       @"icon_lol.png",
                       @"icon_cry.png",
                       @"icon_sad.png",
                       @"icon_sweat.png",
                       @"icon_sleep.png",
                       @"icon_music.png",
                       @"icon_razz",
                       nil];
    int i = 0;
    int j = 0;
    int emojWidth = 16;
    int emojHeight = 16 ;
    int top = 0;
    int left = 0;
    
    
    for(NSString *emoj in _emojiArray){
        CGRect frame = CGRectMake(left, top, emojWidth, emojHeight);
        UIImage *image = [UIImage imageNamed: emoj];
        SEL myTestSelector = @selector(addToView:);
        UIButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
        aButton.tag = i;
        aButton.frame = frame;
        [aButton setImage:image forState:UIControlStateNormal];
        
        [aButton addTarget:self action:myTestSelector forControlEvents:UIControlEventTouchUpInside];
        
        [self.emojiView addSubview:aButton];
        i++;
        
        if(j<=9) {
            left = left+30;
            j++;
        } else {
            left = 0;
            top = top+20;
            j = 0;
        }
    }
    
    int x = _emojiView.frame.size.height + top ;
    
    _emojiView.contentSize = CGSizeMake(_emojiView.frame.size.width, x);
    [self.view addSubview:_emojiView];
    
}


-(BOOL) textFieldShouldDone:(UITextField *)textField{
    [_mojiName resignFirstResponder];
    return YES;
}
/*Save Button */

-(BOOL)saveButtonClicked {
    
    NSString *errorMessage = nil;
    UITextField *errorField;
    
    if(!_mojiName.text || [_mojiName.text isEqualToString:@""])
    {
        errorMessage = @"Please enter Moji Name";
        errorField = _mojiName;
        [__appDelegate alert:errorMessage withObject:@"Failed"];
        return false;
    }
    
    
    NSArray *subviews = [self.emojiAnimView subviews]; // Get all subviews from a view
    int i = 0;
    NSMutableDictionary *dataDictionary;
    NSMutableDictionary *finalDictionary = [NSMutableDictionary dictionary];
    
    for(UIView *view in subviews){
        if([view isMemberOfClass:[SPUserResizableView class]]) {
            
            /* Get needed parameters*/
            float h = view.frame.size.height;
            float w = view.frame.size.width;
            float x = view.frame.origin.x;
            float y = view.frame.origin.y;
            int t = view.tag;
            
            /* Create Dictionary for one object*/
            NSMutableDictionary *emojiDict = [[NSMutableDictionary alloc] init];
            [emojiDict setObject:[NSNumber numberWithFloat:h]  forKey:@"h"];
            [emojiDict setObject:[NSNumber numberWithFloat:w]  forKey:@"w"];
            [emojiDict setObject:[NSNumber numberWithFloat:x]  forKey:@"x"];
            [emojiDict setObject:[NSNumber numberWithFloat:y]  forKey:@"y"];
            [emojiDict setObject:[NSNumber numberWithFloat:t]  forKey:@"t"];
            
            /* Add One object to Final Dictionary*/
            [finalDictionary setObject:emojiDict forKey:[NSString stringWithFormat:@"obj_%d",i]];
            i++;
        }
    }
    
    /* Convert NSmutable dictionary to NS transformable data*/
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dataDictionary];
    
    
    /* Save to Core Data*/
    
    //  1
    NSManagedObject * newEntry = [NSEntityDescription insertNewObjectForEntityForName:@"Mojis" inManagedObjectContext:self.managedObjectContext];
    //  2
    NSString *timeInMiliseconds = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]];
    [newEntry setValue:data forKey:@"data"];
    [newEntry setValue:_mojiName.text forKey:@"name"];
    [newEntry setValue:timeInMiliseconds forKey:@"id"];
    
    //  3
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    
    [self.view endEditing:YES];
    return YES;
}

/********** Save Button */


/* ADD, Move ANd Resize */

-(void)addToView:(id)sender{
    
    UIButton *button = (UIButton *)sender;
    UIImage *imageName = button.currentImage;
    NSLog(@"%d", button.tag);
    //    CGRect imageFrame = CGRectMake(50, 200, 50, 50);
    
    CGRect imageFrame = CGRectMake(60.0, 16.0, 180.0, 241.0);
    
    SPUserResizableView *imageResizableView = [[SPUserResizableView alloc] initWithFrame:imageFrame];
    
    UIImageView *imageView = [
                              [UIImageView alloc]
                              initWithImage: imageName
                              ];
    imageResizableView.tag = button.tag;
    
    [UIView animateWithDuration:0.5
                          delay:0.1
                        options: UIViewAnimationOptionBeginFromCurrentState
                     animations:^
     {
         CGRect frame = imageView.frame;
         frame.origin.y = 0;
         frame.origin.x = (-100);
         imageView.frame = imageFrame;
     }
                     completion:^(BOOL finished){}
     ];
    
    imageResizableView.contentView = imageView;
    imageResizableView.delegate = self;
    [_emojiAnimView addSubview:imageResizableView];
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideEditingHandles)];
    [gestureRecognizer setDelegate:self];
    [_emojiAnimView addGestureRecognizer:gestureRecognizer];
    
}



- (void)userResizableViewDidBeginEditing:(SPUserResizableView *)userResizableView {
    [currentlyEditingView hideEditingHandles];
    currentlyEditingView = userResizableView;
}

- (void)userResizableViewDidEndEditing:(SPUserResizableView *)userResizableView {
    lastEditedView = userResizableView;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([currentlyEditingView hitTest:[touch locationInView:currentlyEditingView] withEvent:nil]) {
        return NO;
    }
    return YES;
}

- (void)hideEditingHandles {		
    [lastEditedView hideEditingHandles];
}

/* ADD, Move ANd Resize */


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
