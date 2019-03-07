//
//  coolFonts.m
//  emijo
//
//  Created by karamvir singh on 06/01/14.
//  Copyright (c) 2014 60Degree. All rights reserved.
//

#import "coolFonts.h"

@interface coolFonts ()

@end

@implementation coolFonts
@synthesize coolFontText,__fontsArr,fontsTable,sendButton,toolBar, fontBtn, keyboardBtn, textColor, __font;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Cool Fonts";
        __appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//        sendButton = [[UIBarButtonItem alloc] initWithTitle:@"Send" style:UIBarButtonItemStylePlain target:self action:@selector(sendButtonClicked)];
//        sendButton.tintColor = [UIColor redColor];
//        self.navigationItem.rightBarButtonItem = sendButton;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
    
    [self addNavigationLeftButton];
    [self addNavigationRightButton];
    
    coolFontText = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 330)];
    [coolFontText setKeyboardType:UIKeyboardTypeASCIICapable];
    [self.view addSubview:coolFontText];
    
    coolFontText.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
    
    textColor = [UIColor colorWithRed:22.0/255.0 green:198.0/255.0 blue:242.0/255.0 alpha:1.0];
    
    toolBar = [[UIView alloc] initWithFrame:CGRectMake(0, coolFontText.frame.size.height, coolFontText.frame.size.width, 30)];
    toolBar.backgroundColor = [UIColor clearColor];
    toolBar.layer.borderColor = textColor.CGColor;
    toolBar.layer.borderWidth = 1.0;
    [self.view addSubview:toolBar];
    
    
    CGRect fontBtnFrame = CGRectMake(0, 0, 70, 30.0);
    fontBtn = [[UIButton alloc] initWithFrame:fontBtnFrame];
    fontBtn.backgroundColor = [UIColor clearColor];
    [fontBtn setTitle:@"Fonts" forState:UIControlStateNormal];
    [fontBtn setTitleColor:textColor forState:UIControlStateNormal];
    fontBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:18.0f];
    [fontBtn addTarget:self action:@selector(selectFontsTable) forControlEvents:UIControlEventTouchUpInside];
    
    [toolBar addSubview:fontBtn];
    
    CGRect keyboardButtonFrame = CGRectMake(self.view.frame.size.width - 100 , 0, 100, 30.0);
    keyboardBtn = [[UIButton alloc] initWithFrame:keyboardButtonFrame];
    keyboardBtn.backgroundColor = [UIColor clearColor];
    [keyboardBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [keyboardBtn setTitle:@"Keyboard" forState:UIControlStateNormal];
    keyboardBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:18.0f];
    [keyboardBtn addTarget:self action:@selector(selectKeyBoard) forControlEvents:UIControlEventTouchUpInside];
    
    [toolBar addSubview:keyboardBtn];
    
    
    //. Fonts
    __fontsArr = [[NSArray alloc] initWithArray:[UIFont familyNames]];
    
   // __fontsArr = [[NSArray alloc] initWithObjects:@"Killyourdarlings", @"POP1280", nil];
    
//    for (NSString* family in [UIFont familyNames])
//    {
//        NSLog(@"%@", family);
//        
//        for (NSString* name in [UIFont fontNamesForFamilyName: family])
//        {
//            NSLog(@"  %@", name);
//        }
//    }
    
    //NSLog(@"__fontsArr = %@",__fontsArr);
    
    float fontsTableHeight = self.view.frame.size.height - (toolBar.frame.origin.y + toolBar.frame.size.height) - 88;
    fontsTable = [[UITableView alloc] initWithFrame:CGRectMake(0, coolFontText.frame.size.height+toolBar.frame.size.height, coolFontText.frame.size.width, fontsTableHeight)];
    fontsTable.delegate = self;
    fontsTable.dataSource = self;
    
    fontsTable.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
    
    [self.view addSubview:fontsTable];
    
    // Do any additional setup after loading the view from its nib.
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
    UIImage *__normalRight = [UIImage imageNamed:@"nav_send_btn.png"];
    UIImage *__highlightedRight = [UIImage imageNamed:@"nav_send_btn.png"];
    
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

-(void)selectKeyBoard{
    [coolFontText becomeFirstResponder];
    [fontBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [keyboardBtn setTitleColor:textColor forState:UIControlStateNormal];
}

-(void)selectFontsTable{
    [coolFontText resignFirstResponder];
    [fontBtn setTitleColor:textColor forState:UIControlStateNormal];
    [keyboardBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
}


/* Detail Button Clicked*/
-(void)sendButtonClicked
{
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
    
    
    UIImage *__capImg = [self makeImage];
    
    if (buttonIndex==0) {
        UIPasteboard *board = [UIPasteboard generalPasteboard];
        board.string = coolFontText.text;
    } else if(buttonIndex == 1) {
        //. Send Mail Funtion
        [__appDelegate sendMailWithSubject:@"Word Maker Art" andBody:@"" i:__capImg];
    } else if(buttonIndex == 2){
        [__appDelegate socailShareType:@"facebook" withImage:__capImg];
    } else if(buttonIndex == 3){
        [__appDelegate socailShareType:@"twitter" withImage:__capImg];
    }
//    else if(buttonIndex == 4){
//        NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation(__capImg)];
//        [__appDelegate sendSMSFromControllerWithImageData:imageData];
//        //[__appDelegate sendSMSFromController:coolFontText.text];
//    }
    
////    NSAttributedString *__str=[[NSAttributedString alloc] initWithString:coolFontText.text
////                                                                attributes:@{NSFontAttributeName : coolFontText.font,NSForegroundColorAttributeName:coolFontText.textColor}];
//    
//    if (buttonIndex==0) {
////        UIPasteboard *board = [UIPasteboard generalPasteboard];
////        board.string = coolFontText.text;
//        
//        
//        /*NSLog(@"Place HTML on the pasteboard");
//        
//        UIPasteboard* pasteboard = [UIPasteboard generalPasteboard];
//        NSString *htmlType = @"Apple Web Archive pasteboard type";
//        
//        // example html string
//        NSString* htmlString = @"<span style='font-family:Verdana;font-size:14px'>test</span>";
//        
//        NSMutableDictionary *resourceDictionary = [NSMutableDictionary dictionary];
//        
//        [resourceDictionary setObject:[htmlString dataUsingEncoding:NSUTF8StringEncoding]  forKey:@"WebResourceData"];
//        
//        [resourceDictionary setObject:@"" forKey:@"WebResourceFrameName"];
//        [resourceDictionary setObject:@"text/html" forKey:@"WebResourceMIMEType"];
//        [resourceDictionary setObject:@"UTF-8" forKey:@"WebResourceTextEncodingName"];
//        [resourceDictionary setObject:@"about:blank" forKey:@"WebResourceURL"];
//        
//        NSDictionary *containerDictionary = [NSDictionary dictionaryWithObjectsAndKeys:resourceDictionary, @"WebMainResource", nil];
//        
//        NSDictionary *htmlItem = [NSDictionary dictionaryWithObjectsAndKeys:containerDictionary,htmlType,nil];
//        
//        [pasteboard setItems: [NSArray arrayWithObjects: htmlItem, nil]];
//         */
//        
//        NSString* htmlString = [NSString stringWithFormat:@"<span style='font-family:%@;font-size:14px'>test</span>",self.__selectedFontName];
//        
//        //NSLog(@"htmlString == %@",htmlString);
//        
//        NSData *htmlData = [htmlString dataUsingEncoding:NSUTF8StringEncoding];
//
//        NSString *htmlEncoded = [htmlData base64Encoding];
//        
//        
//        NSError *error = nil;
//        NSMutableString *webArchiveTemplate = [[NSMutableString alloc] initWithContentsOfFile:@"webArchiveTemplate.txt" encoding:NSUTF8StringEncoding error:&error];
//        
//        //NSMutableString *webArchiveTemplate = [[NSMutableString alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"webArchiveTemplate" ofType:@"txt"]];
//        
//        [webArchiveTemplate replaceOccurrencesOfString:@"REPLACE_WITH_ENCODED_DATA"
//                                            withString:htmlEncoded
//                                               options:NSCaseInsensitiveSearch
//                                                 range:NSMakeRange(0, [webArchiveTemplate length])];
//        
//        NSString *htmlType = @"Apple Web Archive pasteboard type";
//        NSDictionary *item = [NSDictionary dictionaryWithObjectsAndKeys:webArchiveTemplate,htmlType,nil];
//
//        UIPasteboard* pasteboard = [UIPasteboard generalPasteboard];
//        pasteboard.items = [NSArray arrayWithObject:item];
//        
//        
//    } else if(buttonIndex==1) {
//        //. Send Mail Funtion
//        [__appDelegate sendMailWithSubject:@"New Cool Font" andBody:coolFontText.text];
//    } else if(buttonIndex==2){
//        [__appDelegate socailShareType:@"facebook" withText:coolFontText.text];
//    } else if(buttonIndex==3){
//        [__appDelegate socailShareType:@"twitter" withText:coolFontText.text];
//    }
}

-(UIImage*) makeImage {
    
    // Create a graphics context with the target size
    // On iOS 4 and later, use UIGraphicsBeginImageContextWithOptions to take the scale into consideration
    // On iOS prior to 4, fall back to use UIGraphicsBeginImageContext
    CGSize imageSize = [coolFontText bounds].size;
    if (NULL != UIGraphicsBeginImageContextWithOptions)
        UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    else
        UIGraphicsBeginImageContext(imageSize);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // -renderInContext: renders in the coordinate space of the layer,
    // so we must first apply the layer's geometry to the graphics context
    CGContextSaveGState(context);
    // Center the context around the view's anchor point
    CGContextTranslateCTM(context, [self.view center].x, [self.view center].y);
    // Apply the view's transform about the anchor point
    CGContextConcatCTM(context, [self.view transform]);
    // Offset by the portion of the bounds left of and above the anchor point
    CGContextTranslateCTM(context,
                          -[self.view bounds].size.width * [[self.view layer] anchorPoint].x,
                          -[self.view bounds].size.height * [[self.view layer] anchorPoint].y);
    
    // Render the layer hierarchy to the current context
    [[self.view layer] renderInContext:context];
    
    // Restore the context
    CGContextRestoreGState(context);
    
    // Retrieve the screenshot image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setBackgroundColor:[UIColor colorWithRed:240.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0]];
}

//. FontsTable delegates
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [__fontsArr count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *MyIdentifier = @"MyReuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:MyIdentifier];
    }
    NSString *fontName = [__fontsArr objectAtIndex:indexPath.row];
    
    //NSLog(@"fontName == %@",fontName);
    
    cell.textLabel.text = fontName;
    //[cell.textLabel setFont:[UIFont fontWithName:fontName size:15.0]];
    self.__selectedFontName = fontName;
    self.__font = fontName;
    
    [cell.textLabel setFont:[UIFont fontWithName:fontName size:15.0]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [fontsTable cellForRowAtIndexPath:indexPath];
    coolFontText.font = [UIFont fontWithName:cell.textLabel.text size:15.0];
    //[coolFontText setFont:[UIFont fontWithName:cell.textLabel.text size:15.0]];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
