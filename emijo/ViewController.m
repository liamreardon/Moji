//
//  ViewController.m
//  emijo
//
//  Created by 60Degree on 11/28/13.
//  Copyright (c) 2013 60Degree. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

@synthesize listingButton, activityView, loadingView, __btnsHolderView;


- (void) viewDidDisappear:(BOOL)animated
{
    
    //NSLog(@"ENTER");
    
//    if (SYSTEM_VERSION_LESS_THAN(@"7.0")) {
//        [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:20.0/255.0 green:200.0/255.0 blue:240.0/255.0 alpha:1.0]];
//    }else{
//        UINavigationBar* navigationBar = self.navigationController.navigationBar;
//        [navigationBar setBarTintColor:[UIColor colorWithRed:20.0/255.0 green:200.0/255.0 blue:240.0/255.0 alpha:1.0]];
//    }
    
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg_default.png"] forBarMetrics:UIBarMetricsDefault];
}

- (void) viewWillAppear:(BOOL)animated
{
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg.png"] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.title = @"Moji";
    
    UILabel *nav_titlelbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,40)];
    nav_titlelbl.text=@"Moji";
    
    nav_titlelbl.textAlignment=NSTextAlignmentCenter;
    [nav_titlelbl setTextColor:[UIColor whiteColor]];
    
    UIFont *lblfont=[UIFont fontWithName:@"Belinda" size:30];
    [nav_titlelbl setFont:lblfont];
    self.navigationItem.titleView = nav_titlelbl;
    
    
    __appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_bg.png"]];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    
    
    [self addNavigationLeftButton];
    [self addNavigationRightButton];
    
    //[self addRegisterScreen];
    //
    
//    UIImage *__bgImage = [UIImage imageNamed:@"home_bg.png"];
//    
//    UIImageView *__bgImgView = [[UIImageView alloc] initWithImage:__bgImage];
//    
//    __bgImgView.frame = CGRectMake(0, (self.navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height) - 20, __bgImage.size.width, __bgImage.size.height);
//    
//    [self.view addSubview:__bgImgView];
    
    
    /* Plus Sign button */

//    UIImage *addBtnImg = [UIImage imageNamed:@"add_nav_btn.png"];
//    UIButton *addButton = [[UIButton alloc] init];
//    
//    [addButton setImage:addBtnImg forState:UIControlStateNormal];
//    addButton.property = [[NSMutableDictionary alloc] initWithObjects:@[@"addEmoji"] forKeys:@[@"nibName"]];
//    [addButton addTarget:self action:@selector(menuBtnClicked:)  forControlEvents:UIControlEventTouchUpInside];
//    [addButton setFrame:CGRectMake(0, 0, 49, 30)];
//    UIBarButtonItem *actionBtn = [[UIBarButtonItem alloc] initWithCustomView:addButton];
//    self.navigationItem.rightBarButtonItem = actionBtn;
//    
//    
//    
//    UIImage *infoBtnImg = [UIImage imageNamed:@"info_icon.png"];
//    UIButton *infoButton = [[UIButton alloc] init];
//    [infoButton setImage:infoBtnImg forState:UIControlStateNormal];
//    infoButton.property = [[NSMutableDictionary alloc] initWithObjects:@[@"infoPage"] forKeys:@[@"nibName"]];
//    [infoButton addTarget:self action:@selector(menuBtnClicked:)  forControlEvents:UIControlEventTouchUpInside];
//    [infoButton setFrame:CGRectMake(0, 0, 49, 49)];
//    UIBarButtonItem *infoActionBtn = [[UIBarButtonItem alloc] initWithCustomView:infoButton];
//    self.navigationItem.leftBarButtonItem = infoActionBtn;
    
    NSMutableDictionary *__dict = [NSMutableDictionary dictionary];
    
    __dict = [__appDelegate getUserData];
    
    //NSLog(@"User Id == %@",[__dict valueForKey:@"id"]);
    
    if (![__dict valueForKey:@"id"]) {
        [self addLoginScreen];
    }else{
        __appDelegate.__sessionToken = [__dict valueForKey:@"sessionToken"];
        __appDelegate.__uid = [__dict valueForKey:@"id"];
        
        if ([[NSString stringWithFormat:@"%@",[[__dict valueForKey:@"name"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]] isEqualToString:@""]) {
            __appDelegate.__username = @"Add Username";
        }else{
            __appDelegate.__username = [__dict valueForKey:@"name"];
        }
        
        
        if ([[NSString stringWithFormat:@"%@",[[__dict valueForKey:@"status"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]] isEqualToString:@""]) {
            __appDelegate.__profileStatus = @"Your status...";
        }else{
            __appDelegate.__profileStatus = [__dict valueForKey:@"status"];
        }
        
        
        __appDelegate.__firstname = [__dict valueForKey:@"firstname"];
        __appDelegate.__lastname = [__dict valueForKey:@"lastname"];
        __appDelegate.__email = [__dict valueForKey:@"email"];
        
        __appDelegate.__profilePic = [NSString stringWithFormat:@"http://192.232.214.244/~avanttec/animoji/assets/images/%@",[__dict valueForKey:@"img"]];
    }
    
    [self addBtnsHolderView];
}

- (void) addNavigationLeftButton
{
    //.. Add Custom left navigation Button
    UIButton *__leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    //.. Button Images
    UIImage *__normalLeft = [UIImage imageNamed:@"info_icon.png"];
    UIImage *__highlightedLeft = [UIImage imageNamed:@"info_icon.png"];
    
    // Set the location (x,y) and size (width,height) of the button
    __leftButton.frame = CGRectMake(0, 0, __normalLeft.size.width, __normalLeft.size.height);
    __leftButton.property = [[NSMutableDictionary alloc] initWithObjects:@[@"InfoView"] forKeys:@[@"nibName"]];
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
    NSMutableDictionary *__dict = sender.property;
    NSString *nibName = [__dict objectForKey:@"nibName"];
    UIViewController* object = (UIViewController*)[[NSClassFromString(nibName) alloc] initWithNibName:nibName bundle:nil];
    [self.navigationController pushViewController:object animated:YES];
}

- (void) addNavigationRightButton
{
    //.. Add Custom left navigation Button
    UIButton *__rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    //.. Button Images
    UIImage *__normalRight = [UIImage imageNamed:@"add_nav_btn.png"];
    UIImage *__highlightedRight = [UIImage imageNamed:@"add_nav_btn.png"];
    
    // Set the location (x,y) and size (width,height) of the button
    __rightButton.frame = CGRectMake(0, 0, __normalRight.size.width, __normalRight.size.height);
    __rightButton.property = [[NSMutableDictionary alloc] initWithObjects:@[@"addEmoji"] forKeys:@[@"nibName"]];
    
    // Set the button's background to an image
    [__rightButton setBackgroundImage:__normalRight forState:UIControlStateNormal];
    [__rightButton setBackgroundImage:__highlightedRight forState:UIControlStateHighlighted];
    
    // Add the target-action for the touch event
    [__rightButton addTarget:self action:@selector(rightButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:__rightButton];
    [self.navigationItem setRightBarButtonItem:backButtonItem animated:NO];
}

- (void) rightButtonClicked:(UIButton *)sender
{
    NSMutableDictionary *__dict = sender.property;
    NSString *nibName = [__dict objectForKey:@"nibName"];
    UIViewController* object = (UIViewController*)[[NSClassFromString(nibName) alloc] initWithNibName:nibName bundle:nil];
    [self.navigationController pushViewController:object animated:YES];
}

- (void) addBtnsHolderView
{
    __x = 0;
    __y = self.navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height;
    __w = self.view.frame.size.width;
    __h = self.view.frame.size.height- __y;
    
    self.__btnsHolderView = [[UIView alloc] init];
    self.__btnsHolderView.frame = CGRectMake(__x, __y, __w, __h);
    self.__btnsHolderView.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
    
    [self.view addSubview:self.__btnsHolderView];
    
    NSArray *__titlesArr = [[NSArray alloc] initWithObjects:@"Top \n Charts", @"Browse", @"Submit \n to App", @"Likes", @"Saved", @"Your \n Profile", @"Stickers", @"Cool \n Fonts", @"Word \n Maker", nil];
    
    NSArray *__bgImgsArr = [[NSArray alloc] initWithObjects:@"top_chart.png", @"browse.png", @"submit_to_app.png", @"likes.png", @"saved.png", @"profile.png", @"stickers.png", @"cool_fonts.png", @"word_maker.png", nil];
    
    NSArray *__nibsArr = [[NSArray alloc] initWithObjects:@"topCharts", @"browse", @"addEmoji", @"LikesView", @"savedMojis", @"UserProfile", @"StickerCategoriesView", @"coolFonts", @"wordMaker", nil];
    
    
    UIImage *__bgImg = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[__bgImgsArr objectAtIndex:0]]];
    
    __padding = 0;
    
    __w = __bgImg.size.width; //(self.view.frame.size.width - (__padding * 4))/3;
    __h = __bgImg.size.height; //;
    __x = 8;
    __y = 10;
    
    
    for (int i = 0; i < [__titlesArr count]; i++) {
        
        UIImage *__bgImg = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[__bgImgsArr objectAtIndex:i]]];
        
        __w = __bgImg.size.width; //(self.view.frame.size.width - (__padding * 4))/3;
        __h = __bgImg.size.height; //;
        
        //NSLog(@"__w == %f",__w);
        
        UIButton * __btn = [[UIButton alloc] initWithFrame:CGRectMake(__x, __y, __w, __h)];
        __btn.tag = i;
//        __btn.layer.cornerRadius = __w/2;
//        [__btn.titleLabel setTextAlignment:NSTextAlignmentCenter];
//        [__btn.titleLabel setLineBreakMode:NSLineBreakByWordWrapping];
//        [__btn setTitle:[NSString stringWithFormat:@"%@", [__titlesArr objectAtIndex:i]] forState:UIControlStateNormal ];
        __btn.property = [[NSMutableDictionary alloc] initWithObjects:@[[NSString stringWithFormat:@"%@", [__nibsArr objectAtIndex:i]]] forKeys:@[@"nibName"]];
       
//        __btn.layer.borderColor = [UIColor colorWithRed:20.0/255.0 green:200.0/255.0 blue:240.0/255.0 alpha:1.0].CGColor;
//        __btn.layer.borderWidth = 5.0;
//        
//        [__btn setAlpha:0.7];
        
        __btn.backgroundColor = [UIColor colorWithPatternImage:__bgImg];
        
        [self.__btnsHolderView addSubview:__btn];
        //..
        [__btn addTarget:self action:@selector(menuBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
//        if (i<3) {
//            __btn.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:0.0/255.0 alpha:1.0];
//            [__btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        }else if (i>2 && i<6) {
//            __btn.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0];
//            [__btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        }else{
//            __btn.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:255.0/255.0 blue:0.0/255.0 alpha:1.0];
//            [__btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        }
        
        //.. increase __y pos
        
        if (i > 0) {
            if (((i+1) % 3) == 0) {
                __y = __y + __h + 10;
                __x = 8;
            }else{
                __x = __x + __w + __padding;
            }
        }else{
            __x = __x + __padding + __w;
        }
    }
    
    
    /* Extras Button*/
    UIImage *__extraImg = [UIImage imageNamed:@"extras.png"];
    
    
    __w = self.view.frame.size.width;
    __h = __extraImg.size.height;
    
    __x = 0;
    __y = __appDelegate.window.frame.size.height - (__h + 0);
    
    UIView *__extraHolderView = [[UIView alloc] initWithFrame:CGRectMake(__x, __y, __w, __h)];
    
    __extraHolderView.backgroundColor = [UIColor colorWithRed:205.0/255.0 green:205.0/255.0 blue:205.0/255.0 alpha:0.0];
    
    [self.view addSubview:__extraHolderView];
    
    
    
    
    UIColor *__Yellow = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:0.0/255.0 alpha:0.5];
    UIColor *__Blue = [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:255.0/255.0 alpha:0.5];
    UIColor *__Green = [UIColor colorWithRed:0.0/255.0 green:255.0/255.0 blue:0.0/255.0 alpha:0.5];
    UIColor *__Orange = [UIColor colorWithRed:255.0/255.0 green:127.0/255.0 blue:0.0/255.0 alpha:0.5];
    UIColor *__Violet = [UIColor colorWithRed:143.0/255.0 green:0.0/255.0 blue:255.0/255.0 alpha:0.5];
    UIColor *__Red = [UIColor colorWithRed:255.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.5];
    
    
    NSArray *__colorsArr = [[NSArray alloc] initWithObjects:__Yellow, __Blue, __Green, __Orange, __Violet, __Red, nil];
    
    int __colorCout = 0;
    
    
    __h = __extraHolderView.frame.size.height/2;
    __w = __h;
    
    __x = 0;
    __y = __h;
    
    for (int i = 0; i < 100; i++) {
        UIView *__colorView = [[UIView alloc] initWithFrame:CGRectMake(__x, __y, __w, __h)];
        
        UIColor *__color = [__colorsArr objectAtIndex:__colorCout];
        
        __colorView.backgroundColor = __color;
        
        [__extraHolderView addSubview:__colorView];
        
        if ((__x + __h) >= self.view.frame.size.width) {
            break;
        }else{
            
            __colorCout++;
            if (__colorCout >= [__colorsArr count]) {
                __colorCout = 0;
            }
            //.. Increase __x
            __x = __x + __w;
        }
        
        
    }
    
    
    __w = __extraImg.size.width;
    __h = __extraImg.size.height;
    
    __x = (self.__btnsHolderView.frame.size.width - __w)/2;
    __y = 0;
    
    
    UIButton * extraBtn = [[UIButton alloc] initWithFrame:CGRectMake(__x, __y, __w, __h)];
    extraBtn.backgroundColor = [UIColor clearColor];
    [extraBtn setImage:__extraImg forState:UIControlStateNormal];
    [extraBtn setImage:__extraImg forState:UIControlStateHighlighted];
    [__extraHolderView addSubview:extraBtn];
    
    [extraBtn addTarget:self action:@selector(extraBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void) extraBtnClicked:(UIButton *)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"There are no new extras at this time, please check back soon!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

- (void) menuBtnClicked:(UIButton *)sender
{
    if ([sender.property isEqual:@""]) {
        //.. Don't have any view
    }else{
        NSMutableDictionary *__dict = sender.property;
        NSString *nibName = [__dict objectForKey:@"nibName"];
        UIViewController* object = (UIViewController*)[[NSClassFromString(nibName) alloc] initWithNibName:nibName bundle:nil];
        [self.navigationController pushViewController:object animated:YES];
    }
    
    //NSLog(@"sender == %d",sender.tag);
}

- (void) addRegisterScreen
{
    //[[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    UserRegisterView *__userRegisterView = [[UserRegisterView alloc] initWithFrame:__appDelegate.window.bounds];
    
    __userRegisterView.tag = 500123;
    
    [__userRegisterView drawElements];
    
    [__userRegisterView addTarget:self action:@selector(userRegisterClicked:) forControlEvents:UIControlEventValueChanged];
    
    [__appDelegate.window addSubview:__userRegisterView];
}

- (void) userRegisterClicked:(UserRegisterView *)sender
{
    //NSLog(@"%d",sender.__isRegisterClicked);
    
    if (sender.__isRegisterClicked)
    {
        [self removeRegisterScreen];
    }else if (sender.__isBackClicked)
    {
        [self removeRegisterScreen];
        [self addLoginScreen];
    }
    
}

- (void) removeRegisterScreen
{
    //[[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    for (UserRegisterView *__userRegisterView in __appDelegate.window.subviews) {
        if (__userRegisterView.tag == 500123) {
            [__userRegisterView removeFromSuperview];
            break;
        }
    }
}

- (void) addLoginScreen
{
    //[[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    LoginView *__loginView = [[LoginView alloc] initWithFrame:__appDelegate.window.bounds];
    
    __loginView.tag = 500124;
    
    [__loginView drawElements];
    
    [__loginView addTarget:self action:@selector(newUserClicked:) forControlEvents:UIControlEventValueChanged];
    
    [__appDelegate.window addSubview:__loginView];
    
}

- (void) newUserClicked:(LoginView *)sender
{
    
    if (sender.__newUserClicked) {
        [self removeLoginScreen];
        [self addRegisterScreen];
    }else{
        NSMutableDictionary *__dict = [NSMutableDictionary dictionary];
        
        __dict = [__appDelegate getUserData];
        
        //NSLog(@"User Id == %@",[__dict valueForKey:@"id"]);
        
        if ([__dict valueForKey:@"id"]) {
            
            __appDelegate.__sessionToken = [__dict valueForKey:@"sessionToken"];
            __appDelegate.__uid = [__dict valueForKey:@"id"];
            
            if ([[NSString stringWithFormat:@"%@",[[__dict valueForKey:@"name"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]] isEqualToString:@""]) {
                __appDelegate.__username = @"Add Username";
            }else{
                __appDelegate.__username = [__dict valueForKey:@"name"];
            }
            
            
            if ([[NSString stringWithFormat:@"%@",[[__dict valueForKey:@"status"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]] isEqualToString:@""]) {
                __appDelegate.__profileStatus = @"Your status...";
            }else{
                __appDelegate.__profileStatus = [__dict valueForKey:@"status"];
            }
            
            __appDelegate.__firstname = [__dict valueForKey:@"firstname"];
            __appDelegate.__lastname = [__dict valueForKey:@"lastname"];
            __appDelegate.__email = [__dict valueForKey:@"email"];
            
            __appDelegate.__profilePic = [NSString stringWithFormat:@"http://192.232.214.244/~avanttec/animoji/assets/images/%@",[__dict valueForKey:@"img"]];
            
            [self removeLoginScreen];
        }
    }
}

- (void) removeLoginScreen
{
    //[[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    for (LoginView *__loginView in __appDelegate.window.subviews) {
        if (__loginView.tag == 500124) {
            [__loginView removeFromSuperview];
            break;
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
