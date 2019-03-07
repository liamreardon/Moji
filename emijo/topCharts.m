//
//  topCharts.m
//  emijo
//
//  Created by 60Degree on 12/6/13.
//  Copyright (c) 2013 60Degree. All rights reserved.
//

#import "topCharts.h"


#define kLabelAllowance 40.0f
#define kStarViewHeight 20.0f
#define kStarViewWidth 45.0f
#define kLeftPadding 5.0f


@interface topCharts ()

@end

@implementation topCharts

@synthesize starviewR, loggedInUserId;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        __appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [__appDelegate.__navBarVC setNavigationBarHidden:NO animated:YES ];
    }
    return self;
}



@synthesize centerWidth, topCharts, __loadingView, w, tabs, dailyBtn, monthlyBtn, alltimeBtn;


- (void) viewWillAppear:(BOOL)animated
{
    
    if(self.selectCat==true && [self.selectCatName length] > 0){
        self.title = [NSString stringWithFormat:@"%@",self.selectCatName];
    } else {
        self.title = @"Top Charts";
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
    
    self.__elementsHolder = [[UIView alloc] init];
    [self addNavigationLeftButton];
   
    __x = 0;
    __y = self.navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height;
    __w = self.view.frame.size.width;
    __h = self.view.frame.size.height- __y;
    
    
    self.__elementsHolder.frame = CGRectMake(__x, __y, __w, __h);
    self.__elementsHolder.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:self.__elementsHolder];
    
    
    /* Loading View */
    self.__loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    self.__loadingView.frame = self.view.bounds;
    
    self.__loadingView.backgroundColor = [UIColor colorWithRed:20.0/255.0 green:200.0/255.0 blue:240.0/255.0 alpha:0.5];
    
    [self.__loadingView startAnimating];
    
    [self.view addSubview:self.__loadingView];
    
    
    [self performSelector:@selector(loadViewData) withObject:Nil afterDelay:0.2];
    
}

- (void) loadViewData
{
    loggedInUserId = 1;
    
    w = self.view.frame.size.width;
    float h = self.view.frame.size.height;
    
    centerWidth = w-60;
    
    if (![[NSString stringWithFormat:@"%@",self.selectCatName] isEqualToString:@"Default"]) {
        
        UIColor *tabBorderColor = [UIColor colorWithRed:204.0/255.0 green:222.0/255.0 blue:227.0/255.0 alpha:1.0];
        tabs = [[UIView alloc] initWithFrame:CGRectMake(0, 5, w, 42)];
        
        [self.__elementsHolder addSubview:tabs];
        
        UIColor *txtColor = [UIColor colorWithRed:0.0/255.0 green:90.0/255.0 blue:115.0/255.0 alpha:1.0];
        float tabWidth = __w/3;
        float tabHeight = tabs.frame.size.height;
        
        //UIColor *tabBackgroundColorHighLighted = [UIColor colorWithRed:0.0/255.0 green:92.0/255.0 blue:115.0/255.0 alpha:1.0];
        
        dailyBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, tabWidth, tabHeight)];
        [dailyBtn setTitle:@"Today" forState:UIControlStateNormal];
        dailyBtn.layer.borderColor = tabBorderColor.CGColor;
        dailyBtn.layer.borderWidth = 0.5;
        [dailyBtn setTitleColor:txtColor forState:UIControlStateNormal];
        dailyBtn.tag = 0;
        [dailyBtn addTarget:self action:@selector(tabChanged:) forControlEvents:UIControlEventTouchUpInside];
        [tabs addSubview:dailyBtn];
        
        monthlyBtn = [[UIButton alloc] initWithFrame:CGRectMake(tabWidth, 0, tabWidth, tabHeight)];
        [monthlyBtn setTitle:@"Monthly" forState:UIControlStateNormal];
        monthlyBtn.layer.borderColor = tabBorderColor.CGColor;
        monthlyBtn.layer.borderWidth = 0.5;
        [monthlyBtn setTitleColor:txtColor forState:UIControlStateNormal];
        monthlyBtn.tag = 1;
        [monthlyBtn addTarget:self action:@selector(tabChanged:) forControlEvents:UIControlEventTouchUpInside];
        [tabs addSubview:monthlyBtn];
        
        //    monthlyBtn = [[UIButton alloc] initWithFrame:CGRectMake(tabWidth, 0, tabWidth, tabHeight)];
        //    [monthlyBtn setTitle:@"Monthly" forState:UIControlStateNormal];
        //    monthlyBtn.backgroundColor = tabBackgroundColorHighLighted;
        //    monthlyBtn.layer.borderColor = tabBackgroundColorHighLighted.CGColor;
        //    monthlyBtn.layer.borderWidth = 0.5;
        //    monthlyBtn.tag = 1;
        //    [monthlyBtn addTarget:self action:@selector(tabChanged:) forControlEvents:UIControlEventTouchUpInside];
        //    [monthlyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //    [tabs addSubview:monthlyBtn];
        
        
        alltimeBtn = [[UIButton alloc] initWithFrame:CGRectMake(tabWidth*2, 0, tabWidth, tabHeight)];
        [alltimeBtn setTitle:@"All Time" forState:UIControlStateNormal];
        alltimeBtn.layer.borderColor = tabBorderColor.CGColor;
        alltimeBtn.layer.borderWidth = 0.5;
        [alltimeBtn setTitleColor:txtColor forState:UIControlStateNormal];
        alltimeBtn.tag = 2;
        [alltimeBtn addTarget:self action:@selector(tabChanged:) forControlEvents:UIControlEventTouchUpInside];
        [tabs addSubview:alltimeBtn];
    }
    
    /* Tabs */
    self.topCharts = [[UIScrollView alloc] initWithFrame:CGRectMake(0, tabs.frame.size.height+10, w, h-100)];
    self.topCharts.backgroundColor = [UIColor clearColor];
    [self.__elementsHolder addSubview:self.topCharts];
    
    
    /* Get Top charts */
    NSString *bodyData;
    
    if(self.selectCat == true && [self.selectCatName length] > 0){
        
        if (![[NSString stringWithFormat:@"%@",self.selectCatName] isEqualToString:@"Default"]) {
            bodyData = [NSString stringWithFormat: @"a=topChartsAction&selType=monthly&catName=%@",self.selectCatName];
        }else{
            bodyData = [NSString stringWithFormat: @"a=topChartsAction&selType=all&catName=%@",self.selectCatName];
        }
    } else {
        bodyData = [NSString stringWithFormat: @"a=topChartsAction&selType=monthly"];
    }
    
//    NSMutableDictionary *res = [__appDelegate makeRequest:bodyData];
//    NSMutableArray *mojis = [res objectForKey:@"data"];
//    
//    float top = [self topChartsContent:mojis];
//    
//    
//    [self.topCharts setContentSize:CGSizeMake(w, top + 350)];
    
    
    [self performSelector:@selector(loadData:) withObject:[NSString stringWithFormat:@"%@",bodyData] afterDelay:0.2];
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

- (void) loadData:(NSString *)__bodyData
{
    /* Get Top charts */
    //NSString *bodyData = [NSString stringWithFormat: @"a=topChartsAction&selType=monthly"];
    NSMutableDictionary *res = [__appDelegate makeRequest:__bodyData];
    
    NSMutableArray *mojis = [res objectForKey:@"data"];
    float top = [self topChartsContent:mojis];
    [self.topCharts setContentSize:CGSizeMake(w, top + 350)];
    
    [self.__loadingView stopAnimating];
}

-(void)tabChanged: (id) sender{
    UIColor *tabBackgroundColorHighLighted = [UIColor colorWithRed:0.0/255.0 green:92.0/255.0 blue:115.0/255.0 alpha:1.0];
    UIColor *tabBorderColor = [UIColor colorWithRed:204.0/255.0 green:222.0/255.0 blue:227.0/255.0 alpha:1.0];
    
    
    [self.__loadingView startAnimating];
    
    [self.topCharts.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UIButton *selectedBtn = sender;
    NSString *bodyData = [NSString alloc];
    if(selectedBtn.tag==0) {
        [monthlyBtn setTitleColor:tabBackgroundColorHighLighted forState:UIControlStateNormal];
        monthlyBtn.backgroundColor = [UIColor clearColor];
        monthlyBtn.layer.borderColor = tabBorderColor.CGColor;
        [alltimeBtn setTitleColor:tabBackgroundColorHighLighted forState:UIControlStateNormal];
        alltimeBtn.backgroundColor = [UIColor clearColor];
        alltimeBtn.layer.borderColor = tabBorderColor.CGColor;
        
        [dailyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        dailyBtn.backgroundColor = tabBackgroundColorHighLighted;
        dailyBtn.layer.borderColor = tabBackgroundColorHighLighted.CGColor;
        
        
        bodyData = [NSString stringWithFormat: @"a=topChartsAction&selType=daily"];
    } else if (selectedBtn.tag==1) {
        
        [dailyBtn setTitleColor:tabBackgroundColorHighLighted forState:UIControlStateNormal];
        dailyBtn.backgroundColor = [UIColor clearColor];
        dailyBtn.layer.borderColor = tabBorderColor.CGColor;
        [alltimeBtn setTitleColor:tabBackgroundColorHighLighted forState:UIControlStateNormal];
        alltimeBtn.backgroundColor = [UIColor clearColor];
        alltimeBtn.layer.borderColor = tabBorderColor.CGColor;
        
        
        [monthlyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        monthlyBtn.backgroundColor = tabBackgroundColorHighLighted;
        monthlyBtn.layer.borderColor = tabBackgroundColorHighLighted.CGColor;
        
        bodyData = [NSString stringWithFormat: @"a=topChartsAction&selType=monthly"];
    } else {
        
        [monthlyBtn setTitleColor:tabBackgroundColorHighLighted forState:UIControlStateNormal];
        monthlyBtn.backgroundColor = [UIColor clearColor];
        monthlyBtn.layer.borderColor = tabBorderColor.CGColor;
        [dailyBtn setTitleColor:tabBackgroundColorHighLighted forState:UIControlStateNormal];
        dailyBtn.backgroundColor = [UIColor clearColor];
        dailyBtn.layer.borderColor = tabBorderColor.CGColor;
        
        [alltimeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        alltimeBtn.backgroundColor = tabBackgroundColorHighLighted;
        alltimeBtn.layer.borderColor = tabBackgroundColorHighLighted.CGColor;
        bodyData = [NSString stringWithFormat: @"a=topChartsAction&selType=all"];
    }
    
    [self performSelector:@selector(TappedLoadViewData:) withObject:[NSString stringWithFormat:@"%@",bodyData] afterDelay:0.2];
}

- (void) TappedLoadViewData:(NSString *)bodyData
{
    float top = 0;
    
    NSMutableDictionary *res = [__appDelegate makeRequest:bodyData];
    NSMutableArray *mojis = [res objectForKey:@"data"];
    top = [self topChartsContent:mojis];
    [self.topCharts setContentSize:CGSizeMake(centerWidth, top + 350)];
    
    [self.__loadingView stopAnimating];
}

-(float)topChartsContent  : (NSMutableArray *)mojis
{
    
    for (UIView *__view in self.topCharts.subviews) {
        [__view removeFromSuperview];
    }
    
    int i = 1;
    float top = 0;
    
    if ([mojis count] > 0) {
        //NSLog(@"%f",top);
        NSMutableArray *likes = [__appDelegate getLikes];
        
        NSArray *likeIds = likes;
        
        //NSLog(@" likeIds = %@",likeIds);
        
        NSString *bodyData = [NSString stringWithFormat: @"a=getRatedMojisByUserAction&userId=1"];
        NSMutableDictionary *res = [__appDelegate makeRequest:bodyData];
        NSArray *rated = [res objectForKey:@"data"];
        
        
        for(NSMutableArray *moji in mojis){
            
            float mojiHeight = 250;
            
            if(i==1) {
                top = 0;
            } else {
                top = top + 270;
            }
            
            float nameBarHeight = 50;
            float contentHeight = 150;
            float userViewHeight = 30;
            
            UIColor *topBarColor = [UIColor colorWithRed:22.0/225.0 green:200.0/225.0 blue:240.0/255.0 alpha:0.4];
            UIColor *bottomBarColor = [UIColor colorWithRed:185.0/225.0 green:238.0/225.0 blue:251.0/255.0 alpha:0.5];
            
            //. Single Moji View
            UIView *mojiView = [[UIView alloc] initWithFrame:CGRectMake(0, top, w, mojiHeight)];
            [self.topCharts addSubview:mojiView];
            
            
            //. moji name and rating bar
            
            
            float nameY = mojiView.bounds.origin.y;
            UIView *nameBar = [[UIView alloc] initWithFrame:CGRectMake(0, nameY, w, nameBarHeight)];
            nameBar.layer.borderColor = [UIColor grayColor].CGColor;
            nameBar.backgroundColor = topBarColor;
            [mojiView addSubview:nameBar];
            
            UIColor *txtColor = [UIColor colorWithRed:0.0/255.0 green:90.0/255.0 blue:115.0/255.0 alpha:1.0];
            
            UILabel *nl = [[UILabel alloc] initWithFrame:CGRectMake(20, nameY-5, self.view.frame.size.width - (138 + 20), nameBarHeight)];
            nl.backgroundColor = [UIColor clearColor];
            nl.text = [NSString stringWithFormat:@"%d) %@",i,[moji valueForKey:@"name"]];
            [nl setTextAlignment:NSTextAlignmentLeft];
            nl.font = [UIFont fontWithName:@"HelveticaNeue" size:14.0];
            nl.textColor = txtColor;
            [nameBar addSubview:nl];
            
            
            //Watch
            
            UIImage *__watchImg = [UIImage imageNamed:@"watch_icon.png"];
            
            UIImageView *watch = [[UIImageView alloc] init];
            watch.image = __watchImg;
            watch.frame = CGRectMake(23, nameY + 33, __watchImg.size.width, __watchImg.size.height);
            //watch.backgroundColor = [UIColor redColor];
            [nameBar addSubview:watch];
            
            //Time Ago
            
            //.TIme diffrence Calculation
            
            // Convert string to date object
            NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
            [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            
            NSDate *date = [inputFormatter dateFromString:[moji valueForKey:@"created"]];
            
            
            NSDate* date2 = [NSDate date];
            NSTimeInterval distanceBetweenDates = [date timeIntervalSinceDate:date2];
            
            NSString *diff = [__appDelegate timeIntervalToStringWithInterval:distanceBetweenDates];
            
            UILabel *timeAgo = [[UILabel alloc] initWithFrame:CGRectMake(36, nameY + 30, 70, 15)];
            timeAgo.text = [NSString stringWithFormat:@"%@ by: ",diff];
            timeAgo.textColor = [UIColor colorWithRed:152.0/255.0 green:152.0/255.0 blue:152.0/255.0 alpha:1.0];
            timeAgo.backgroundColor = [UIColor clearColor];
            timeAgo.font = [UIFont fontWithName:@"HelveticaNeue" size:8.0];
            [nameBar addSubview:timeAgo];
            
            /* TIME VIEW ENDS*/
            
            /* user detail View*/
            
            NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString: [moji valueForKey:@"username"]];
            [attributeString addAttribute:NSUnderlineStyleAttributeName
                                    value:[NSNumber numberWithInt:1]
                                    range:(NSRange){0,[attributeString length]}];
            
            UILabel *userText = [[UILabel alloc] initWithFrame:CGRectMake(36 + 45, nameY + 25, 200, 25)];
            userText.backgroundColor = [UIColor clearColor];
            userText.attributedText = [attributeString copy];
            userText.textColor = txtColor;
            userText.font = [UIFont fontWithName:@"HelveticaNeue" size:10.0];
            [nameBar addSubview:userText];
            
            UIButton *__userBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            __userBtn.frame = CGRectMake(36 + 45, nameY + 30, 85, 20);
            __userBtn.backgroundColor = [UIColor clearColor];
            __userBtn.property = [[NSMutableDictionary alloc] initWithObjects:@[[moji valueForKey:@"user_id"]] forKeys:@[@"user_id"]];
            
            [__userBtn addTarget:self action:@selector(userBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            [nameBar addSubview:__userBtn];
            
            /* user detail View ends*/
            
            int totalRating = [[moji valueForKey:@"total_rating"] intValue];
            
            int __starWidth = kStarViewWidth+kLabelAllowance+kLeftPadding;
            
            StarRatingView* starview = [[StarRatingView alloc]initWithFrame:CGRectMake(self.view.frame.size.width - (__starWidth + 60), nameY+13, __starWidth, kStarViewHeight) andRating:totalRating withLabel:NO animated:YES selectedColor:txtColor];
            
            UIControl *mask = [[UIControl alloc] init];
            [mask addSubview:starview];
            [nameBar addSubview:mask];
            
            UILabel *ratingLabel = [[UILabel alloc] initWithFrame:CGRectMake(starview.frame.origin.x + starview.frame.size.width + 2, nameY+11, 60, 20)];
            ratingLabel.text = [NSString stringWithFormat:@"%@ ratings", [moji valueForKey:@"total_users"]];
            ratingLabel.backgroundColor = [UIColor clearColor];
            ratingLabel.textColor = [UIColor colorWithRed:152.0/255.0 green:152.0/255.0 blue:152.0/255.0 alpha:1.0];
            ratingLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:9.0];
            [nameBar addSubview:ratingLabel];
            
            //. Moji main view
            float contentY = nameY + nameBarHeight + 10;
            
            NSString *input = [moji valueForKey:@"data"];
            NSString* esc1 = [input stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
            NSString* esc2 = [esc1 stringByReplacingOccurrencesOfString:@"\"" withString:@""];
            NSString* quoted = [[@"\"" stringByAppendingString:esc2] stringByAppendingString:@"\""];
            NSData* data = [quoted dataUsingEncoding:NSUTF8StringEncoding];
            
            NSString *error;
            
            NSString* unesc = [NSPropertyListSerialization propertyListFromData:data
                                                               mutabilityOption:NSPropertyListImmutable format:NULL
                                                               errorDescription:&error];
            
            if (error) {
                NSLog(@"%@", error);
            }
            
            assert([unesc isKindOfClass:[NSString class]]);
            
            UIView *mojiContent = [[UIView alloc] initWithFrame:CGRectMake((w-centerWidth)/2, contentY, centerWidth, contentHeight)];
            [mojiView addSubview:mojiContent];
            UITextView *cl = [[UITextView alloc] initWithFrame:CGRectMake(0, mojiContent.bounds.origin.y, centerWidth, contentHeight)];
            cl.backgroundColor = [UIColor clearColor];
            cl.text = unesc;
            cl.editable = NO;
            [mojiContent addSubview:cl];
            
            //. User, time view
            float userViewY = contentY + contentHeight;
            UIView *userView = [[UIView alloc] initWithFrame:CGRectMake(0, userViewY, w, userViewHeight)];
            userView.backgroundColor = bottomBarColor;
            [mojiView addSubview:userView];
            
            
            if (![[NSString stringWithFormat:@"%@",self.selectCatName] isEqualToString:@"Default"]) {
                RatingView *__ratingView = [[RatingView alloc] initWithFrame:CGRectMake(15, 5, 150, 20)];
                [__ratingView drawElements:[[moji valueForKey:@"id"] intValue] ratedMojis:rated];
                [userView addSubview:__ratingView];
            }
            
            /* Folder View */
            UIView *folderView  = [[UIView alloc] initWithFrame:CGRectMake(220, userView.bounds.origin.y, 70, userViewHeight)];
            [userView addSubview:folderView];
            
            
            //Heart
            UIImage *heartIcon = [UIImage imageNamed:@"heart_icon.png"];
            UIImage *heartIconHighLighted = [UIImage imageNamed:@"heart_filled.png"];
            UIButton *heart = [UIButton buttonWithType:UIButtonTypeCustom];
            heart.frame = CGRectMake(0, (folderView.frame.size.height - heartIcon.size.height)/2, heartIcon.size.width, heartIcon.size.height);
            heart.tag = [[moji valueForKey:@"id"] intValue];
            
            //NSLog(@"likeIds == %@ :: id == %@",likeIds,[moji valueForKey:@"id"]);
            
            //NSLog(@"likeIds == %hhd",[likeIds containsObject:[moji valueForKey:@"id"]]);
            
            
            
            BOOL __isAlreadyLiked = FALSE;
            
            for (int r = 0; r < [likeIds count]; r++) {
                if ([[NSString stringWithFormat:@"%@",[likeIds objectAtIndex:r]] isEqualToString:[NSString stringWithFormat:@"%@",[moji valueForKey:@"id"]]]) {
                    __isAlreadyLiked = TRUE;
                    break;
                }
            }
            
            if (__isAlreadyLiked) {
                [heart setImage:heartIconHighLighted forState:UIControlStateNormal];
                [heart addTarget:self action:@selector(alreadyLiked) forControlEvents:UIControlEventTouchUpInside];
            }else{
                [heart setImage:heartIcon forState:UIControlStateNormal];
                [heart addTarget:self action:@selector(likeIt:) forControlEvents:UIControlEventTouchUpInside];
            }
            
            [folderView addSubview:heart];
            
            //Copy to clip
            UIImage *__folderImage = [UIImage imageNamed:@"folder_icon.png"];
            
            UIButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [aButton setImage:__folderImage forState:UIControlStateNormal];
            aButton.property = [[NSMutableDictionary alloc] initWithObjects:@[unesc] forKeys:@[@"text"]];
            [aButton addTarget:self action:@selector(copyToClipBoard:) forControlEvents:UIControlEventTouchUpInside];
            aButton.frame = CGRectMake(heart.bounds.size.width + 10, (folderView.frame.size.height - __folderImage.size.height)/2, __folderImage.size.width, __folderImage.size.height);
            [folderView addSubview:aButton];
            
            /* Folder View Ends*/
            i++;
        }
    }else{
        [__appDelegate alert:@"There are no emoji art pictures submitted in this category, be the first!" withObject:@"Alert"];
    }
    
    
    
    return top;
}


- (void) userBtnClicked:(UIButton *)sender
{
    NSMutableDictionary *dict = sender.property;
    
    //NSLog(@"user_id == %@",[dict objectForKey:@"user_id"]);
    ViewUserProfile *__viewUserProfile = [[ViewUserProfile alloc] initWithNibName:@"ViewUserProfile" bundle:nil];
    __viewUserProfile.__profileUserID = [dict objectForKey:@"user_id"];
    [self.navigationController pushViewController:__viewUserProfile animated:YES];
    
}


-(void) alreadyLiked{
    [__appDelegate alert:@"This moji has been already liked" withObject:@"Alert"];
}

-(void) likeIt: (id) sender
{
    UIButton *like = sender;
    UIImage *heartIconHighlighted = [UIImage imageNamed:@"heart_filled.png"];
    [like setImage:heartIconHighlighted forState:UIControlStateNormal];
    [like setUserInteractionEnabled:NO];
    
    
    
    /* Save to Core Data*/
    //  1
    NSManagedObject * newEntry = [NSEntityDescription insertNewObjectForEntityForName:@"Likes" inManagedObjectContext:__appDelegate.managedObjectContext];
    
    //  2
    
    [newEntry setValue:[NSNumber numberWithInt:like.tag] forKey:@"servermojid"];
    
    //  3
    
    NSError *error;
    if (![__appDelegate.managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    
    [__appDelegate alert:@"Liked" withObject:@"Like It"];
    
//    FMDatabase *db = [__appDelegate openDb];
//    [db beginTransaction];
//    
//    [db executeUpdateWithFormat:@"INSERT INTO ZLIKES (zservermojid) VALUES (%d);", like.tag];
//    
//    //NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
//    [db commit];
//    [db close];
}



-(void)copyToClipBoard:(id)sender{
    UIButton *btn = sender;
    NSMutableDictionary *dict = btn.property;
    UIPasteboard *board = [UIPasteboard generalPasteboard];
    board.string = [dict objectForKey:@"text"];
    [__appDelegate alert:@"Moji is copied to your clipboard" withObject:@"Success"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
