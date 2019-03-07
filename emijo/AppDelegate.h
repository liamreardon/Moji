//
//  AppDelegate.h
//  emijo
//
//  Created by 60Degree on 11/28/13.
//  Copyright (c) 2013 60Degree. All rights reserved.
//


#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


#import <UIKit/UIKit.h>
#import "UIButton+Property.h"
#import <sqlite3.h>
#import "FMDatabase.h"

#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMessageComposeViewController.h>
#import <Social/Social.h>

#import "JSON/NSObject+SBJson.h"

//.. Stickers model
#import "StickersCategories.h"
#import "StickerSubCat.h"
#import "StickerImage.h"

#import <CoreData/CoreData.h>

#import "mojiAPI.h"

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

@property (strong, nonatomic) UINavigationController *__navBarVC;

//.. Core Data START
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
//.. Core Data END

-(NSMutableDictionary *)getData: (NSString *)str;
- (NSMutableArray *)getSavedMojisData;


-(void) alert: (NSString *) msg withObject:(NSString *)title;

- (NSMutableDictionary *)getUserData;

//. Server Request Methods and Properties
-(NSMutableDictionary *) makeRequest:(NSString *)bodyData;

@property(nonatomic, retain) NSMutableData *receivedData;
@property (nonatomic, retain) NSURLConnection *theConnection;

-(void) loadPageFromString: (NSString *)nibName;

-(NSString *)arrayToJson:(NSArray *)arr;


//.Sqlite
-(FMDatabase *) openDb;
-(NSMutableArray *)getLikes;

//.Other Methods
- (NSString *)timeIntervalToStringWithInterval:(NSTimeInterval)interval;

//.Social Methods

- (void)socailShareType: (NSString *) type withText: (NSString *)text;
- (void) sendMailWithSubject:(NSString *) subject andBody:(NSString *)mailBody;

- (void) sendMailWithSubject:(NSString *) subject andBody:(NSString *)mailBody i:(UIImage *)__img;

- (void)socailShareType: (NSString *) type withImage: (UIImage *)img;


@property (nonatomic, retain) NSMutableArray *__stickersArr;

@property (nonatomic, retain) StickersCategories *__stickersCategories;
@property (nonatomic, retain) StickerSubCat *__stickerSubCat;
@property (nonatomic, retain) StickerImage *__stickerImage;

- (void) getStickersFromJSON;

@property (nonatomic, retain) NSString *__sessionToken;
@property (nonatomic, retain) NSString *__uid;
@property (nonatomic, retain) NSString *__username;
@property (nonatomic, retain) NSString *__profilePic;
@property (nonatomic, retain) NSString *__profileStatus;
@property (nonatomic, retain) NSString *__firstname;
@property (nonatomic, retain) NSString *__lastname;
@property (nonatomic, retain) NSString *__email;

@property (nonatomic, retain) NSString *__deviceType;


- (void) updateUserPic:(NSData *)__imgDATA;

@property (nonatomic, strong, retain) MFMessageComposeViewController *messageComposer;
-(void)sendSMSFromController:(NSString*)textBody;
-(void)sendSMSFromControllerWithImageData:(NSData*)imgData;

@end
