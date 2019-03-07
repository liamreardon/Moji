//
//  UserProfile.m
//  emijo
//
//  Created by karamvir singh on 08/01/14.
//  Copyright (c) 2014 60Degree. All rights reserved.
//

#define IMAGE_VIEW_TAG 99

#import "UserProfile.h"

@interface UserProfile ()

@end

@implementation UserProfile

@synthesize __scrollView, __profileImgBtn, __nameTextField, __statusTextView, __postsBtn, __likesBtn, __takePhotoOptionsView, __postsAndLikeHolder, __isPostActive, likesArray, __loadingView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Profile";
        __appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated
{
    NSMutableDictionary *__dict = [NSMutableDictionary dictionary];
    
    __dict = [__appDelegate getUserData];
    
    //NSLog(@"User Id == %@",[__dict valueForKey:@"id"]);
    
    if ([__dict valueForKey:@"id"]) {
        __appDelegate.__sessionToken = [__dict valueForKey:@"sessionToken"];
        __appDelegate.__uid = [__dict valueForKey:@"id"];
        
        if ([[NSString stringWithFormat:@"%@",[[__dict valueForKey:@"name"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]] isEqualToString:@""]) {
            __appDelegate.__username = @"";
        }else{
            __appDelegate.__username = [__dict valueForKey:@"name"];
        }
        
        
        if ([[NSString stringWithFormat:@"%@",[[__dict valueForKey:@"status"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]] isEqualToString:@""]) {
            __appDelegate.__profileStatus = @"";
        }else{
            __appDelegate.__profileStatus = [__dict valueForKey:@"status"];
        }
        
        
        __appDelegate.__firstname = [__dict valueForKey:@"firstname"];
        __appDelegate.__lastname = [__dict valueForKey:@"lastname"];
        __appDelegate.__email = [__dict valueForKey:@"email"];
        
        __appDelegate.__profilePic = [NSString stringWithFormat:@"http://192.232.214.244/~avanttec/animoji/assets/images/%@",[__dict valueForKey:@"img"]];
        
        
        
        self.__nameTextField.text = __appDelegate.__username;
        self.__statusTextView.text = __appDelegate.__profileStatus;
        
    }
    
    
    
    
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
    [self addUserProfileImg];
    [self addUserName];
    [self addUserStatus];
    //[self addFollowersAndFollowing];
    [self addPostsBtn];
    [self addLikesBtn];
    [self addPostsAndLikesHolder];
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
    UIImage *__normalRight = [UIImage imageNamed:@"nav_setting_btn.png"];
    UIImage *__highlightedRight = [UIImage imageNamed:@"nav_setting_btn.png"];
    
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
    EditProfileView *__editProfileView = [[EditProfileView alloc] initWithNibName:@"EditProfileView" bundle:nil];
    [self.navigationController pushViewController:__editProfileView animated:YES];
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


- (void) initializeVariables
{
    self.__imgView = [[UIImageView alloc] init];
    self.__isPostActive = TRUE;
    self.__postsAndLikeHolder = [[UIView alloc] init];
    self.imageView = [[AsyncImageView alloc] init];
    self.__scrollView = [[UIScrollView alloc] init];
    self.__profileImgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.__nameTextField = [[UITextField alloc] init];
    self.__statusTextView = [[UITextView alloc] init];
    
    self.__postsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.__likesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
}

- (void) addUserProfileImg
{
    
    UIImage *__coverImage = [UIImage imageNamed:@"profile_cover.png"];
    
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
    
    self.__imgView.frame = CGRectMake(__x, __y, __w, __h);
    self.__imgView.contentMode = UIViewContentModeScaleAspectFill;
    
    self.__imgView.clipsToBounds = YES;
    self.__imgView.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0];
    
    self.__imgView.contentMode = UIViewContentModeScaleAspectFit;
    self.__imgView.layer.cornerRadius = 4;
    self.__imgView.layer.masksToBounds = YES;
    
    [__imageHolder addSubview:self.__imgView];
    
    //load the image
    //self.imageView.imageURL = [NSURL URLWithString:@"http://192.232.214.244/~avanttec/animoji/assets/images/2_profile_img.jpg"];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",__appDelegate.__profilePic]]];
        if (imgData) {
            UIImage *image = [UIImage imageWithData:imgData];
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.__imgView.image = image;
                });
            }
        }
    });
    
    
    /*
    //add AsyncImageView to cell
    self.imageView.frame = CGRectMake(__x, __y, __w, __h);
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = YES;
    self.imageView.tag = IMAGE_VIEW_TAG;
    
    [__imageHolder addSubview:self.imageView];
    
    //cancel loading previous image for cell
    [[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:self.imageView];
    
    NSLog(@"%@",[NSURL URLWithString:[NSString stringWithFormat:@"%@",__appDelegate.__profilePic]]);
    
    //load the image
    self.imageView.imageURL = [NSURL URLWithString:@"http://192.232.214.244/~avanttec/animoji/assets/images/2_profile_img.jpg"];
    self.imageView.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.layer.cornerRadius = 4;
    self.imageView.layer.masksToBounds = YES;
    
    */
    //.. CoverImage
    
    __w = __coverImage.size.width;
    __h = __coverImage.size.height;
    
    __x = 0;
    __y = 0;
    
    UIImageView *__coverImg = [[UIImageView alloc] initWithFrame:CGRectMake(__x, __y, __w, __h)];
    
    __coverImg.image = __coverImage;
    __coverImg.backgroundColor = [UIColor clearColor];
    
    [__imageHolder addSubview:__coverImg];
    
    
    //.. Profile Btn
    
    __w = __coverImage.size.width;
    __h = __coverImage.size.height;
    
    __x = (self.view.frame.size.width - __w)/2;
    __y = 30;
    
    self.__profileImgBtn.frame = CGRectMake(__x, __y, __w, __h);
    
    self.__profileImgBtn.backgroundColor = [UIColor clearColor];
    [self.__profileImgBtn addTarget:self action:@selector(profileBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.__scrollView addSubview:self.__profileImgBtn];
    
}


- (void) profileBtnClicked:(UIButton *)sender
{
    //NSLog(@"profileBtnClicked");
    
    __x = 0;
    __y = 0;
    __w = self.view.frame.size.width;
    __h = self.view.frame.size.height - __y;
    
    //.. Initialize Take photo View
    self.__takePhotoOptionsView = [[TakePhotoOptionsView alloc] initWithFrame:CGRectMake(__x, __y, __w, __h)];
    
    //..Set Title
    self.__takePhotoOptionsView.__titleLabelStr = @"Add File";
    
    //.. Call Take Photo Method
    [self.__takePhotoOptionsView drawElements];
    
    //.. Add target on value changed
    [self.__takePhotoOptionsView addTarget:self action:@selector(updateSelectedImage:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:self.__takePhotoOptionsView];
}

//.. Add target on value changed
- (void) updateSelectedImage:(TakePhotoOptionsView *)__takePhotoView
{
    //cancel loading previous image for cell
    [[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:self.imageView];
    
    //load the image
    //self.imageView.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://192.232.214.244/~avanttec/rakesh/profile_pic.png"]];
    
    self.__imgView.image = __takePhotoView.__selectedIMAGE;
    
    self.__imgView.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0];
    self.__imgView.contentMode = UIViewContentModeScaleAspectFit;
    self.__imgView.layer.cornerRadius = 4;
    self.__imgView.layer.masksToBounds = YES;
    
    
    /*
     turning the image into a NSData object
     getting the image back out of the UIImageView
     setting the quality to 90
     */
    NSData *imageData = UIImageJPEGRepresentation(__takePhotoView.__selectedIMAGE, 90);
    [__appDelegate updateUserPic:imageData];
    
    
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
    
    /* Save to Core Data*/
    
    //  2
    
    [self.__userRecord setValue:[NSString stringWithFormat:@"%@_profile_img.jpg",__appDelegate.__uid] forKey:@"img"];
    
    
    //  3
    
    if (![__appDelegate.managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    
}

- (void) addUserName
{
    
    __x = 10;
    __y = __y + __h + 10;
    __w = self.view.frame.size.width - 20;
    __h = 20;
    
    self.__nameTextField.frame = CGRectMake(__x, __y, __w, __h);
    self.__nameTextField.backgroundColor = [UIColor clearColor];
    self.__nameTextField.text = [NSString stringWithFormat:@"%@",__appDelegate.__username];
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
    self.__statusTextView.text = [NSString stringWithFormat:@"%@",__appDelegate.__profileStatus];
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

- (void) addFollowersAndFollowing
{
    
    __x = 10;
    __y = __y + self.__statusTextView.frame.size.height;
    __w = self.view.frame.size.width - 20;
    __h = 30;
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(__x, __y, __w, __h)];
    
    textView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.__scrollView addSubview:textView];
    
    //[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[textView]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(textView)]];
    //[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[textView]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(textView)]];
    
    NSString *htmlString = @"<b>0</b> Followers   -   <b>0</b> Following </font>";
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    textView.attributedText = attributedString;
    
    textView.editable = FALSE;
    textView.scrollEnabled = FALSE;
    textView.selectable = FALSE;
    textView.textAlignment = NSTextAlignmentCenter;
    textView.font = [UIFont fontWithName:@"HelveticaNeue" size:13.0];
    textView.textColor = [UIColor colorWithRed:180.0/255.0 green:180.0/255.0 blue:180.0/255.0 alpha:1.0];
    
    __y = __y + __h + 10;
}


- (void) addPostsBtn
{
    __w = self.__scrollView.frame.size.width/2;
    __h = 44;
    
    __x = 0;
    
    self.__postsBtn.frame = CGRectMake(__x, __y, __w, __h);
    self.__postsBtn.backgroundColor = [UIColor colorWithRed:20.0/255.0 green:200.0/255.0 blue:240.0/255.0 alpha:1.0];
    
    [self.__postsBtn setTitle:@"Post" forState:UIControlStateNormal];
    
    [self.__postsBtn.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:14.0]];
    
    [self.__postsBtn addTarget:self action:@selector(postsBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.__scrollView addSubview:self.__postsBtn];
}

- (void) postsBtnClicked:(UIButton *)sender
{
    [self.__loadingView startAnimating];
    
    self.__isPostActive = TRUE;
    
    self.__postsBtn.backgroundColor = [UIColor colorWithRed:20.0/255.0 green:200.0/255.0 blue:240.0/255.0 alpha:1.0];
    
    self.__likesBtn.backgroundColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0];
    [self.__likesBtn.titleLabel setTextColor:[UIColor colorWithRed:150.0/255.0 green:150.0/255.0 blue:150.0/255.0 alpha:1.0]];
    
    [self performSelector:@selector(loadPostAndlikesData) withObject:nil afterDelay:0.2];
}

- (void) addLikesBtn
{
    __x = __w;
    
    self.__likesBtn.frame = CGRectMake(__x, __y, __w, __h);
    self.__likesBtn.backgroundColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0];
    
    [self.__likesBtn setTitle:@"Likes" forState:UIControlStateNormal];
    
    [self.__likesBtn.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:14.0]];
    [self.__likesBtn.titleLabel setTextColor:[UIColor colorWithRed:150.0/255.0 green:150.0/255.0 blue:150.0/255.0 alpha:1.0]];
    
    [self.__likesBtn addTarget:self action:@selector(likesBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.__scrollView addSubview:self.__likesBtn];
    
    __y = __y + __h + 5;
}

- (void) likesBtnClicked:(UIButton *)sender
{
    [self.__loadingView startAnimating];
    
    self.__isPostActive = FALSE;
    
    self.__likesBtn.backgroundColor = [UIColor colorWithRed:20.0/255.0 green:200.0/255.0 blue:240.0/255.0 alpha:1.0];
    
    self.__postsBtn.backgroundColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0];
    [self.__postsBtn.titleLabel setTextColor:[UIColor colorWithRed:150.0/255.0 green:150.0/255.0 blue:150.0/255.0 alpha:1.0]];
    
    [self performSelector:@selector(loadPostAndlikesData) withObject:nil afterDelay:0.2];
}


- (void) addPostsAndLikesHolder
{
    __x = 5;
    __w = self.view.frame.size.width - 10;
    __h = 150;
    
    self.__postsAndLikeHolder.frame = CGRectMake(__x, __y, __w, __h);
    self.__postsAndLikeHolder.backgroundColor = [UIColor clearColor];
    
    [self.__scrollView addSubview:self.__postsAndLikeHolder];
    
    //.. Add Activity loader
    
    /* Loading View */
    self.__loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    self.__loadingView.frame = CGRectMake(__x, __y, __w, __h);
    
    self.__loadingView.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.7];
    
    [self.__scrollView addSubview:self.__loadingView];
    
    
    [self.__loadingView startAnimating];
    [self performSelector:@selector(loadPostAndlikesData) withObject:nil afterDelay:0.2];
    
}

- (void) loadPostAndlikesData
{
    //.. First Delete all data
    for (UIView *__view in self.__postsAndLikeHolder.subviews) {
        [__view removeFromSuperview];
    }
    
    __x = 0;
    __y = 0;
    __w = self.__postsAndLikeHolder.frame.size.width;
    
    
    //. Add Data
    if (self.__isPostActive) {
        
        __h = 40;
        
        self.mojisArray = [[NSMutableArray alloc] init];
        
        self.mojisArray = [__appDelegate getSavedMojisData];
        
        //NSLog(@"self.mojisArray == %@",self.mojisArray);
        
        //NSArray *allKeys = [self.mojisArray allKeys];
        
        for (int i = 0; i < [self.mojisArray count]; i++) {
            UIView *__holderView = [[UIView alloc] initWithFrame:CGRectMake(__x, __y, __w, __h)];
            
            __holderView.backgroundColor = [UIColor clearColor];
            
            [self.__postsAndLikeHolder addSubview:__holderView];
            
            NSMutableDictionary *__dict = [self.mojisArray objectAtIndex:i];
            
            UIColor *textColor = [UIColor colorWithRed:0.0/255.0 green:90.0/255.0 blue:115.0/255.0 alpha:1.0];
            
            UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(10, 2, self.view.frame.size.width, 30)];
            name.text = [__dict valueForKey:@"name"];
            name.textColor = textColor;
            [name setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:15.0]];
            
            [__holderView addSubview:name];
            
            
            UIButton *btn = [[UIButton alloc] initWithFrame:__holderView.bounds];
            btn.backgroundColor = [UIColor clearColor];
            btn.frame = CGRectMake(0, 0, __holderView.frame.size.width, 60);
            [btn addTarget:self action:@selector(selectedCell:) forControlEvents:UIControlEventTouchUpInside];
            btn.property = [[NSMutableDictionary alloc] initWithObjects:@[[__dict valueForKey:@"data"], [__dict valueForKey:@"name"]] forKeys:@[@"mojiart", @"mojiName"]];
            [__holderView addSubview:btn];
            
            if (i < ([self.mojisArray count] - 1)) {
                //.. Add Border
                CALayer *grayBottomBorder = [CALayer layer];
                grayBottomBorder.frame = CGRectMake(0, (__holderView.frame.size.height - 0.5), __holderView.frame.size.width, 0.5);
                grayBottomBorder.backgroundColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0].CGColor;
                [__holderView.layer addSublayer:grayBottomBorder];
            }
            
            __y = __y + __h;
            
        }
        
        CGRect __frame = self.__postsAndLikeHolder.frame;
        __frame.size.height = __y;
        self.__postsAndLikeHolder.frame = __frame;
        
        self.__scrollView.contentSize = CGSizeMake(self.__scrollView.frame.size.width, (self.__postsAndLikeHolder.frame.origin.y + self.__postsAndLikeHolder.frame.size.height));
        
        
    }else{
        
        __h = 60;
        
        //. Likes Ids from local DB
        NSMutableArray *likes = [__appDelegate getLikes];
        NSString *keys = [__appDelegate arrayToJson:likes];
        
        //NSLog(@"keys == %@",keys);
        
        /* Likes Data from server */
        NSString *bodyData = [NSString stringWithFormat: @"a=getMojisBYIdsAction&keys=%@",keys];
        
        likesArray = [[NSMutableDictionary alloc] init];
        
        likesArray = [[__appDelegate makeRequest:bodyData] objectForKey:@"data"];
        
        //NSLog(@"likesArray = %@",likesArray);
        
        NSArray *allKeys = [likesArray allKeys];
        
        for (int i = 0; i < [likesArray count]; i++) {
            UIView *__holderView = [[UIView alloc] initWithFrame:CGRectMake(__x, __y, __w, __h)];
            
            __holderView.backgroundColor = [UIColor clearColor];
            
            [self.__postsAndLikeHolder addSubview:__holderView];
            
            id aKey = [allKeys objectAtIndex:i];
            NSMutableArray *moji = [likesArray objectForKey:aKey];
            
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
            
            NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString: [moji valueForKey:@"username"]];
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
            
            if (i < ([likesArray count] - 1)) {
                //.. Add Border
                CALayer *grayBottomBorder = [CALayer layer];
                grayBottomBorder.frame = CGRectMake(0, (__holderView.frame.size.height - 0.5), __holderView.frame.size.width, 0.5);
                grayBottomBorder.backgroundColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0].CGColor;
                [__holderView.layer addSublayer:grayBottomBorder];
            }
            
            __y = __y + __h;
            
        }
        
        CGRect __frame = self.__postsAndLikeHolder.frame;
        __frame.size.height = __y;
        self.__postsAndLikeHolder.frame = __frame;
        
        self.__scrollView.contentSize = CGSizeMake(self.__scrollView.frame.size.width, (self.__postsAndLikeHolder.frame.origin.y + self.__postsAndLikeHolder.frame.size.height + 100));
        
    }
    
    [self.__loadingView stopAnimating];
    
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
