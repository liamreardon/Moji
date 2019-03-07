//
//  ViewUserProfile.m
//  emijo
//
//  Created by karamvir singh on 04/02/14.
//  Copyright (c) 2014 60Degree. All rights reserved.
//

#define IMAGE_VIEW_TAG 99

#import "ViewUserProfile.h"

@interface ViewUserProfile ()

@end

@implementation ViewUserProfile

@synthesize __statusTextView, __scrollView, __loadingView, __nameTextField, __postsBtn, __postsHolder, __profileImgBtn, __profileUserID, __userDict;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
         __appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated
{
    
    for (UIView *__view in self.view.subviews) {
        if (__view.tag != 100200300) {
            [__view removeFromSuperview];
        }
        
    }
    
    [self.__loadingView startAnimating];
    
    [self performSelector:@selector(loadUserData) withObject:nil afterDelay:0.2];
    
}

- (void) loadUserData
{
    NSString *bodyData = [NSString stringWithFormat: @"a=UserdataAction&uid=%@",self.__profileUserID];
    
    NSMutableDictionary *__dict = [NSMutableDictionary dictionary];
    
    __dict = [[__appDelegate makeRequest:bodyData] objectForKey:@"data"];
    
    self.__userDict = [NSMutableDictionary dictionary];
    
    self.__userDict = [__dict valueForKey:@"user_info"];
    
    self.__mojisDict = [[NSMutableArray alloc] init];
    
    self.__mojisDict = [__dict valueForKey:@"mojis"];
    
    //NSLog(@"%@",[NSString stringWithFormat:@"http://192.232.214.244/~avanttec/animoji/assets/images/%@",[self.__userDict valueForKey:@"image"]]);
    
    
    
    [self initializeVariables];
    
    [self addScrollView];
    [self addUserProfileImg];
    [self addUserName];
    [self addUserStatus];
    [self addPostsBtn];
    [self addPostsHolder];
    
    [self.__loadingView stopAnimating];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
    
    /* Loading View */
    self.__loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    self.__loadingView.frame = self.view.frame;
    self.__loadingView.tag = 100200300;
    
    self.__loadingView.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.7];
    
    [self.view addSubview:self.__loadingView];
    
    
    [self addNavigationLeftButton];
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

- (void) addScrollView
{
    __x = 0;
    __y = self.navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height;
    
    __w = self.view.frame.size.width;
    __h = self.view.frame.size.height;
    
    self.__scrollView.frame = CGRectMake(__x, __y, __w, __h);
    self.__scrollView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:self.__scrollView];
}


- (void) initializeVariables
{
    self.__postsHolder = [[UIView alloc] init];
    self.imageView = [[AsyncImageView alloc] init];
    self.__scrollView = [[UIScrollView alloc] init];
    self.__profileImgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.__nameTextField = [[UITextField alloc] init];
    self.__statusTextView = [[UITextView alloc] init];
    self.__postsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
}

- (void) addUserProfileImg
{
    
    UIImage *__coverImage = [UIImage imageNamed:@"other_profile_cover.png"];
    
    __w = __coverImage.size.width;
    __h = __coverImage.size.height;
    
    __x = (self.view.frame.size.width - __w)/2;
    __y = 30;
    
    UIView *__imageHolder = [[UIView alloc] initWithFrame:CGRectMake(__x, __y, __w, __h)];
    
    __imageHolder.backgroundColor = [UIColor clearColor];
    
    [self.__scrollView addSubview:__imageHolder];
    
    __w = 75;
    __h = 75;
    
    __x = 0.5;
    __y = 0.5;
    
    UIImageView *__imgView = [[UIImageView alloc] initWithFrame:CGRectMake(__x, __y, __w, __h)];
    __imgView.contentMode = UIViewContentModeScaleAspectFill;
    
    __imgView.clipsToBounds = YES;
    __imgView.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0];
    
    __imgView.contentMode = UIViewContentModeScaleAspectFit;
    __imgView.layer.cornerRadius = 4;
    __imgView.layer.masksToBounds = YES;
    
    [__imageHolder addSubview:__imgView];
    
    //load the image
    //self.imageView.imageURL = [NSURL URLWithString:@"http://192.232.214.244/~avanttec/animoji/assets/images/2_profile_img.jpg"];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://192.232.214.244/~avanttec/animoji/assets/images/%@",[self.__userDict valueForKey:@"image"]]]];
        if (imgData) {
            UIImage *image = [UIImage imageWithData:imgData];
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    __imgView.image = image;
                });
            }
        }
    });
    
//    //add AsyncImageView to cell
//    self.imageView.frame = CGRectMake(__x, __y, __w, __h);
//    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
//    self.imageView.clipsToBounds = YES;
//    self.imageView.tag = IMAGE_VIEW_TAG;
//    
//    [__imageHolder addSubview:self.imageView];
//    
//    //cancel loading previous image for cell
//    [[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:self.imageView];
//    
//    //load the image
//    self.imageView.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://192.232.214.244/~avanttec/animoji/assets/images/%@",[self.__userDict valueForKey:@"image"]]];
//    
//    //self.imageView.imageURL = [NSURL URLWithString:@"http://192.232.214.244/~avanttec/rakesh/profile_pic.png"];
//    
//    self.imageView.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0];
//    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
//    self.imageView.layer.cornerRadius = 4;
//    self.imageView.layer.masksToBounds = YES;
    
    
    //.. CoverImage
    
    __w = __coverImage.size.width;
    __h = __coverImage.size.height;
    
    __x = 0;
    __y = 0;
    
    UIImageView *__coverImg = [[UIImageView alloc] initWithFrame:CGRectMake(__x, __y, __w, __h)];
    
    __coverImg.image = __coverImage;
    __coverImg.backgroundColor = [UIColor clearColor];
    
    [__imageHolder addSubview:__coverImg];
    
    
}

- (void) addUserName
{
    
    __x = 10;
    __y = __y + __h + 35;
    __w = self.view.frame.size.width - 20;
    __h = 20;
    
    self.__nameTextField.frame = CGRectMake(__x, __y, __w, __h);
    self.__nameTextField.backgroundColor = [UIColor clearColor];
    self.__nameTextField.text = [NSString stringWithFormat:@"%@",[self.__userDict valueForKey:@"username"]];
    self.__nameTextField.textAlignment = NSTextAlignmentCenter;
    self.__nameTextField.font = [UIFont fontWithName:@"HelveticaNeue" size:17.0];
    self.__nameTextField.textColor = [UIColor colorWithRed:120.0/255.0 green:120.0/255.0 blue:120.0/255.0 alpha:1.0];
    //    [self.__nameTextField setKeyboardType:UIKeyboardTypeAlphabet];
    //    [self.__nameTextField setReturnKeyType:UIReturnKeyDone];
    self.__nameTextField.enabled = NO;
    [self.__scrollView addSubview:self.__nameTextField];
    
}


- (void) addUserStatus
{
    __x = 10;
    __y = __y + __h;
    __w = self.view.frame.size.width - 20;
    __h = 30;
    
    self.__statusTextView.frame = CGRectMake(__x, __y, __w, __h);
    self.__statusTextView.backgroundColor = [UIColor clearColor];
    self.__statusTextView.text = [NSString stringWithFormat:@"%@",[self.__userDict valueForKey:@"status"]];
    self.__statusTextView.textAlignment = NSTextAlignmentCenter;
    self.__statusTextView.font = [UIFont fontWithName:@"HelveticaNeue" size:13.0];
    self.__statusTextView.textColor = [UIColor colorWithRed:180.0/255.0 green:180.0/255.0 blue:180.0/255.0 alpha:1.0];
    //    [self.__statusTextView setKeyboardType:UIKeyboardTypeAlphabet];
    //    [self.__statusTextView setReturnKeyType:UIReturnKeyDone];
    self.__statusTextView.editable = FALSE;
    self.__statusTextView.selectable = FALSE;
    
    
    [self.__scrollView addSubview:self.__statusTextView];
    
    //.. Set height according content size height
    CGFloat fixedWidth = self.__statusTextView.frame.size.width;
    CGSize newSize = [self.__statusTextView sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
    CGRect newFrame = self.__statusTextView.frame;
    newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
    self.__statusTextView.frame = newFrame;
    
    __y = __y + self.__statusTextView.frame.size.height + 10;
}

- (void) addPostsBtn
{
    __w = self.__scrollView.frame.size.width;
    __h = 44;
    __x = 0;
    
    self.__postsBtn.frame = CGRectMake(__x, __y, __w, __h);
    self.__postsBtn.backgroundColor = [UIColor colorWithRed:20.0/255.0 green:200.0/255.0 blue:240.0/255.0 alpha:1.0];
    
    [self.__postsBtn setTitle:@"Post" forState:UIControlStateNormal];
    
    [self.__postsBtn.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:14.0]];
    
    //[self.__postsBtn addTarget:self action:@selector(postsBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.__scrollView addSubview:self.__postsBtn];
    
    __y = __y + self.__statusTextView.frame.size.height + 10;
}

- (void) addPostsHolder
{
    __x = 5;
    __w = self.view.frame.size.width - 10;
    __h = 150;
    
    self.__postsHolder.frame = CGRectMake(__x, __y, __w, __h);
    self.__postsHolder.backgroundColor = [UIColor clearColor];
    
    [self.__scrollView addSubview:self.__postsHolder];
    
    [self performSelector:@selector(loadPostAndlikesData) withObject:nil afterDelay:0.1];
    
}

- (void) loadPostAndlikesData
{
    //.. First Delete all data
    for (UIView *__view in self.__postsHolder.subviews) {
        [__view removeFromSuperview];
    }
    
    __x = 0;
    __y = 0;
    __w = self.__postsHolder.frame.size.width;
    __h = 60;
    
    for (int i = 0; i < [self.__mojisDict count]; i++) {
        UIView *__holderView = [[UIView alloc] initWithFrame:CGRectMake(__x, __y, __w, __h)];
        
        __holderView.backgroundColor = [UIColor clearColor];
        
        [self.__postsHolder addSubview:__holderView];
        
        NSMutableDictionary *moji = [self.__mojisDict objectAtIndex:i];
        
        
        //NSLog(@"moji == %@",moji);
        
        
        UIColor *textColor = [UIColor colorWithRed:0.0/255.0 green:90.0/255.0 blue:115.0/255.0 alpha:1.0];
        
        UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(10, 2, self.view.frame.size.width, 30)];
        name.text = [moji valueForKey:@"name"];
        name.textColor = textColor;
        [name setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:15.0]];
        
        [__holderView addSubview:name];

        
        //Watch
        
        UIImage *__watchImg = [UIImage imageNamed:@"watch_icon.png"];
        
        UIImageView *watch = [[UIImageView alloc] init];
        watch.image = __watchImg;
        watch.frame = CGRectMake(10, name.frame.size.height + 5, __watchImg.size.width, __watchImg.size.height);
        [__holderView addSubview:watch];
        
        //.TIme diffrence Calculation
        
        // Convert string to date object
        NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
        [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        NSDate *date = [inputFormatter dateFromString:[moji valueForKey:@"created"]];
        
        
        NSDate* date2 = [NSDate date];
        NSTimeInterval distanceBetweenDates = [date timeIntervalSinceDate:date2];
        
        NSString *diff = [__appDelegate timeIntervalToStringWithInterval:distanceBetweenDates];
        
        UILabel *timeAgo = [[UILabel alloc] initWithFrame:CGRectMake(__watchImg.size.width + 12, name.frame.size.height + 2, 70, 15)];
        timeAgo.text = [NSString stringWithFormat:@"%@ by: ",diff];
        timeAgo.textColor = [UIColor grayColor];
        timeAgo.backgroundColor = [UIColor clearColor];
        timeAgo.font = [UIFont fontWithName:@"HelveticaNeue" size:8.0];
        [__holderView addSubview:timeAgo];
        
        /* TIME VIEW ENDS*/

        /* user detail View*/
        
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString: [NSString stringWithFormat:@"%@",[self.__userDict valueForKey:@"username"]]];
        [attributeString addAttribute:NSUnderlineStyleAttributeName
                                value:[NSNumber numberWithInt:1]
                                range:(NSRange){0,[attributeString length]}];
        
        UILabel *userText = [[UILabel alloc] initWithFrame:CGRectMake(watch.frame.origin.x +  timeAgo.frame.size.width - 12, name.frame.size.height - 3, 170, 25)];
        userText.backgroundColor = [UIColor clearColor];
        userText.attributedText = [attributeString copy];
        userText.textColor = textColor;
        userText.font = [UIFont fontWithName:@"HelveticaNeue" size:10.0];
        [__holderView addSubview:userText];
        /* user detail View ends*/

        StarRatingView *starviewR = [[StarRatingView alloc]initWithFrame:CGRectMake(userText.frame.size.width, name.frame.size.height, 80, 15) andRating:80 withLabel:NO animated:YES selectedColor:[UIColor colorWithRed:250.0/255.0 green:204.0/255.0 blue:46.0/255.0 alpha:1.0]];
        //UIControl *mask = [[UIControl alloc] init];
        // [mask addSubview:starviewR];
        [__holderView addSubview:starviewR];
        
        UILabel *ratingText = [[UILabel alloc] initWithFrame:CGRectMake(starviewR.frame.origin.x + starviewR.frame.size.width, name.frame.size.height - 2, 100, 20)];
        ratingText.textColor = [UIColor grayColor];
        ratingText.text = @"1684 ratings";
        ratingText.font = [UIFont fontWithName:@"HelveticaNeue" size:9.0];
        [__holderView addSubview:ratingText];
        
        UIButton *btn = [[UIButton alloc] initWithFrame:__holderView.bounds];
        btn.backgroundColor = [UIColor clearColor];
        btn.frame = CGRectMake(0, 0, __holderView.frame.size.width, 60);
        [btn addTarget:self action:@selector(selectedCell:) forControlEvents:UIControlEventTouchUpInside];
        btn.property = [[NSMutableDictionary alloc] initWithObjects:@[[moji valueForKey:@"data"], [moji valueForKey:@"name"]] forKeys:@[@"mojiart", @"mojiName"]];
        [__holderView addSubview:btn];
        
        
        if (i < ([self.__mojisDict count] - 1)) {
            //.. Add Border
            CALayer *grayBottomBorder = [CALayer layer];
            grayBottomBorder.frame = CGRectMake(0, (__holderView.frame.size.height - 0.5), __holderView.frame.size.width, 0.5);
            grayBottomBorder.backgroundColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0].CGColor;
            [__holderView.layer addSublayer:grayBottomBorder];
        }
        
        __y = __y + __h;
        
    }
    
    CGRect __frame = self.__postsHolder.frame;
    __frame.size.height = __y;
    self.__postsHolder.frame = __frame;
    
    self.__scrollView.contentSize = CGSizeMake(self.__scrollView.frame.size.width, (self.__postsHolder.frame.origin.y + self.__postsHolder.frame.size.height + 100));
    
}

-(void) selectedCell:(id) sender{
    
    UIButton *button = sender;
    NSMutableDictionary *dict = button.property;
    
    
    NSString* input = [dict valueForKey:@"mojiart"];
    
    // will cause trouble if you have "abc\\\\uvw"
    NSString* esc1 = [input stringByReplacingOccurrencesOfString:@"\\\\u" withString:@"\\U"];
    NSString* esc2 = [esc1 stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    NSString* quoted = [[@"\"" stringByAppendingString:esc2] stringByAppendingString:@"\""];
    NSData* data = [quoted dataUsingEncoding:NSUTF8StringEncoding];
    NSString* unesc = [NSPropertyListSerialization propertyListFromData:data
                                                       mutabilityOption:NSPropertyListImmutable format:NULL
                                                       errorDescription:NULL];
    assert([unesc isKindOfClass:[NSString class]]);
    
    singleMoji *sm = [[singleMoji alloc] initWithNibName:@"singleMoji" bundle:nil];
    sm.emojiText = unesc;
    sm.emojiTitle = [dict valueForKey:@"mojiName"];
    
    [__appDelegate.__navBarVC pushViewController:sm animated:YES];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
