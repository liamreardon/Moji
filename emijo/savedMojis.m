//
//  savedMojis.m
//  emijo
//
//  Created by 60Degree on 12/3/13.
//  Copyright (c) 2013 60Degree. All rights reserved.
//

#import "savedMojis.h"

@interface savedMojis ()

@end

@implementation savedMojis

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        __appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
        self.title = @"Saved Mojis";
        [__appDelegate.__navBarVC setNavigationBarHidden:NO animated:YES];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //__appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    self.view.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
    
    [self addNavigationLeftButton];
    
    _mojiTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-128)];
    
    _mojiTable.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
    
    _mojiTable.dataSource = self;
    _mojiTable.delegate = self;
    [self.view addSubview:_mojiTable];
    
    self.mojisArray = [[NSMutableArray alloc] init];
    
    self.mojisArray = [__appDelegate getSavedMojisData];
    
    
    [self.mojiTable reloadData];
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
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setBackgroundColor:[UIColor colorWithRed:240.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.mojisArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *MyIdentifier = @"MyReuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:MyIdentifier];
    }
    
    NSMutableDictionary *__dict = [self.mojisArray objectAtIndex:indexPath.row];
    
    //NSArray *keys = [_mojisArray allKeys];
    //id aKey = [keys objectAtIndex:indexPath.row];
    //NSObject *anObject = [_mojisArray objectForKey:aKey];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [__dict valueForKey:@"name"]];
    cell.textLabel.textColor = [UIColor colorWithRed:81.0/255.0 green:81.0/255.0 blue:81.0/255.0 alpha:1.0];
    [cell.textLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:14.0]];
    NSString *data = [NSString stringWithFormat:@"%@", [__dict valueForKey:@"data"]];
    
    UIImage *__detailIcon = [UIImage imageNamed:@"info_red.png"];
    
    UIButton *detailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [detailBtn setImage:__detailIcon forState:UIControlStateNormal];
    detailBtn.frame = CGRectMake((self.mojiTable.frame.size.width - (__detailIcon.size.width + 10)), 10, __detailIcon.size.width, __detailIcon.size.height);
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
    [cell addSubview:editlBtn];
    
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/* Detail Button Clicked*/
-(void) detailButtonClicked:(id)sender
{
    UIButton *btn = sender;
    
    NSMutableDictionary *__dict = [self.mojisArray objectAtIndex:btn.tag];
    
//    NSArray *keys = [_mojisArray allKeys];
    //id aKey = [keys objectAtIndex:btn.tag];
//    NSObject *anObject = [_mojisArray objectForKey:aKey];
    
    
    
    NSString *title = [NSString stringWithFormat:@"%@", [__dict valueForKey:@"name"]];
    NSString *data = [NSString stringWithFormat:@"%@", [__dict valueForKey:@"data"]];
    self.alertViewHiddenId = [__dict valueForKey:@"id"];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:nil delegate:self cancelButtonTitle:nil
                                          otherButtonTitles:@"Copy to clipboard",
                           @"Send Mail",
                          @"Submit to App",
                          @"Send Text",
                          @"cancel",
                          nil];
    self.alertViewHiddenData = data;
    [alert show];
    
}

/* WHenever Alertview button clicked */
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex==0) {
        UIPasteboard *board = [UIPasteboard generalPasteboard];
        board.string = self.alertViewHiddenData;
    } else if(buttonIndex==1) {
            //. Send Mail Funtion
            [self sendMail:alertView.title];
    } else if(buttonIndex==2){
        //. Submit To App
        NSString *mojiName = alertView.title;
        NSData *data = [self.alertViewHiddenData dataUsingEncoding:NSNonLossyASCIIStringEncoding];
        NSString *mojiText = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] ;
        
        NSString *id = self.alertViewHiddenId;
        NSString *bodyData = [NSString stringWithFormat: @"a=addMojiAction&session_token=%@&mojiName=%@&mojiText=%@&local_id=%@",__appDelegate.__sessionToken,mojiName, mojiText, id];
    
        browse *object = [[browse alloc] initWithNibName:@"browse" bundle:nil];
        object.selectCat = true;
        object.postUrl = bodyData;
        [__appDelegate.__navBarVC pushViewController:object animated:YES];
        
       
        //NSLog(@"%@",response);
    } else if(buttonIndex == 3){
        [__appDelegate sendSMSFromController:self.alertViewHiddenData];
    }
}

-(void) editButtonClicked: (id) sender{
    UIButton *btn = sender;
    
    NSMutableDictionary *__dict = [self.mojisArray objectAtIndex:btn.tag];
    
    
    
    NSManagedObjectContext *managedObjectContext = [__appDelegate managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Mojis"];
    NSMutableArray *__mojiRecords = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    for (int i = 0; i < [__mojiRecords count]; i++) {
        
        NSManagedObject *__selectedMojiRecord = [__mojiRecords objectAtIndex:i];
        
        NSString *__id = [NSString stringWithFormat:@"%@",[__selectedMojiRecord valueForKey:@"id"]];
        
        if ([[NSString stringWithFormat:@"%@",[__dict valueForKey:@"id"]] isEqualToString:__id]) {
            
            addEmoji *editView = [[addEmoji alloc] initWithNibName:@"addEmoji" bundle:nil];
            editView.mojiData = [__dict valueForKey:@"data"];
            editView.mojiName = [__dict valueForKey:@"name"];
            editView.mojiId = __id;
            editView.edit = YES;
            editView.__mojiRecord = __selectedMojiRecord;
            [self.navigationController pushViewController:editView animated:YES];
            
            break;
        }
    }
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![managedObjectContext save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
    
    
    //NSLog(@"ID == %@",[__dict valueForKey:@"id"]);
    
    
//    NSArray *keys = [_mojisArray allKeys];
//    id aKey = [keys objectAtIndex:btn.tag];
//    NSObject * anObject = [_mojisArray objectForKey:aKey];
    
    
   

}



/* Mail Methods starts from here */
-(void) sendMail:(NSString *) title{
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        mailer.mailComposeDelegate = self;
        [mailer setSubject:title];
        NSArray *toRecipients = [NSArray arrayWithObjects:@"amit.rana@60degree.com", nil];
        [mailer setToRecipients:toRecipients];
        NSString *emailBody = self.alertViewHiddenData;
        [mailer setMessageBody:emailBody isHTML:NO];
        [self presentViewController:mailer animated:YES completion:nil];
    }
    else
    {
        [__appDelegate alert:@"Your device doesn't support the composer sheet" withObject:@"Failure"];
    }

}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
	switch (result)
	{
		case MFMailComposeResultCancelled:
			NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued");
			break;
		case MFMailComposeResultSaved:
			NSLog(@"Mail saved: you saved the email message in the Drafts folder");
			break;
		case MFMailComposeResultSent:
            [__appDelegate alert:@"Mail send: the email message is queued in the outbox. It is ready to send the next time the user connects to email" withObject:@"Mail Sent"];
			break;
		case MFMailComposeResultFailed:
			NSLog(@"Mail failed: the email message was nog saved or queued, possibly due to an error");
			break;
		default:
			NSLog(@"Mail not sent");
			break;
	}
    
	[self dismissViewControllerAnimated:YES completion:nil];
}
/* Mail Methods ends here */
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
