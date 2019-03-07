//
//  TakePhotoOptionsView.h
//  songpal
//
//  Created by 60Degree on 7/5/13.
//  Copyright (c) 2013 60Degree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <QuartzCore/QuartzCore.h>

typedef void (^ALAssetsLibraryWriteImageCompletionBlock)(NSURL *assetURL, NSError *error);

#import "AppDelegate.h"

@interface TakePhotoOptionsView : UIControl <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    AppDelegate *__appDelegate;
    
    float __x;
    float __y;
    float __w;
    float __h;
    float __padding;
    NSString *__sourceTYPE;
}


//.. Define Variables
@property (nonatomic, retain) UIView *__elementsHolderView;
@property (nonatomic, retain) UIView *__blackTransparentView;

@property (nonatomic, retain) UIView *__photoOptionsBG;

@property (nonatomic, retain) UILabel *__titleLabel;
@property (nonatomic, retain) NSString *__titleLabelStr;
@property (nonatomic, retain) UIButton *__closeBTN;

@property (nonatomic, retain) UIImage *__selectedIMAGE;

@property (nonatomic, retain) NSString *__selectedImageURL;


//.. Default Methods
- (void) initAndSetVariables;
- (void) drawElements;


//.. Add Views Methods
- (void) addBlackTransparentView;
- (void) addElementsHolderView;
- (void) addPhotoOptionsBG;
- (void) addTitleLabel;
- (void) addTakePhotoBTN;
- (void) addChooseFromLibraryBTN;
- (void) addCloseBTN;

//.. Return Button
- (UIButton *) addFileOptionsButton:(CGRect )__frame s:(NSString *)__labletext i:(NSString *)__iocnName fun:(SEL )__funcName;



@end
