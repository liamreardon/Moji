//
//  browse.m
//  emijo
//
//  Created by 60Degree on 12/6/13.
//  Copyright (c) 2013 60Degree. All rights reserved.
//

#import "browse.h"

@interface browse ()

@end


@implementation browse
@synthesize categories, categoriesTable,__textfieldTxt, __searchViewHolder;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        __appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [__appDelegate.__navBarVC setNavigationBarHidden:NO animated:YES ];
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated
{
    [self.categoriesTable reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.__searchViewHolder = [[UIView alloc] init];
    self.categoriesTable = [[UITableView alloc] init];
    self.__textfieldTxt = [[UITextField alloc] init];
    
    if(self.selectCat==true){
        self.title = @"Select Category";
        categories = [[NSMutableArray alloc] initWithObjects:@"Animals", @"City",@"Food",@"Fun",@"Gestures",@"Girly",@"Grades",@"Greetings",@"Lifestyle",@"Love",@"Mood",@"Nature", @"Random", @"Seasons", @"Sports", @"Symbols", @"Weather", @"Weird", @"Word Art", @"Other", nil];
        
        [self addTableView];
    } else {
        self.title = @"Browse";
        categories = [[NSMutableArray alloc] initWithObjects:@"Default",@"Animals", @"City",@"Food",@"Fun",@"Gestures",@"Girly",@"Grades",@"Greetings",@"Lifestyle",@"Love",@"Mood",@"Nature", @"Random", @"Seasons", @"Sports", @"Symbols", @"Weather", @"Weird", @"Word Art", @"Other", nil];
        
        [self addSearchBox];
        [self addTableView];
    }
    
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
    self.__textfieldTxt.delegate = self;
    self.__textfieldTxt.placeholder = @"Search";
    [self.__searchViewHolder addSubview:self.__textfieldTxt];
    


}


- (void) addTableView
{
    __x = 0;
    __w = self.view.frame.size.width;
    
    if(self.selectCat==true){
        __y = 0;
    } else {
        __y = __y + __h;
    }
    __h = __appDelegate.window.frame.size.height - __y;
    
    categoriesTable.frame = CGRectMake(__x, __y, __w, __h);
    categoriesTable.delegate = self;
    categoriesTable.dataSource = self;
    
    categoriesTable.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
    
    [self.view addSubview:categoriesTable];
}


//.Make Search

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    
    if([self.__textfieldTxt.text isEqualToString:@""]){
        [__appDelegate alert:@"Please enter keywords to search" withObject:@"Error"];
        return FALSE;
    } else {
        searchMojis *search = [[searchMojis alloc] initWithNibName:@"searchMojis" bundle:nil];
        search.searchText = self.__textfieldTxt.text;
        [__appDelegate.__navBarVC pushViewController:search animated:YES];
    }
    
    [theTextField resignFirstResponder];
    
    return 1;
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setBackgroundColor:[UIColor colorWithRed:240.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0]];
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    //NSLog(@"Count == %d",[categories count]);
    
    return [categories count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *MyIdentifier = @"MyReuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:MyIdentifier];
    }
    cell.textLabel.text = [[NSString stringWithFormat:@"%@", [categories objectAtIndex:indexPath.row]] capitalizedString];
    cell.textLabel.textColor = [UIColor colorWithRed:81.0/255.0 green:81.0/255.0 blue:81.0/255.0 alpha:1.0];
    [cell.textLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:18.0]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellText = [categories objectAtIndex:indexPath.row];
    if(self.selectCat==true){
        
        NSString *bodyData= [NSString stringWithFormat:@"%@&category=%@", self.postUrl, cellText];
        setTags *tagPage = [[setTags alloc] initWithNibName:@"setTags" bundle:nil];
        tagPage.content = bodyData;
        [__appDelegate.__navBarVC pushViewController:tagPage animated:YES];
        
        
        
    } else {
        topCharts *charts = [[topCharts alloc] initWithNibName:@"topCharts" bundle:nil];
        
        charts.selectCatName = cellText;
        charts.selectCat = YES;
        
        [__appDelegate.__navBarVC pushViewController:charts animated:YES];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex==0){
        [__appDelegate loadPageFromString:@"topCharts"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
