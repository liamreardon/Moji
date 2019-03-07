//
//  StickersView.m
//  emijo
//
//  Created by karamvir singh on 14/01/14.
//  Copyright (c) 2014 60Degree. All rights reserved.
//

#define IMAGE_VIEW_TAG 99

#import "StickersView.h"

@interface StickersView ()

@end

@implementation StickersView

@synthesize __catIndex, __subCatIndex, __tableView;

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
    
    self.view.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
    
    __appDelegate.__stickersCategories = [__appDelegate.__stickersArr objectAtIndex:self.__catIndex];
    
    __appDelegate.__stickerSubCat = [__appDelegate.__stickersCategories.__subCatArr objectAtIndex:self.__subCatIndex];
    
    self.title = [[NSString stringWithFormat:@"%@", __appDelegate.__stickerSubCat.__title] capitalizedString];
    
    [self addNavigationLeftButton];
    
    self.__tableView = [[UITableView alloc] init];
    
    
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
    
   //[self.__tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLineEtched];
    
    [self.view addSubview:self.__tableView];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setBackgroundColor:[UIColor colorWithRed:240.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0]];
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    //NSLog(@"Count == %d",[__appDelegate.__stickersArr count]);
    
    __appDelegate.__stickersCategories = [__appDelegate.__stickersArr objectAtIndex:self.__catIndex];
    
    __appDelegate.__stickerSubCat = [__appDelegate.__stickersCategories.__subCatArr objectAtIndex:self.__subCatIndex];
    
    return [__appDelegate.__stickerSubCat.__imagesArr count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *MyIdentifier = @"MyReuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:MyIdentifier];
    }
    
    for (UIView *__view in cell.contentView.subviews) {
        [__view removeFromSuperview];
    }
    
    
    __appDelegate.__stickersCategories = [__appDelegate.__stickersArr objectAtIndex:self.__catIndex];
    
    __appDelegate.__stickerSubCat = [__appDelegate.__stickersCategories.__subCatArr objectAtIndex:self.__subCatIndex];
    
    __appDelegate.__stickerImage = [__appDelegate.__stickerSubCat.__imagesArr objectAtIndex:indexPath.row];
    
    //NSLog(@"Title == %@",__appDelegate.__stickersCategories.__title);
    
    //cell.textLabel.text = [[NSString stringWithFormat:@"%@", __appDelegate.__stickerImage.__id] capitalizedString];
//    cell.textLabel.textColor = [UIColor colorWithRed:81.0/255.0 green:81.0/255.0 blue:81.0/255.0 alpha:1.0];
//    [cell.textLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:15.0]];
//    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    
//    cell.imageView.frame = CGRectMake(10, 10, cell.contentView.frame.size.height - 20, cell.contentView.frame.size.height - 20);
//    
//    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", __appDelegate.__stickerImage.__path]];
    
    __x = 20;
    __y = 10;
    __w = 80 - (__y * 2);
    __h = __w;
    
    UIImage *__storedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@", __appDelegate.__stickerImage.__path]];
    //NSLog(@"Image Path == %d",(indexPath.row * 2) + i);
    
    //[__appDelegate.__visionImagesArr addObject:__takePhotoView.__selectedIMAGE];
//    
//    UIImageView *__imgView = [[UIImageView alloc] initWithFrame:CGRectMake(__x, __y, __w, __h)];
//    __imgView.contentMode = UIViewContentModeScaleAspectFill;
//    __imgView.image = __storedImage;
//    
//    [cell.contentView addSubview:__imgView];
    
    //add AsyncImageView to cell
    AsyncImageView *imageView = [[AsyncImageView alloc] initWithFrame:CGRectMake(__x, __y, __w, __h)];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    imageView.tag = IMAGE_VIEW_TAG;
    
    [cell.contentView addSubview:imageView];
    
    //cancel loading previous image for cell
    [[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:imageView];
    
    //load the image
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        UIImage * img = __storedImage;
        // Make a trivial (1x1) graphics context, and draw the image into it
        UIGraphicsBeginImageContext(CGSizeMake(1,1));
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextDrawImage(context, CGRectMake(0, 0, 1, 1), [img CGImage]);
        UIGraphicsEndImageContext();
        
        // Now the image will have been loaded and decoded and is ready to rock for the main thread
        dispatch_sync(dispatch_get_main_queue(), ^{
            imageView.image = img;
        });
    });
    
    //imageView.image = __storedImage;
    imageView.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.0];
    
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //.. Add Send Button
    UIImage *__normal = [UIImage imageNamed:@"nav_send_btn.png"];
    UIImage *__highlighted = [UIImage imageNamed:@"nav_send_btn.png"];
    
    
    __w = __normal.size.width;
    __h = __normal.size.height;
    
    __y = (80 - __h)/2;
    __x = self.view.frame.size.width - (__w + 10);
    
    UIButton *__sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    // Set the location (x,y) and size (width,height) of the button
    __sendBtn.frame = CGRectMake(__x, __y, __w, __h);
    
    __sendBtn.tag = indexPath.row;
    
    // Set the button's background to an image
    [__sendBtn setBackgroundImage:__normal forState:UIControlStateNormal];
    [__sendBtn setBackgroundImage:__highlighted forState:UIControlStateHighlighted];
    
    // Add the target-action for the touch event
    [__sendBtn addTarget:self action:@selector(sendBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [cell.contentView addSubview:__sendBtn];
    
//    //.. Add FB Button
//    UIImage *__normal = [UIImage imageNamed:@"icon_fb.png"];
//    UIImage *__highlighted = [UIImage imageNamed:@"icon_fb.png"];
//    
//    
//    __w = __normal.size.width;
//    __h = __normal.size.height;
//    
//    __y = (80 - __h)/2;
//    __x = self.view.frame.size.width - (__w + 10);
//    
//    UIButton *__fbBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    
//    // Set the location (x,y) and size (width,height) of the button
//    __fbBtn.frame = CGRectMake(__x, __y, __w, __h);
//    
//    __fbBtn.tag = indexPath.row;
//    
//    // Set the button's background to an image
//    [__fbBtn setBackgroundImage:__normal forState:UIControlStateNormal];
//    [__fbBtn setBackgroundImage:__highlighted forState:UIControlStateHighlighted];
//    
//    // Add the target-action for the touch event
//    [__fbBtn addTarget:self action:@selector(fbBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    
//    
//    [cell.contentView addSubview:__fbBtn];
//    
//    
//    //.. Add Twitter Button
//    UIImage *__twitterNormal = [UIImage imageNamed:@"icon_twitter.png"];
//    UIImage *__twitterHighlighted = [UIImage imageNamed:@"icon_twitter.png"];
//    
//    
//    __w = __twitterNormal.size.width;
//    __h = __twitterNormal.size.height;
//    
//    __y = (80 - __h)/2;
//    __x = __fbBtn.frame.origin.x - (__w + 10);
//    
//    UIButton *__twitterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    
//    // Set the location (x,y) and size (width,height) of the button
//    __twitterBtn.frame = CGRectMake(__x, __y, __w, __h);
//    
//    __twitterBtn.tag = indexPath.row;
//    
//    // Set the button's background to an image
//    [__twitterBtn setBackgroundImage:__twitterNormal forState:UIControlStateNormal];
//    [__twitterBtn setBackgroundImage:__twitterHighlighted forState:UIControlStateHighlighted];
//    
//    // Add the target-action for the touch event
//    [__twitterBtn addTarget:self action:@selector(twitterBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    
//    
//    [cell.contentView addSubview:__twitterBtn];
    
    
    return cell;
}

- (void) sendBtnClicked:(UIButton *)sender
{
    
    __appDelegate.__stickersCategories = [__appDelegate.__stickersArr objectAtIndex:self.__catIndex];
    
    __appDelegate.__stickerSubCat = [__appDelegate.__stickersCategories.__subCatArr objectAtIndex:self.__subCatIndex];
    
    __appDelegate.__stickerImage = [__appDelegate.__stickerSubCat.__imagesArr objectAtIndex:sender.tag];
    
    self.__storedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@", __appDelegate.__stickerImage.__path]];
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Share" message:nil delegate:self cancelButtonTitle:nil
                                          otherButtonTitles:@"Copy to clipboard",
                          @"Send Mail",
                          @"Post on Facebook",
                          @"Share with Twitter",
                          @"Cancel",
                          nil];
    [alert show];
    
}

/* WHenever Alertview button clicked */
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex == 0) {
        
//        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
//        pasteboard.persistent = NO;
//        
//        NSMutableDictionary *text = [NSMutableDictionary dictionaryWithCapacity:1];
//        [text setValue:@"" forKey:(NSString *)kUTTypeUTF8PlainText];
//        
//        NSMutableDictionary *image = [NSMutableDictionary dictionaryWithCapacity:1];
//        [image setValue:self.__storedImage forKey:(NSString *)kUTTypePNG];
//        
//        pasteboard.items = [NSArray arrayWithObjects:image,text, nil];
        
        NSData *pngData = UIImagePNGRepresentation(self.__storedImage);
        [[UIPasteboard generalPasteboard] setData:pngData forPasteboardType:(id)kUTTypeGIF];
        
    } else if(buttonIndex == 1) {
        //. Send Mail Funtion
        [__appDelegate sendMailWithSubject:@"Word Maker Art" andBody:@"" i:self.__storedImage];
    } else if(buttonIndex == 2){
        [__appDelegate socailShareType:@"facebook" withImage:self.__storedImage];
    } else if(buttonIndex == 3){
        [__appDelegate socailShareType:@"twitter" withImage:self.__storedImage];
    }
//    else if(buttonIndex == 4){
//        NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation(self.__storedImage)];
//        [__appDelegate sendSMSFromControllerWithImageData:imageData];
//    }
}


- (void) fbBtnClicked:(UIButton *)sender
{
    __appDelegate.__stickersCategories = [__appDelegate.__stickersArr objectAtIndex:self.__catIndex];
    
    __appDelegate.__stickerSubCat = [__appDelegate.__stickersCategories.__subCatArr objectAtIndex:self.__subCatIndex];
    
    __appDelegate.__stickerImage = [__appDelegate.__stickerSubCat.__imagesArr objectAtIndex:sender.tag];
    
    UIImage *__storedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@", __appDelegate.__stickerImage.__path]];
    
    [__appDelegate socailShareType:@"facebook" withImage:__storedImage];
}

- (void) twitterBtnClicked:(UIButton *)sender
{
    
    __appDelegate.__stickersCategories = [__appDelegate.__stickersArr objectAtIndex:self.__catIndex];
    
    __appDelegate.__stickerSubCat = [__appDelegate.__stickersCategories.__subCatArr objectAtIndex:self.__subCatIndex];
    
    __appDelegate.__stickerImage = [__appDelegate.__stickerSubCat.__imagesArr objectAtIndex:sender.tag];
    
    UIImage *__storedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@", __appDelegate.__stickerImage.__path]];
    
    [__appDelegate socailShareType:@"twitter" withImage:__storedImage];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    StickersView *__stickersView = [[StickersView alloc] initWithNibName:@"StickersView" bundle:Nil];
//    __stickersView.__catIndex = self.__catIndex;
//    __stickersView.__subCatIndex = indexPath.row;
//    
//    [self.navigationController pushViewController:__stickersView animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
