//
//  browseByCategory.m
//  emijo
//
//  Created by 60Degree on 12/10/13.
//  Copyright (c) 2013 60Degree. All rights reserved.
//

#import "browseByCategory.h"

@interface browseByCategory ()

@end

@implementation browseByCategory

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

@synthesize mojis,mojisTable, pageTitle;
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addNavigationLeftButton];
    
    self.title = [pageTitle capitalizedString];
    mojisTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-128)];
    mojisTable.delegate = self;
    mojisTable.dataSource = self;
    [self.view addSubview:mojisTable];  
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
    return [mojis count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *MyIdentifier = @"MyReuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:MyIdentifier];
    }
    
    NSArray *keys = [mojis allKeys];
    id aKey = [keys objectAtIndex:indexPath.row];
    NSObject *anObject = [mojis objectForKey:aKey];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [anObject valueForKey:@"name"]];
    cell.textLabel.textColor = [UIColor colorWithRed:81.0/255.0 green:81.0/255.0 blue:81.0/255.0 alpha:1.0];
    [cell.textLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:14.0]];
    
    NSString *data = [NSString stringWithFormat:@"%@", [anObject valueForKey:@"data"]];
    UIImage *__detailIcon = [UIImage imageNamed:@"info_red.png"];
    
    UIButton *detailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [detailBtn setImage:__detailIcon forState:UIControlStateNormal];
    detailBtn.frame = CGRectMake((self.mojisTable.frame.size.width - (__detailIcon.size.width + 10)), 10, __detailIcon.size.width, __detailIcon.size.height);
    [detailBtn setTitle:data forState:UIControlStateNormal];
    detailBtn.tag = indexPath.row;
    [detailBtn addTarget:self action:@selector(detailButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [cell addSubview:detailBtn];
    
    UIImage *__editIcon = [UIImage imageNamed:@"edit_icon.png"];
    
    UIButton *editlBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    editlBtn.frame = CGRectMake(detailBtn.frame.origin.x - (__editIcon.size.width + 10), 10, __editIcon.size.width, __editIcon.size.height);
    [editlBtn setImage:__editIcon forState:UIControlStateNormal];
    [editlBtn setTitle:@"Edit" forState:UIControlStateNormal];
    editlBtn.tag = indexPath.row;
    [editlBtn addTarget:self action:@selector(editButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [cell addSubview:editlBtn];;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
