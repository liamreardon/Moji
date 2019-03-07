//
//  LikesView.m
//  emijo
//
//  Created by karamvir singh on 21/01/14.
//  Copyright (c) 2014 60Degree. All rights reserved.
//

#import "LikesView.h"

@interface LikesView ()

@end

@implementation LikesView

@synthesize  likesTable, likesArray, __loadingView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Likes";
        __appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [__appDelegate.__navBarVC setNavigationBarHidden:NO animated:YES ];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addNavigationLeftButton];
    
    self.view.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
    
    likesTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-128) style:UITableViewStylePlain];
    
    likesTable.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
    
    likesTable.delegate = self;
    likesTable.dataSource = self;
    [likesTable setAllowsSelection:FALSE];
    [self.view addSubview:likesTable];
    
    
    
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
    //. Likes Ids from local DB
    NSMutableArray *likes = [__appDelegate getLikes];
    NSString *keys = [__appDelegate arrayToJson:likes];
    
    /* Likes Data from server */
    NSString *bodyData = [NSString stringWithFormat: @"a=getMojisBYIdsAction&keys=%@",keys];
    likesArray = [[__appDelegate makeRequest:bodyData] objectForKey:@"data"];
    
    [likesTable reloadData];
    
    [self.__loadingView stopAnimating];
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


-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setBackgroundColor:[UIColor colorWithRed:240.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0]];
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [likesArray count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *MyIdentifier = @"MyReuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:MyIdentifier];
    }
    
    NSArray *allKeys = [likesArray allKeys];
    id aKey = [allKeys objectAtIndex:indexPath.row];
    NSMutableArray *moji = [likesArray objectForKey:aKey];
    
    UIColor *textColor = [UIColor colorWithRed:0.0/255.0 green:90.0/255.0 blue:115.0/255.0 alpha:1.0];
    
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(10, 2, self.view.frame.size.width, 30)];
    name.text = [moji valueForKey:@"name"];
    name.textColor = textColor;
    [name setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:15.0]];
    
    [cell addSubview:name];
    
    
    //Watch
    
    UIImage *__watchImg = [UIImage imageNamed:@"watch_icon.png"];
    
    UIImageView *watch = [[UIImageView alloc] init];
    watch.image = __watchImg;
    watch.frame = CGRectMake(10, name.frame.size.height + 5, __watchImg.size.width, __watchImg.size.height);
    [cell addSubview:watch];
    
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
    [cell addSubview:timeAgo];
    
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
    [cell addSubview:userText];
    /* user detail View ends*/
    
    StarRatingView *starviewR = [[StarRatingView alloc]initWithFrame:CGRectMake(userText.frame.size.width, name.frame.size.height, 80, 15) andRating:80 withLabel:NO animated:YES selectedColor:[UIColor colorWithRed:250.0/255.0 green:204.0/255.0 blue:46.0/255.0 alpha:1.0]];
    //UIControl *mask = [[UIControl alloc] init];
    // [mask addSubview:starviewR];
    [cell addSubview:starviewR];
    
    UILabel *ratingText = [[UILabel alloc] initWithFrame:CGRectMake(starviewR.frame.origin.x + starviewR.frame.size.width, name.frame.size.height - 2, 100, 20)];
    ratingText.textColor = [UIColor grayColor];
    ratingText.text = @"1684 ratings";
    ratingText.font = [UIFont fontWithName:@"HelveticaNeue" size:9.0];
    [cell addSubview:ratingText];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:cell.contentView.bounds];
    btn.backgroundColor = [UIColor clearColor];
    btn.frame = CGRectMake(0, 0, cell.contentView.frame.size.width, 60);
    [btn addTarget:self action:@selector(selectedCell:) forControlEvents:UIControlEventTouchUpInside];
    btn.property = [[NSMutableDictionary alloc] initWithObjects:@[[moji valueForKey:@"data"], [moji valueForKey:@"name"]] forKeys:@[@"mojiart", @"mojiName"]];
    [cell.contentView addSubview:btn];
    
    return cell;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
