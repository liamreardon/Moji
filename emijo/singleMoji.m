//
//  singleMoji.m
//  emijo
//
//  Created by karamvir singh on 06/01/14.
//  Copyright (c) 2014 60Degree. All rights reserved.
//

#import "singleMoji.h"

@interface singleMoji ()

@end

@implementation singleMoji

@synthesize __textView, __holderSV;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        __appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [__appDelegate.__navBarVC setNavigationBarHidden:NO animated:YES ];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addNavigationLeftButton];
    [self addNavigationRightButton];
    
    self.__textView = [[UITextView alloc] init];
    
    __x = 0;
    __y = 0;
    
    __w = self.view.frame.size.width;
    __h = self.view.frame.size.height - __y;
    
    self.__holderSV = [[UIScrollView alloc] initWithFrame:CGRectMake(__x, __y, __w, __h)];
    
    self.__holderSV.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
    
    [self.view addSubview:self.__holderSV];
    
    
    self.title = self.emojiTitle;
    self.__textView.frame = CGRectMake(0, 0, self.view.frame.size.width, 10);
    self.__textView.text = self.emojiText;
    self.__textView.editable = FALSE;
    self.__textView.selectable = FALSE;
    self.__textView.backgroundColor = [UIColor clearColor];
    [self.__textView sizeToFit];
    [self.__holderSV addSubview:self.__textView];
    
    //.. Set height according content size height
    CGSize newSize = [self.__textView sizeThatFits:CGSizeMake(320, MAXFLOAT)];
    
    self.__holderSV.contentSize = CGSizeMake(self.__holderSV.frame.size.width, newSize.height + 100);
    
    CGRect __frame = self.__textView.frame;
    
    __frame.origin.x = (self.view.frame.size.width - self.__textView.frame.size.width)/2;
    
    self.__textView.frame = __frame;
    
    //NSLog(@"newSize.height == %f",self.__textView.frame.size.width);
    
    // Do any additional setup after loading the view from its nib.
    
    
    UIImage *__capImg = [self makeImage];
    
    //NSLog(@"%f",__capImg.size.height);
    
    UIImageView *__ImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, __capImg.size.width, __capImg.size.height)];
    
    __ImgV.image = __capImg;
    
    //[self.view addSubview:__ImgV];
    
    //.. Jab jab main tere paas aaya ek sakoon mila..
    
    
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
    UIImage *__normalRight = [UIImage imageNamed:@"nav_send_btn.png"];
    UIImage *__highlightedRight = [UIImage imageNamed:@"nav_send_btn.png"];
    
    // Set the location (x,y) and size (width,height) of the button
    __rightButton.frame = CGRectMake(0, 0, __normalRight.size.width, __normalRight.size.height);
    
    // Set the button's background to an image
    [__rightButton setBackgroundImage:__normalRight forState:UIControlStateNormal];
    [__rightButton setBackgroundImage:__highlightedRight forState:UIControlStateHighlighted];
    
    // Add the target-action for the touch event
    [__rightButton addTarget:self action:@selector(sendButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *sendButtonItem = [[UIBarButtonItem alloc] initWithCustomView:__rightButton];
    [self.navigationItem setRightBarButtonItem:sendButtonItem animated:NO];
    
}

/* Detail Button Clicked*/
-(void)sendButtonClicked
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Share" message:nil delegate:self cancelButtonTitle:nil
                                          otherButtonTitles:@"Copy to clipboard",
                          @"Send Mail",
                          @"Post on Facebook",
                          @"Share with Twitter",
                          @"Send Text",
                          @"Cancel",
                          nil];
    [alert show];
}

/* WHenever Alertview button clicked */
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex==0) {
        UIPasteboard *board = [UIPasteboard generalPasteboard];
        board.string = self.__textView.text;
    } else if(buttonIndex==1) {
        //. Send Mail Funtion
        [__appDelegate sendMailWithSubject:@"Word Maker Art" andBody:self.__textView.text];
    } else if(buttonIndex==2){
        [__appDelegate socailShareType:@"facebook" withText:self.__textView.text];
    } else if(buttonIndex==3){
        [__appDelegate socailShareType:@"twitter" withText:self.__textView.text];
    } else if(buttonIndex == 4){
        [__appDelegate sendSMSFromController:self.__textView.text];
    }

}

-(UIImage*) makeImage {
    
    // Create a graphics context with the target size
    // On iOS 4 and later, use UIGraphicsBeginImageContextWithOptions to take the scale into consideration
    // On iOS prior to 4, fall back to use UIGraphicsBeginImageContext
    CGSize imageSize = [self.__holderSV bounds].size;
    if (NULL != UIGraphicsBeginImageContextWithOptions)
        UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    else
        UIGraphicsBeginImageContext(imageSize);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // -renderInContext: renders in the coordinate space of the layer,
    // so we must first apply the layer's geometry to the graphics context
    CGContextSaveGState(context);
    // Center the context around the view's anchor point
    CGContextTranslateCTM(context, [self.view center].x, [self.view center].y);
    // Apply the view's transform about the anchor point
    CGContextConcatCTM(context, [self.view transform]);
    // Offset by the portion of the bounds left of and above the anchor point
    CGContextTranslateCTM(context,
                          -[self.view bounds].size.width * [[self.view layer] anchorPoint].x,
                          -[self.view bounds].size.height * [[self.view layer] anchorPoint].y);
    
    // Render the layer hierarchy to the current context
    [[self.view layer] renderInContext:context];
    
    // Restore the context
    CGContextRestoreGState(context);
    
    // Retrieve the screenshot image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
