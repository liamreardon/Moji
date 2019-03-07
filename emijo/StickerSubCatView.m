//
//  StickerSubCatView.m
//  emijo
//
//  Created by karamvir singh on 14/01/14.
//  Copyright (c) 2014 60Degree. All rights reserved.
//

#import "StickerSubCatView.h"

@interface StickerSubCatView ()

@end

@implementation StickerSubCatView
@synthesize __tableView, __catIndex;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        __appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    __appDelegate.__stickersCategories = [__appDelegate.__stickersArr objectAtIndex:self.__catIndex];
    
    self.title = [[NSString stringWithFormat:@"%@", __appDelegate.__stickersCategories.__title] capitalizedString];
    
    
    self.__tableView = [[UITableView alloc] init];
    
    self.view.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
    
    [self addNavigationLeftButton];
    [self addTabelView];
}

- (void) viewWillAppear:(BOOL)animated
{
    [self.__tableView reloadData];
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

- (void) addTabelView
{
    __x = 0;
    __y = 0;
    
    __w = self.view.frame.size.width;
    __h = self.view.frame.size.height - 88;
    
    
    self.__tableView.frame = CGRectMake(__x, __y, __w, __h);
    self.__tableView.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
    self.__tableView.delegate = self;
    self.__tableView.dataSource = self;
    [self.view addSubview:self.__tableView];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setBackgroundColor:[UIColor colorWithRed:240.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0]];
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    //NSLog(@"Count == %d",[__appDelegate.__stickersArr count]);
    
    __appDelegate.__stickersCategories = [__appDelegate.__stickersArr objectAtIndex:self.__catIndex];
    
    return [__appDelegate.__stickersCategories.__subCatArr count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *MyIdentifier = @"MyReuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:MyIdentifier];
    }
    
    __appDelegate.__stickerSubCat = [__appDelegate.__stickersCategories.__subCatArr objectAtIndex:indexPath.row];
    
    //NSLog(@"Title == %@",__appDelegate.__stickersCategories.__title);
    
    cell.textLabel.text = [[NSString stringWithFormat:@"%@", __appDelegate.__stickerSubCat.__title] capitalizedString];
    cell.textLabel.textColor = [UIColor colorWithRed:81.0/255.0 green:81.0/255.0 blue:81.0/255.0 alpha:1.0];
    [cell.textLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:15.0]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    StickersView *__stickersView = [[StickersView alloc] initWithNibName:@"StickersView" bundle:Nil];
    __stickersView.__catIndex = self.__catIndex;
    __stickersView.__subCatIndex = indexPath.row;
    
    [self.navigationController pushViewController:__stickersView animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
