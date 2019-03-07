//
//  searchMojis.m
//  emijo
//
//  Created by karamvir singh on 06/01/14.
//  Copyright (c) 2014 60Degree. All rights reserved.
//

#import "searchMojis.h"

@interface searchMojis ()

@end

@implementation searchMojis

@synthesize results, searchText, searchTable, __textfieldTxt, __searchViewHolder, __loadingView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        __appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [__appDelegate.__navBarVC setNavigationBarHidden:NO animated:YES ];
        self.title = @"Search";
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.__searchViewHolder = [[UIView alloc] init];
    self.searchTable = [[UITableView alloc] init];
    self.__textfieldTxt = [[UITextField alloc] init];
    
    [self addSearchBox];
    [self addTableView];
    
    /* Loading View */
    self.__loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    self.__loadingView.frame = self.view.bounds;
    
    self.__loadingView.backgroundColor = [UIColor colorWithRed:20.0/255.0 green:200.0/255.0 blue:240.0/255.0 alpha:0.5];
    
    [self.__loadingView startAnimating];
    
    [self.view addSubview:self.__loadingView];
    
    [self performSelector:@selector(loadSeacrhResults) withObject:Nil afterDelay:0.2];
    
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

- (void) addSearchBox
{
    
    UIImage *__bgImg = [UIImage imageNamed:@"search_box_bg.png"];
    
    //NSLog(@"__bgImg.size.width == %f",__bgImg.size.height);
    
    __w = __bgImg.size.width;
    __h = __bgImg.size.height;
    
    __x = 0;
    __y = self.navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height;
    
    
    self.__searchViewHolder.frame = CGRectMake(__x, __y, __w, __h);
    self.__searchViewHolder.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.__searchViewHolder];
    
    UIImageView *__imgView = [[UIImageView alloc] init];
    __imgView.frame = CGRectMake(__x, 0, __w, __h);
    __imgView.image = __bgImg;
    
    [self.__searchViewHolder addSubview:__imgView];
    
    self.__textfieldTxt.frame = CGRectMake(30, 8, self.__searchViewHolder.frame.size.width - 40, self.__searchViewHolder.frame.size.height - 16);
    self.__textfieldTxt.backgroundColor = [UIColor clearColor];
    [self.__textfieldTxt setAutocorrectionType:UITextAutocorrectionTypeNo];
    [self.__textfieldTxt setKeyboardType:UIKeyboardTypeASCIICapable];
    [self.__textfieldTxt setReturnKeyType:UIReturnKeyGo];
    
    self.__textfieldTxt.font = [UIFont fontWithName:@"HelveticaNeue" size:14.0];
    self.__textfieldTxt.textColor = [UIColor colorWithRed:180.0/255.0 green:180.0/255.0 blue:180.0/255.0 alpha:1.0];
    self.__textfieldTxt.text = searchText;
    self.__textfieldTxt.delegate = self;
    self.__textfieldTxt.placeholder = @"Search";
    [self.__searchViewHolder addSubview:self.__textfieldTxt];
}


- (void) addTableView
{
    __x = 0;
    __y = __y + __h;
    __h = __appDelegate.window.frame.size.height - __y;
    
    searchTable.frame = CGRectMake(__x, __y, __w, __h);
    searchTable.delegate = self;
    searchTable.dataSource = self;
    
    searchTable.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
    
    [self.view addSubview:searchTable];
}

-(void) loadSeacrhResults{
    
    //NSLog(@"self.__textfieldTxt.text == %@",self.__textfieldTxt.text);
    
    NSString *bodyData = [NSString stringWithFormat: @"a=searchMojisAction&tags=%@",self.__textfieldTxt.text];
    NSMutableDictionary *_dict = [__appDelegate makeRequest:bodyData];
    results = [_dict objectForKey:@"data"];
    //NSLog(@"%@",results);
    [searchTable reloadData];
    
    [self.__loadingView stopAnimating];
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setBackgroundColor:[UIColor colorWithRed:240.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0]];
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(([results count]==0)){
        return 1;
    } else {
        return [results count];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *MyIdentifier = @"MyReuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:MyIdentifier];
    }
    if([results count]==0){
        cell.textLabel.text = @"No results found";
        return cell;
    } else {
        NSArray *allKeys = [results allKeys];
        id aKey = [allKeys objectAtIndex:indexPath.row];
        NSMutableArray *moji = [results objectForKey:aKey];
        
        
        UIColor *textColor = [UIColor colorWithRed:0.0/255.0 green:92.0/255.0 blue:115.0/255.0 alpha:1.0];
        cell.textLabel.textColor = textColor;
        cell.textLabel.text = [moji valueForKey:@"name"];
        
        
        
        
        UIButton *btn = [[UIButton alloc] initWithFrame:cell.contentView.bounds];
        btn.backgroundColor = [UIColor clearColor];
        btn.frame = CGRectMake(0, 0, cell.contentView.frame.size.width, 60);
        [btn addTarget:self action:@selector(selectedCell:) forControlEvents:UIControlEventTouchUpInside];
        btn.property = [[NSMutableDictionary alloc] initWithObjects:@[[moji valueForKey:@"data"], [moji valueForKey:@"name"]] forKeys:@[@"mojiart", @"mojiName"]];
        [cell.contentView addSubview:btn];
        
        
        
        return cell;
    }
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


//.Make Search
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [self.__loadingView startAnimating];
    
    [self performSelector:@selector(loadSeacrhResults) withObject:Nil afterDelay:0.2];
    
    [theTextField resignFirstResponder];
    
    return 1;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
