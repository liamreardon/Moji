//
//  TakePhotoOptionsView.m
//  songpal
//
//  Created by 60Degree on 7/5/13.
//  Copyright (c) 2013 60Degree. All rights reserved.
//

#import "TakePhotoOptionsView.h"

@implementation TakePhotoOptionsView

@synthesize __blackTransparentView, __elementsHolderView, __photoOptionsBG, __selectedIMAGE, __titleLabel, __titleLabelStr, __closeBTN, __selectedImageURL;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        __appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
        
        //.. Call Method
        [self initAndSetVariables];
    }
    return self;
}

#pragma mark -
#pragma mark - Initialize Variables

- (void) initAndSetVariables
{
    self.__blackTransparentView = [[UIView alloc] init];
    self.__elementsHolderView = [[UIView alloc] init];
    self.__photoOptionsBG = [[UIView alloc] init];
    self.__selectedIMAGE = [[UIImage alloc] init];
    self.__titleLabel = [[UILabel alloc] init];
    self.__closeBTN = [UIButton buttonWithType:UIButtonTypeCustom];
    
}

#pragma mark -
#pragma mark - Draw Elements

- (void) drawElements
{
    [self addBlackTransparentView];
    [self addElementsHolderView];
    [self addPhotoOptionsBG];
    [self addTitleLabel];
    [self addTakePhotoBTN];
    [self addChooseFromLibraryBTN];
    [self addCloseBTN];
}

#pragma mark -
#pragma mark - Add Black Transparent View

- (void) addBlackTransparentView
{
    //.. Add Black Transparent View
    self.__blackTransparentView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.__blackTransparentView.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.8];
    self.__blackTransparentView.alpha = 0.0;
    
    [self addSubview:self.__blackTransparentView];
    
    [UIView animateWithDuration:0.2 animations:^() {
        self.__blackTransparentView.alpha = 1.0;
    }];
}

#pragma mark -
#pragma mark - Add Elements Holder View

- (void) addElementsHolderView
{
    //.. Set dimenssions and position
    __w = 264;
    __h = 246;
    __x = (self.frame.size.width-__w)/2;
    __y = (self.frame.size.height-__h)/2;
    
    //.. Set Frame
    self.__elementsHolderView.frame = CGRectMake(__x, __y, __w, __h);
    
    //.. Set Alpha
    self.__elementsHolderView.alpha = 0.0;
    self.__elementsHolderView.transform = CGAffineTransformMakeScale(0.0, 0.0);
    
    //.. Set Background Color
    self.__elementsHolderView.backgroundColor = [UIColor clearColor];
    
    //.. Add on Self View
    [self addSubview:self.__elementsHolderView];
    
    //.. set animation
    [UIView animateWithDuration:0.4 animations:^() {
        self.__elementsHolderView.alpha = 1.0;
        self.__elementsHolderView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    }];
}

#pragma mark -
#pragma mark - Add Photo Options BG

- (void) addPhotoOptionsBG
{   
    //.. Set dimenssions and position
    __w = 253;
    __h = 232;
    __x = 0;
    __y = self.__elementsHolderView.frame.size.height-__h;
    
    //.. Set Frame
    self.__photoOptionsBG.frame = CGRectMake(__x, __y, __w, __h);
    self.__photoOptionsBG.layer.cornerRadius = 10;
    self.__photoOptionsBG.layer.masksToBounds = YES;
    
    //.. Set Background
    //self.__photoOptionsBG.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"register_screen_bg.png"]];
    
    self.__photoOptionsBG.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
    
    //.. Add on Elements Holder View
    [self.__elementsHolderView addSubview:self.__photoOptionsBG];
}

#pragma mark -
#pragma mark - Add Title Label

- (void) addTitleLabel
{
    //.. Set dimenssions and position
    __w = 230;
    __h = 50;
    __x = 16;
    __y = 30;
    
    //.. Set Frame
    self.__titleLabel.frame = CGRectMake(__x, __y, __w, __h);
    
    //.. Set values
    self.__titleLabel.text = self.__titleLabelStr;
    self.__titleLabel.backgroundColor = [UIColor colorWithRed:239.0/255.0 green:96.0/255.0 blue:0.0/255.0 alpha:0.00];
    self.__titleLabel.textColor = [UIColor blackColor];
    self.__titleLabel.textAlignment = NSTextAlignmentCenter;
    self.__titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:18];
    
    //.. Add on Elements Holder View
    [self.__elementsHolderView addSubview:self.__titleLabel];
    
    __y = self.__titleLabel.frame.origin.y + self.__titleLabel.frame.size.height;
    __w = 228;
    __h = 55;
}

#pragma mark -
#pragma mark - Add Take Photo Button

- (void) addTakePhotoBTN
{
    __padding = 10;
    
    // If there is camera on this device, so show the Take Photo button.
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        __padding = 10;
        
        //.. Set dimenssions and position
        __y = __y + __padding;
        
        //..
         CGRect __frame = CGRectMake(__x, __y, __w, __h);
        SEL __funcName = @selector(takePhotoBtnClicked:);
        
        //.. Add on Elements Holder View
        [self.__elementsHolderView addSubview:[self addFileOptionsButton:__frame s:@"Take picture" i:@"camera_icon.png" fun:__funcName]];
        
        //.. Set y position for next element
        __y = __y + __h;
        
        __padding = 5;
    }
}

- (void) takePhotoBtnClicked: (UIButton *)sender
{
    
    UIImage *__loaderImg = [UIImage imageNamed:@"loader.png"];
    
    UIImageView *__loaderImgView = [[UIImageView alloc] init];
    
    __loaderImgView.tag = 20023;
    __loaderImgView.frame = CGRectMake(sender.frame.size.width - (__loaderImg.size.width + 10), (sender.frame.size.height - __loaderImg.size.height)/2, __loaderImg.size.width, __loaderImg.size.height);
    
    __loaderImgView.image = __loaderImg;
    
    [sender addSubview:__loaderImgView];
    
    //rotation
    CABasicAnimation *fullRotation;
    fullRotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    fullRotation.fromValue = [NSNumber numberWithFloat:0];
    fullRotation.toValue = [NSNumber numberWithFloat:((360*M_PI)/180)];
    fullRotation.duration = 10.0;
    fullRotation.repeatCount = 100000000000000;
    
    [__loaderImgView.layer addAnimation:fullRotation forKey:@"360"];
    
    UIImagePickerController * imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.modalPresentationStyle = UIModalPresentationCurrentContext;
    imagePickerController.delegate = self;
    
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        __sourceTYPE = @"UIImagePickerControllerSourceTypeCamera";
        
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        //[self presentModalViewController:picker animated:YES];
        [__appDelegate.__navBarVC presentViewController:imagePickerController animated:YES completion:nil];
    }
    
    for (UIImageView *__iv in sender.subviews) {
        if (__iv.tag == 20023) {
            [__iv removeFromSuperview];
            break;
        }
    }
    
    NSTimer *__myTimer;
    __myTimer = [NSTimer scheduledTimerWithTimeInterval: 0.001 target: self
                                               selector: @selector(removeSelfView:) userInfo: nil repeats: NO];
}

#pragma mark -
#pragma mark - Add Choose From Library Button

- (void) addChooseFromLibraryBTN
{
    //.. Set dimenssions and position
    __y = __y + __padding;
    
    //..
    CGRect __frame = CGRectMake(__x, __y, __w, __h);
    SEL __funcName = @selector(chooseFromLibraryBtnClicked:);
    
    //.. Add on Elements Holder View
    [self.__elementsHolderView addSubview:[self addFileOptionsButton:__frame s:@"Insert from camera roll" i:@"library_icon.png" fun:__funcName]];
}

- (void) chooseFromLibraryBtnClicked: (UIButton *)sender
{
    
    
    UIImage *__loaderImg = [UIImage imageNamed:@"loader.png"];
    
    UIImageView *__loaderImgView = [[UIImageView alloc] init];
    
    __loaderImgView.tag = 20022;
    __loaderImgView.frame = CGRectMake(sender.frame.size.width - (__loaderImg.size.width + 10), (sender.frame.size.height - __loaderImg.size.height)/2, __loaderImg.size.width, __loaderImg.size.height);
    
    __loaderImgView.image = __loaderImg;
    
    [sender addSubview:__loaderImgView];
    
    //rotation
    CABasicAnimation *fullRotation;
    fullRotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    fullRotation.fromValue = [NSNumber numberWithFloat:0];
    fullRotation.toValue = [NSNumber numberWithFloat:((360*M_PI)/180)];
    fullRotation.duration = 10.0;
    fullRotation.repeatCount = 100000000000000;
    
    [__loaderImgView.layer addAnimation:fullRotation forKey:@"360"];
    
    
  
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.modalPresentationStyle = UIModalPresentationCurrentContext;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;
    
    __sourceTYPE = @"UIImagePickerControllerSourceTypePhotoLibrary";
    
    [__appDelegate.__navBarVC presentViewController:imagePickerController animated:YES completion:nil];
    
    
    for (UIImageView *__iv in sender.subviews) {
        if (__iv.tag == 20022) {
            [__iv removeFromSuperview];
            break;
        }
    }
    
    NSTimer *__myTimer;
    __myTimer = [NSTimer scheduledTimerWithTimeInterval: 0.001 target: self
                                               selector: @selector(removeSelfView:) userInfo: nil repeats: NO];
 
}

#pragma mark -
#pragma mark - Add Close Btn

- (void) addCloseBTN
{
    //.. Set Image
    UIImage *__closeButtonImage = [[UIImage imageNamed:@"close_btn_icon.png"]  resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 28, 28)];
    [self.__closeBTN setImage:__closeButtonImage forState:UIControlStateNormal];
    
    //.. Set dimenssions and position
    __w = __closeButtonImage.size.width;
    __h = __closeButtonImage.size.height;
    __x = self.__elementsHolderView.frame.size.width - __w;
    __y = 0;
    
    self.__closeBTN.frame = CGRectMake(__x, __y, __w, __h);
    
    [self.__closeBTN addTarget:self action:@selector(closeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.__elementsHolderView addSubview:self.__closeBTN];
    
    
}

- (void) closeButtonClicked: (UIButton *)sender
{
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.__elementsHolderView.alpha = 0.0;
                         self.__elementsHolderView.transform = CGAffineTransformMakeScale(0.0, 0.0);
                         self.__blackTransparentView.alpha = 0.0;
                     }
                     completion:nil];
    NSTimer *__myTimer;
    __myTimer = [NSTimer scheduledTimerWithTimeInterval: 0.3 target: self
                                               selector: @selector(removeSelfView:) userInfo: nil repeats: NO];
}

#pragma mark -
#pragma mark - Return File Options Button

- (UIButton *) addFileOptionsButton:(CGRect )__frame s:(NSString *)__labletext i:(NSString *)__iocnName fun:(SEL )__funcName
{
    //UIImage *__buttonImage = [[UIImage imageNamed:@"photo_option_BTN.png"]  resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 228, 55)];
    //UIImage *__buttonImageHighlighted = [[UIImage imageNamed:@"photo_option_BTN_highlighted.png"]  resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 228, 55)];
    
    UIButton *__btn = [UIButton buttonWithType:UIButtonTypeCustom];
    //[__btn setImage:__buttonImage forState:UIControlStateNormal];
    //[__btn setImage:__buttonImageHighlighted forState:UIControlStateHighlighted];
    __btn.backgroundColor = [UIColor clearColor];
    __btn.frame = __frame;
    
    UIImage *__iconImage = [UIImage imageNamed:__iocnName];
    UIImageView *__iconImageView = [[UIImageView alloc] initWithImage:__iconImage];
    [__iconImageView setFrame:CGRectMake(11.5, 11.5, 32, 32)];
    
    [__btn addSubview:__iconImageView];
    
    UILabel *__titleLBL = [[UILabel alloc] initWithFrame:CGRectMake(55, 0, __btn.frame.size.width-55, __btn.frame.size.height)];
    
    __titleLBL.backgroundColor = [UIColor clearColor];
    __titleLBL.text = __labletext;
    __titleLBL.textColor = [UIColor colorWithRed:100.0/255.0 green:100.0/255.0 blue:100.0/255.0 alpha:1.0];
    __titleLBL.textAlignment = NSTextAlignmentLeft;
    __titleLBL.font = [UIFont fontWithName:@"Trebuchet MS" size:13];
    
    [__btn addSubview:__titleLBL];
    
    [__btn addTarget:self action:__funcName forControlEvents:UIControlEventTouchUpInside];
    
    
    return __btn;
}

#pragma mark -
#pragma mark - UIImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.__selectedIMAGE = [info valueForKey:UIImagePickerControllerOriginalImage];
    
    self.__selectedImageURL = nil;
    
    #pragma mark get image url from camera capture.
    
    // If there is camera on this device, so show the Take Photo button.
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] && [__sourceTYPE isEqualToString:@"UIImagePickerControllerSourceTypeCamera"])
    {
//        ALAssetsLibraryWriteImageCompletionBlock completeBlock = ^(NSURL *assetURL, NSError *error){
//            if (!error) {
//            #pragma mark get image url from camera capture.
//                self.__selectedImageURL = [NSString stringWithFormat:@"%@",assetURL];
//            }
//        };
        
        if(self.__selectedIMAGE){
            ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
            [library writeImageToSavedPhotosAlbum:[self.__selectedIMAGE CGImage]
                                      orientation:(ALAssetOrientation)[self.__selectedIMAGE imageOrientation]
                                  completionBlock:^(NSURL *assetURL, NSError *error){
                                      if (error) {
                                          NSLog(@"error");
                                      } else {
                                          self.__selectedImageURL = [NSString stringWithFormat:@"%@",assetURL];
                                          //NSLog(@"url %@", assetURL);
                                          [self sendActionsForControlEvents:UIControlEventValueChanged];
                                      }  
                                  }];
        }
    }else{
        // grab the image url
        self.__selectedImageURL = [NSString stringWithFormat:@"%@",[info valueForKey: UIImagePickerControllerReferenceURL]];
        
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
    
    
    
    
    
//    NSTimer *__myTimer;
//    __myTimer = [NSTimer scheduledTimerWithTimeInterval: 0.001 target: self
//                                               selector: @selector(removeSelfView:) userInfo: nil repeats: NO];
    
    [__appDelegate.__navBarVC dismissViewControllerAnimated:YES completion:nil];
    
    //..NSLog(@"url = %@", self.__selectedImageURL);
    
    return;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [__appDelegate.__navBarVC dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark - Remove Self View

- (void) removeSelfView:(NSTimer *)__myTimer
{
    //NSLog(@"Enter");
    
    [self removeFromSuperview];
    
    //.. Stop the interval timer
    [__myTimer invalidate];
    __myTimer = nil;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
