//
//  InfoView.m
//  MojiFree
//
//  Created by karamvir singh on 24/01/14.
//  Copyright (c) 2014 karamvir singh. All rights reserved.
//

#import "InfoView.h"

@interface InfoView ()

@end

@implementation InfoView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Info";
        __appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
    
    self.__textView = [[UITextView alloc] init];
    
    [self addNavigationLeftButton];

    [self addTextView];
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

- (void) addTextView
{
    __x = 10;
    __y = 0;
    __w = self.view.frame.size.width - 20;
    __h = self.view.frame.size.height - (__y + 95);
    
    
    
    //__y = __appDelegate.window.frame.size.height - __h;
    
    self.__textView.frame = CGRectMake(__x, __y, __w, __h);
    self.__textView.backgroundColor = [UIColor clearColor];
    self.__textView.editable = FALSE;
    self.__textView.scrollEnabled = TRUE;
    
    
    
    NSString *htmlString = @"<b>Top Charts: </b>View, Like, Rate, and Share the worlds emoji art!</br></br><b>Browse: </b>Browse and search through a selection of emoji art pictures.</br></br><b>Submit to App: </b>Submit your own emoji art to the app for the world to see!</br></br><b>Likes: </b>Any emoji art pictures you have liked will be here.</br></br><b>Saved: </b>Your own emoji art pictures that you have saved and want to view for future use.</br></br><b>Profile: </b>Your own profile that portfolios any emoji art you have submitted to the app, along with any emoji art you have liked.</br></br><b>Stickers: </b>Browse through a selection of 1000+ stickers in multiple categories for you to share with your friends!</br></br><b>Cool Fonts: </b>Spice up your texts with these cool fonts!</br></br><b>Word Maker: </b>Emotify a word with Word Maker!";
    
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    
    self.__textView.attributedText = attributedString;
    
    self.__textView.font = [UIFont fontWithName:@"HelveticaNeue" size:13.0];
    
    [self.view addSubview:self.__textView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
