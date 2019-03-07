//
//  wordMaker.m
//  emijo
//
//  Created by karamvir singh on 06/01/14.
//  Copyright (c) 2014 60Degree. All rights reserved.
//

#import "wordMaker.h"

@interface wordMaker ()

@end

@implementation wordMaker
@synthesize emotions, word, emotionSelector, makeButton, __elementsHolder;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Word Maker";
        __appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
    
    [self addNavigationLeftButton];
    [self addNavigationRightButton];
    
    emotions = [[NSArray alloc] initWithObjects:@"\ue415",@"\ue056",@"\ue057",@"\ue414",@"\ue405",@"\ue106",
                @"\ue418",@"\ue417",@"\ue40d",@"\ue40a",@"\ue404",@"\ue105",@"\ue409",@"\ue40e",@"\ue402",@"\ue108",@"\ue403",
                @"\ue058",@"\ue407",@"\ue401",@"\ue40f",@"\ue40b",@"\ue406",@"\ue413",@"\ue411",@"\ue412",@"\ue410",@"\ue107",
                @"\ue059",@"\ue416",@"\ue408",@"\ue40c",@"\ue11a",@"\ue10c",@"\ue32c",@"\ue32a",@"\ue32d",@"\ue328",@"\ue32b",@"\ue022",
                @"\ue023",@"\ue327",@"\ue329",@"\ue32e",@"\ue32f",@"\ue335",@"\ue334",@"\ue021",
                @"\ue337",@"\ue020",@"\ue336",@"\ue13c",@"\ue330",@"\ue331",@"\ue326",@"\ue03e",@"\ue11d"@"\ue05a",@"\ue00e",@"\ue421",@"\ue420",
                @"\ue00d",@"\ue010",@"\ue011",@"\ue41e",@"\ue012",@"\ue422",@"\ue22e",@"\ue22f",@"\ue231",@"\ue230",@"\ue427",@"\ue41d",@"\ue00f",
                @"\ue41f",@"\ue14c",@"\ue201",@"\ue115",@"\ue428",@"\ue51f",@"\ue429",@"\ue424",@"\ue423",@"\ue253",
                @"\ue426",@"\ue111",@"\ue425",@"\ue31e",@"\ue31f",@"\ue31d",@"\ue001",@"\ue002",@"\ue005",@"\ue004",@"\ue51a",@"\ue519",@"\ue518",@"\ue515",@"\ue516",@"\ue517",@"\ue51b",@"\ue152",
                @"\ue04e",@"\ue51c",@"\ue51e",@"\ue11c",@"\ue536",@"\ue003",@"\ue41c",@"\ue41b",@"\ue419",@"\ue41a",@"\ue04a",@"\ue04b",@"\ue049",@"\ue048",@"\ue04c",@"\ue13d",@"\ue443",@"\ue43e",
                @"\ue04f",@"\ue052",@"\ue053",@"\ue524",@"\ue52c",@"\ue52a",@"\ue531",@"\ue050",@"\ue527",@"\ue051",@"\ue10b",@"\ue52b",@"\ue52f",@"\ue528",@"\ue01a",@"\ue134",@"\ue530",@"\ue529",
                @"\ue526",@"\ue52d",@"\ue521",@"\ue523",@"\ue52e",@"\ue055",@"\ue525",@"\ue10a",@"\ue109",@"\ue522",@"\ue019",@"\ue054",@"\ue520",@"\ue306",@"\ue030",@"\ue304",@"\ue110",@"\ue032",
                @"\ue305",@"\ue303",@"\ue118",@"\ue447",@"\ue119",@"\ue307",@"\ue308",@"\ue444",@"\ue441",@"\ue436",@"\ue437",@"\ue438",@"\ue43a",@"\ue439",@"\ue43b",@"\ue117",@"\ue440",@"\ue442",
                @"\ue446",@"\ue445",@"\ue11b",@"\ue448",@"\ue033",@"\ue112",@"\ue325",@"\ue312",@"\ue310",@"\ue126",@"\ue127",@"\ue008",@"\ue03d",@"\ue00c",@"\ue12a",@"\ue00a",@"\ue00b",@"\ue009",
                @"\ue316",@"\ue129",@"\ue141",@"\ue142",@"\ue317",@"\ue128",@"\ue14b",@"\ue211",@"\ue114",@"\ue145",@"\ue144",@"\ue03f",@"\ue313",@"\ue116",@"\ue10f",@"\ue104",@"\ue103",@"\ue101",
                @"\ue102",@"\ue13f",@"\ue140",@"\ue11f",@"\ue12f",@"\ue031",@"\ue30e",@"\ue311",@"\ue113",@"\ue30f",@"\ue13b",@"\ue42b",@"\ue42a",@"\ue018",@"\ue016",@"\ue015",@"\ue014",@"\ue42c",
                @"\ue42d",@"\ue017",@"\ue013",@"\ue20e",@"\ue20c",@"\ue20f",@"\ue20d",@"\ue131",@"\ue12b",@"\ue130",@"\ue12d",@"\ue324",@"\ue301",@"\ue148",@"\ue502",@"\ue03c",@"\ue30a",@"\ue042",
                @"\ue040",@"\ue041",@"\ue12c",@"\ue007",@"\ue31a",@"\ue13e",@"\ue31b",@"\ue006",@"\ue302",@"\ue319",@"\ue321",@"\ue322",@"\ue314",@"\ue503",@"\ue10e",@"\ue318",@"\ue43c",@"\ue11e",
                @"\ue323",@"\ue31c",@"\ue034",@"\ue035",@"\ue045",@"\ue338",@"\ue047",@"\ue30c",@"\ue044",@"\ue30b",@"\ue043",@"\ue120",@"\ue33b",@"\ue33f",@"\ue341",@"\ue34c",@"\ue344",@"\ue342",
                @"\ue33d",@"\ue33e",@"\ue340",@"\ue34d",@"\ue339",@"\ue147",@"\ue343",@"\ue33c",@"\ue33a",@"\ue43f",@"\ue34b",@"\ue046",@"\ue345",@"\ue346",@"\ue348",@"\ue347",@"\ue34a",@"\ue349",
                @"\ue036",@"\ue157",@"\ue038",@"\ue153",@"\ue155",@"\ue14d",@"\ue156",@"\ue501",@"\ue158",@"\ue43d",@"\ue037",@"\ue504",@"\ue44a",@"\ue146",@"\ue50a",@"\ue505",
                @"\ue506",@"\ue122",@"\ue508",@"\ue509",@"\ue03b",@"\ue04d",@"\ue449",@"\ue44b",@"\ue51d",@"\ue44c",@"\ue124",@"\ue121",@"\ue433",@"\ue202",@"\ue135",@"\ue01c",@"\ue01d",@"\ue10d",
                @"\ue136",@"\ue42e",@"\ue01b",@"\ue15a",@"\ue159",@"\ue432",@"\ue430",@"\ue431",@"\ue42f",@"\ue01e",@"\ue039",@"\ue435",@"\ue01f",@"\ue125",@"\ue03a",@"\ue14e",@"\ue252",@"\ue137",
                @"\ue209",@"\ue154",@"\ue133",@"\ue150",@"\ue320",@"\ue123",@"\ue132",@"\ue143",@"\ue50b",@"\ue514",@"\ue513",@"\ue50c",@"\ue50d",@"\ue511",@"\ue50f",@"\ue512",@"\ue510",@"\ue50e",
                @"\ue21c",@"\ue21d",@"\ue21e",@"\ue21f",@"\ue220",@"\ue221",@"\ue222",@"\ue223",@"\ue224",@"\ue225",@"\ue210",@"\ue232",@"\ue233",@"\ue235",@"\ue234",@"\ue236",@"\ue237",@"\ue238",
                @"\ue239",@"\ue23b",@"\ue23a",@"\ue23d",@"\ue23c",@"\ue24d",@"\ue212",@"\ue24c",@"\ue213",@"\ue214",@"\ue507",@"\ue203",@"\ue20b",@"\ue22a",@"\ue22b",@"\ue226",@"\ue227",@"\ue22c",
                @"\ue22d",@"\ue215",@"\ue216",@"\ue217",@"\ue218",@"\ue228",@"\ue151",@"\ue138",@"\ue139",@"\ue13a",@"\ue208",@"\ue14f",@"\ue20a",@"\ue434",@"\ue309",@"\ue315",@"\ue30d",@"\ue207",
                @"\ue229",@"\ue206",@"\ue205",@"\ue204",@"\ue12e",@"\ue250",@"\ue251",@"\ue14a",@"\ue149",@"\ue23f",@"\ue240",@"\ue241",@"\ue242",@"\ue243",@"\ue244",@"\ue245",@"\ue246",@"\ue247",
                @"\ue248",@"\ue249",@"\ue24a",@"\ue24b",@"\ue23e",@"\ue532",@"\ue533",@"\ue534",@"\ue535",@"\ue21a",@"\ue219",@"\ue21b",@"\ue02f",@"\ue024",@"\ue025",@"\ue026",@"\ue027",@"\ue028",
                @"\ue029",@"\ue02a",@"\ue02b",@"\ue02c",@"\ue02d",@"\ue02e",@"\ue332",@"\ue333",@"\ue24e",@"\ue24f",@"\ue537",nil];
    
    
    self.__textView = [[UITextView alloc] init];
    
    self.__emoIconsHolderView = [[UIView alloc] init];
    
    __w = self.view.frame.size.width + 2;
    __h = 30;
    
    __x = -1;
    __y = self.navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height;
    
    //__y = __appDelegate.window.frame.size.height - __h;
    
    
    __elementsHolder = [[UIView alloc] init];
    __elementsHolder.frame = CGRectMake(__x, __y, __w, __h);
    __elementsHolder.backgroundColor = [UIColor clearColor];
    
    __elementsHolder.layer.borderColor = [UIColor colorWithRed:22.0/255.0 green:198.0/255.0 blue:242.0/255.0 alpha:1.0].CGColor;
    __elementsHolder.layer.borderWidth = 1.0;
    
    [self.view addSubview:__elementsHolder];
    
    word = [[UITextField alloc] initWithFrame:CGRectMake(5, 3, 220, 24)];
    word.backgroundColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:0.0];
    word.font = [UIFont fontWithName:@"HelveticaNeue" size:13.0];
    word.text = @"Add text";
    
    word.textColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0];
    word.delegate = self;
    
    [word setReturnKeyType:UIReturnKeyDone];
    //[word setKeyboardType:UIKeyboardTypeASCIICapable];
    [__elementsHolder addSubview:word];
    
    
    makeButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 55, 3, 50, 24)];
    makeButton.backgroundColor = [UIColor redColor];
    [makeButton setTitle:@"Make" forState:UIControlStateNormal];
    [makeButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:13.0]];
    [makeButton addTarget:self action:@selector(makeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [__elementsHolder addSubview:makeButton];
    
    emotionSelector = [[UIButton alloc] initWithFrame:CGRectMake(makeButton.frame.origin.x - 30 , 3, 30, 24)];
    emotionSelector.backgroundColor = [UIColor clearColor];
    [emotionSelector setTitle:[NSString stringWithFormat:@"%@",[emotions objectAtIndex:0]] forState:UIControlStateNormal];
    [emotionSelector addTarget:self action:@selector(emotionSelectorClicked:) forControlEvents:UIControlEventTouchUpInside];
    [__elementsHolder addSubview:emotionSelector];
    
    
    
//    emotionPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 200, 320, 200)];
//    emotionPicker.delegate = self;
//    emotionPicker.showsSelectionIndicator = YES;
//    [emotionPicker setHidden:YES];
//    [__elementsHolder addSubview:emotionPicker];
    
    [self addTextView];
    
    [self addEmoIconsHolderView];
    
    
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

/* Detail Button Clicked*/
-(void)sendButtonClicked
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Share" message:nil delegate:self cancelButtonTitle:nil
                                          otherButtonTitles:@"Copy to clipboard",
                          @"Send Mail",
                          @"Post on Facebook",
                          @"Share with Twitter",
                          @"Send Text",
                          @"Cancel",
                          nil];
    [alert show];
}

/* WHenever Alertview button clicked */
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex==0) {
        UIPasteboard *board = [UIPasteboard generalPasteboard];
        board.string = self.__textView.text;
    } else if(buttonIndex==1) {
        //. Send Mail Funtion
        [__appDelegate sendMailWithSubject:@"Word Maker Art" andBody:self.__textView.text];
    } else if(buttonIndex==2){
        [__appDelegate socailShareType:@"facebook" withText:self.__textView.text];
    } else if(buttonIndex==3){
        [__appDelegate socailShareType:@"twitter" withText:self.__textView.text];
    } else if(buttonIndex == 4){
        [__appDelegate sendSMSFromController:self.__textView.text];
    }
}

- (void) addTextView
{
    
    __x = 10;
    __y = __elementsHolder.frame.size.height + __elementsHolder.frame.origin.y + 10;
    __w = self.view.frame.size.width - 20;
    __h = self.view.frame.size.height - (__y + 100);
    
    
    
    //__y = __appDelegate.window.frame.size.height - __h;

    self.__textView.frame = CGRectMake(__x, __y, __w, __h);
    self.__textView.backgroundColor = [UIColor clearColor];
    self.__textView.editable = FALSE;
    self.__textView.scrollEnabled = TRUE;
    
    [self.view addSubview:self.__textView];
}

- (void) addEmoIconsHolderView
{
    __x = 0;
    __y = self.navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height;
    
    __w = self.view.frame.size.width;
    __h = self.view.frame.size.height - (__y + 88);
    
    
    self.__emoIconsHolderView.frame = CGRectMake(__x, __y, __w, __h);
    
    self.__emoIconsHolderView.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
    
    [self.view addSubview:self.__emoIconsHolderView];
    
    
    __w = self.__emoIconsHolderView.frame.size.width;
    __h = self.__emoIconsHolderView.frame.size.height-40;
    
    __x = 0;
    __y = 0;
    
    
    UIScrollView *__iconsHolderSV = [[UIScrollView alloc] init];
    
    __iconsHolderSV.frame = CGRectMake(__x, __y, __w, __h);
    
    __iconsHolderSV.backgroundColor = [UIColor clearColor];
    
    [self.__emoIconsHolderView addSubview:__iconsHolderSV];
    
    __padding = 14;
    
    __w = 30;
    __h = 30;
    
    __x = __padding;
    __y = __padding;
    
    for (int i = 0; i < [emotions count]; i++) {
        
        
        NSString *input = [NSString stringWithFormat:@"%@",[emotions objectAtIndex:i]];
        NSString* esc1 = [input stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
        NSString* esc2 = [esc1 stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        NSString* quoted = [[@"\"" stringByAppendingString:esc2] stringByAppendingString:@"\""];
        NSData* data = [quoted dataUsingEncoding:NSUTF8StringEncoding];
        NSString* unesc = [NSPropertyListSerialization propertyListFromData:data
                                                           mutabilityOption:NSPropertyListImmutable format:NULL
                                                           errorDescription:NULL];
        assert([unesc isKindOfClass:[NSString class]]);
        
        UILabel *__emoLable = [[UILabel alloc] init];
        
        __emoLable.frame = CGRectMake(__x, __y, __w, __h);
        
        __emoLable.backgroundColor = [UIColor clearColor];
        
        __emoLable.text = unesc;
        
        [__iconsHolderSV addSubview:__emoLable];
        
        
        
        UIButton *__iconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        __iconBtn.frame = CGRectMake(__x, __y, __w, __h);
        
        __iconBtn.tag = i;
        
        __iconBtn.backgroundColor = [UIColor clearColor];
        //[__iconBtn setTitle:[NSString stringWithFormat:@"%d",i] forState:UIControlStateNormal];
        
        [__iconBtn addTarget:self action:@selector(emoticonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [__iconsHolderSV addSubview:__iconBtn];
        
        __x = __x + __padding + __w;
        
        if (__x > __iconsHolderSV.frame.size.width || (__x + __w) > __iconsHolderSV.frame.size.width) {
            __x = __padding;
            __y = __y + __padding + __h;
        }
        
        __iconsHolderSV.contentSize = CGSizeMake(__iconsHolderSV.frame.size.width, __y);
    }
    
    //.. Tool Bar
    __w = self.__emoIconsHolderView.frame.size.width;
    __h = 40;
    
    __x = 0;
    __y = self.__emoIconsHolderView.frame.size.height - __h;
    
    
    UIButton *__cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    
    __cancel.frame = CGRectMake(__x, __y, __w, __h);
    
    __cancel.backgroundColor = [UIColor redColor];
    
    [__cancel setTitle:@"Cancel" forState:UIControlStateNormal];
    
    [__cancel addTarget:self action:@selector(cancelClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.__emoIconsHolderView addSubview:__cancel];
    
    [self hideEmoIconsHolderView];
}

- (void) emoticonClicked:(UIButton *)sender
{
    //NSLog(@"Tag == %d",sender.tag);
    
    [emotionSelector setTitle:[NSString stringWithFormat:@"%@",[emotions objectAtIndex:sender.tag]] forState:UIControlStateNormal];
    
    [self hideEmoIconsHolderView];
}

- (void) cancelClicked:(UIButton *)sender
{
    [self hideEmoIconsHolderView];
}

-(void) emotionSelectorClicked: (UIButton *) sender{
    [word resignFirstResponder];
    //[emotionPicker setHidden:FALSE];
    [self showEmoIconsHolderView];
    
}

-(void) makeButtonClicked: (UIButton *) sender{
    [word resignFirstResponder];
    //[emotionPicker setHidden:TRUE];
    //[__appDelegate alert:[NSString stringWithFormat:@"%@===>%@",word.text, emotionSelector.titleLabel.text] withObject:@"Alert"];
    
    //NSUInteger length = [str length];
    
    ReturnWordArt *__returnWordArt = [[ReturnWordArt alloc] init];
    
    NSString *__textFieldStr = word.text;
    
    NSString *__artStr = @"";
    
    
    for (int i = 0; i < [__textFieldStr length]; i++) {
        
        NSString *subStr = [__textFieldStr substringWithRange:NSMakeRange(i, 1)];
        __artStr = [NSString stringWithFormat:@"%@\n%@",__artStr,[__returnWordArt returnEmoWord:emotionSelector.titleLabel.text w:subStr]];
    }
    
    NSString* esc1 = [__artStr stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString* esc2 = [esc1 stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    NSString* quoted = [[@"\"" stringByAppendingString:esc2] stringByAppendingString:@"\""];
    NSData* data = [quoted dataUsingEncoding:NSUTF8StringEncoding];
    NSString* unesc = [NSPropertyListSerialization propertyListFromData:data
                                                       mutabilityOption:NSPropertyListImmutable format:NULL
                                                       errorDescription:NULL];
    assert([unesc isKindOfClass:[NSString class]]);
    
    
    self.__textView.text = unesc;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [word resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSUInteger newLength = [word.text length] + [string length] - range.length;
    return (newLength > 40) ? NO : YES;
}

- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField
{
    NSString *__textFieldString = [NSString stringWithFormat:@"%@",[textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
    
    if ([__textFieldString isEqualToString:@"Add text"]) {
        
        textField.text = @"";
        textField.textColor = [UIColor blackColor];
    }
    
    //[self setFramesOnTextChange];
    
    return YES;
}


- (BOOL) textFieldShouldEndEditing:(UITextField *)textField
{
    NSString *__textFieldString = [NSString stringWithFormat:@"%@",[textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
    
    if ([__textFieldString isEqualToString:@""] || [__textFieldString isEqualToString:@"Add text"]) {
        
        textField.text = @"Add text";
        textField.textColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0];
    }
    
    //[self setFramesOnTextChange];
    
    return YES;
}

- (void) showEmoIconsHolderView
{
    CGRect __frame = self.__emoIconsHolderView.frame;
    
    __frame.origin.y = self.navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height;
    
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.__emoIconsHolderView.frame = __frame;
                     }
                     completion:nil];
}


- (void) hideEmoIconsHolderView
{
    CGRect __frame = self.__emoIconsHolderView.frame;
    
    __frame.origin.y = __appDelegate.window.frame.size.height;
    
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.__emoIconsHolderView.frame = __frame;
                     }
                     completion:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end