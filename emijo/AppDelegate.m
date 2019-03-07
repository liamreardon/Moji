//
//  AppDelegate.m
//  emijo
//
//  Created by 60Degree on 11/28/13.
//  Copyright (c) 2013 60Degree. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"



@implementation AppDelegate


//.. Core data
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

@synthesize __navBarVC, __stickersArr, __stickersCategories, __stickerSubCat, __stickerImage, __sessionToken, __uid, __profilePic, __profileStatus, __username, __email, __firstname, __lastname, __deviceType;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    self.__deviceType = [UIDevice currentDevice].model;
    
    //NSLog(@"self.__deviceType == %@",self.__deviceType);
    
    //if([deviceType isEqualToString:@"iPhone"])
        // it's an iPhone

    self.__username = @"";
    self.__profileStatus = @"";
    self.__firstname = @"";
    self.__lastname = @"";
    self.__email = @"";
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    self.__stickersArr = [[NSMutableArray alloc] init];
    self.__stickersCategories = [[StickersCategories alloc] init];
    self.__stickerSubCat = [[StickerSubCat alloc] init];
    self.__stickerImage = [[StickerImage alloc] init];
    

    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self.viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    } else {
        self.viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    }

    self.__navBarVC = [[UINavigationController alloc] initWithRootViewController:self.viewController];
    //self.__navBarVC.navigationBar.tintColor = [UIColor colorWithRed:22.0/255.0 green:198.0/255.0 blue:242.0/255.0 alpha:1.0];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    if (SYSTEM_VERSION_LESS_THAN(@"7.0")) {
        [self.__navBarVC.navigationBar setTintColor:[UIColor colorWithRed:20.0/255.0 green:200.0/255.0 blue:240.0/255.0 alpha:1.0]];
    }else{
        UINavigationBar* navigationBar = self.__navBarVC.navigationBar;
        [navigationBar setBarTintColor:[UIColor colorWithRed:20.0/255.0 green:200.0/255.0 blue:240.0/255.0 alpha:1.0]];
    }
    
    [self.__navBarVC.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    self.window.rootViewController = self.__navBarVC;
    
    [self.window makeKeyAndVisible];
    
    [self getStickersFromJSON];
    
    return YES;
}


#pragma mark -
#pragma mark - Register User

- (void) updateUserPic:(NSData *)__imgDATA
{
    
    //NSLog(@"Send data == %@",__dataDict);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [NSThread sleepForTimeInterval:3];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSMutableDictionary *__recieveUserPicDict = [mojiAPI requestForUpdateUserPic:__imgDATA uid:self.__uid];
            
            //NSLog(@"__recieveUserPicDict == %@",__recieveUserPicDict);
            
            //NSString *__responseMessage = [NSString stringWithFormat:@"%@",[__recieveUserRegisterDict valueForKey:@"message"]];
            
            if([[NSString stringWithFormat:@"%@",[__recieveUserPicDict valueForKey:@"success"]] isEqualToString:@"1"]) {
                
            }else{
                
            }
        });
    });
    
}

/* Load Page Using String*/
-(void) loadPageFromString: (NSString *)nibName{
    UIViewController* object = (UIViewController*)[[NSClassFromString(nibName) alloc] initWithNibName:nibName bundle:nil];
    [self.__navBarVC pushViewController:object animated:YES];
}



- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



#pragma mark - Core Data stack

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}



// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"ProModel" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"ProModel.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

/****** Core Data Basic Objects And Methods*/

// Get Core data using entity name
-(NSMutableDictionary *)getData: (NSString *)str
{
    FMDatabase *db = [self openDb];
    FMResultSet *results = [db executeQuery:@"SELECT * FROM zmojis"];

    NSMutableDictionary *arr = [NSMutableDictionary dictionary];
    while([results next]) {
            NSString *data = [results stringForColumn:@"zdata"] ;
            NSString *name = [results stringForColumn:@"zname"];
            NSString *mojiId = [results stringForColumn:@"z_pk"];
            NSString *created = [results stringForColumn:@"zcreated"];
            NSMutableDictionary *temp = [[NSMutableDictionary alloc] initWithObjects:@[data,name,created] forKeys:@[@"data",@"name",@"created"]];
            [arr setObject:temp forKey:mojiId];
    }
    [db close];
    // Returning Fetched Recordsaq1
    return arr;
}

- (NSMutableArray *)getSavedMojisData
{
    // Fetch the devices from persistent data store
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Mojis"];
    
    //.. Push into Array
    NSMutableArray *dbMojisArray = [[NSMutableArray alloc] init];
    dbMojisArray = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    NSMutableArray *__dictArr = [[NSMutableArray alloc] init];
    
    //.. Is AppID Exist Or Not
    if ([dbMojisArray count]>0) {
        //NSLog(@"Count = %d",[dbLikesArray count]);
        for (int k=0; k<[dbMojisArray count]; k++)
        {
            NSManagedObject *__mojisDATA = [dbMojisArray objectAtIndex:k];
            
            NSMutableDictionary *__dataDict = [[NSMutableDictionary alloc] init];
            
            if ([__mojisDATA valueForKey:@"created"]) {
                [__dataDict setObject:[__mojisDATA valueForKey:@"created"] forKey:@"created"];
            }
            
            if ([__mojisDATA valueForKey:@"name"]) {
                [__dataDict setObject:[__mojisDATA valueForKey:@"name"] forKey:@"name"];
            }
            
            if ([__mojisDATA valueForKey:@"data"]) {
                [__dataDict setObject:[__mojisDATA valueForKey:@"data"] forKey:@"data"];
            }
            
            if ([__mojisDATA valueForKey:@"id"]) {
                [__dataDict setObject:[__mojisDATA valueForKey:@"id"] forKey:@"id"];
            }
            
            [__dictArr addObject:__dataDict];
            
        }
    }
    
    //NSLog(@"__dict == %@",__dictArr);
    
    // Returning Fetched Recordsaq1
    return __dictArr;
}

- (NSMutableDictionary *)getUserData
{
    
    // Fetch the devices from persistent data store
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"UserInfo"];
    
    //.. Push into Array
    NSMutableArray *dbUserProfileArray = [[NSMutableArray alloc] init];
    dbUserProfileArray = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    NSMutableDictionary *__dict = [NSMutableDictionary dictionary];
    
    //.. Is AppID Exist Or Not
    if ([dbUserProfileArray count]>0) {
        
        
        
        for (int k=0; k<[dbUserProfileArray count]; k++)
        {
            NSManagedObject *__userDATA = [dbUserProfileArray objectAtIndex:k];
            
            if ([__userDATA valueForKey:@"id"]) {
                [__dict setObject:[__userDATA valueForKey:@"id"] forKey:@"id"];
                
            }
            
            if ([__userDATA valueForKey:@"img"]) {
                [__dict setObject:[__userDATA valueForKey:@"img"] forKey:@"img"];
                
            }
            
            if ([__userDATA valueForKey:@"name"]) {
                [__dict setObject:[__userDATA valueForKey:@"name"] forKey:@"name"];
                
            }
            
            if ([__userDATA valueForKey:@"status"]) {
                [__dict setObject:[__userDATA valueForKey:@"status"] forKey:@"status"];
                
            }
            
            if ([__userDATA valueForKey:@"followers"]) {
                [__dict setObject:[__userDATA valueForKey:@"followers"] forKey:@"followers"];
                
            }
            
            if ([__userDATA valueForKey:@"following"]) {
                [__dict setObject:[__userDATA valueForKey:@"following"] forKey:@"following"];
                
            }
            
            if ([__userDATA valueForKey:@"sessionToken"]) {
                [__dict setObject:[__userDATA valueForKey:@"sessionToken"] forKey:@"sessionToken"];
            }
            
            if ([__userDATA valueForKey:@"firstname"]) {
                [__dict setObject:[__userDATA valueForKey:@"firstname"] forKey:@"firstname"];
            }
            
            if ([__userDATA valueForKey:@"lastname"]) {
                [__dict setObject:[__userDATA valueForKey:@"lastname"] forKey:@"lastname"];
            }
            
            if ([__userDATA valueForKey:@"email"]) {
                [__dict setObject:[__userDATA valueForKey:@"email"] forKey:@"email"];
            }
        }
    }
    
    //NSLog(@"__dict == %@",__dict);
    
    // Returning Fetched Recordsaq1
    return __dict;
}

/* Make Server Request And Get Response Methods starts here */
@synthesize receivedData, theConnection;

-(NSMutableDictionary *) makeRequest: (NSString *)bodyData{


    /* Post Request*/
    NSString *serverUrl = @"http://192.232.214.244/~avanttec/animoji/index.php/json";
    //NSLog(@"URl: %@?%@", serverUrl, bodyData);
    
    NSMutableURLRequest *postRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:serverUrl]];
    
    // Set the request's content type to application/x-www-form-urlencoded
    [postRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    // Designate the request a POST request and specify its body data
    [postRequest setHTTPMethod:@"POST"];
    [postRequest setHTTPBody:[NSData dataWithBytes:[bodyData UTF8String] length:strlen([bodyData UTF8String])]];
    
    receivedData = [NSMutableData dataWithCapacity: 0];
    
    theConnection=[[NSURLConnection alloc] init];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    if (!theConnection) {
        receivedData = nil;
        dict = nil;
    } else {
        NSURLResponse* response;
        NSError* error;
        NSData *responseData = [NSURLConnection sendSynchronousRequest:postRequest  returningResponse:&response error:&error];
        if(!error) {
            dict = [self parseJson:responseData];
        } else {
            [self alert:[NSString stringWithFormat:@"%@",error] withObject:@"Error"];
        }
    }
    
    //NSLog(@"dict == %@",dict);
    
    return dict;
}

//...Parse Json String to NSDict
-(NSMutableDictionary *) parseJson: (NSData *)jsonString{
    NSError* error;
    NSMutableDictionary* response = [NSJSONSerialization
                                     JSONObjectWithData:jsonString
                                     options:kNilOptions
                                     error:&error];
    return response;
}

//. NSarray to Json
-(NSString *)arrayToJson:(NSArray *)arr{
    NSError *error;
NSData *jsonData = [NSJSONSerialization dataWithJSONObject:arr
                                                   options:NSJSONWritingPrettyPrinted error:&error];
NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return jsonString;
}
/* Make Server Request And Get Response Methods ends here */

/* Alert Box*/
-(void) alert: (NSString *) msg withObject:(NSString *)title {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}



/* SQLite Funtions */

-(FMDatabase *) openDb{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"database.sqlite"];
    //NSLog(@"%@",path);
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    return database;
}


-(NSMutableArray *)getLikes{
    
    
    
    // Fetch the devices from persistent data store
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Likes"];
    
    //.. Push into Array
    NSMutableArray *dbLikesArray = [[NSMutableArray alloc] init];
    dbLikesArray = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    NSMutableArray *__dictArr = [[NSMutableArray alloc] init];
    
    //.. Is AppID Exist Or Not
    if ([dbLikesArray count]>0) {
        //NSLog(@"Count = %d",[dbLikesArray count]);
        for (int k=0; k<[dbLikesArray count]; k++)
        {
            NSManagedObject *__likesDATA = [dbLikesArray objectAtIndex:k];
            
            if ([__likesDATA valueForKey:@"servermojid"]) {
                [__dictArr addObject:[__likesDATA valueForKey:@"servermojid"]];
            }
        }
    }
    
    //NSLog(@"__dict == %@",__dictArr);
    
    // Returning Fetched Recordsaq1
    return __dictArr;
    
    
    
    
//    //AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
//    FMDatabase *db = [self openDb];
//    FMResultSet *results = [db executeQuery:@"SELECT * FROM zlikes"];
//    
//    if([db lastErrorCode] >0){
//        // initializing NSFetchRequest
//        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//        
//        //Setting Entity to be Queried
//        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Likes"
//                                                  inManagedObjectContext:self.managedObjectContext];
//        [fetchRequest setEntity:entity];
//        
//        NSError* error;
//        
//        // Query on managedObjectContext With Generated fetchRequest
//        NSArray *fetchedRecords = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
//        NSLog(@"%@",fetchedRecords);
//    }
//    
//    NSMutableDictionary *arr = [NSMutableDictionary dictionary];
//    while([results next]) {
//        NSString *serverId = [results stringForColumn:@"zservermojid"];
//        NSString *id = [results stringForColumn:@"z_pk"];
//        [arr setObject:serverId forKey:id];
//    }
//    [db close];
//    return arr;
}

/* Sqlite Funtions Ends Here*/

/* Other Funtions */


- (NSString *)timeIntervalToStringWithInterval:(NSTimeInterval)interval
{
    NSString *retVal = @"At time of event";
    if (interval == 0) return retVal;
    int second = 1;
    int minute = second*60;
    int hour = minute*60;
    int day = hour*24;
    // interval can be before (negative) or after (positive)
    int num = abs(interval);
    
    NSString *beforeOrAfter = @"Ago";
    NSString *unit = @"d";
    if (interval > 0) {
        beforeOrAfter = @"after";
    }
    
    if (num >= day) {
        num /= day;
        if (num > 1) unit = @"d";
    } else if (num >= hour) {
        num /= hour;
        unit = (num > 1) ? @"h" : @"h";
    } else if (num >= minute) {
        num /= minute;
        unit = (num > 1) ? @"m" : @"m";
    } else if (num >= second) {
        num /= second;
        unit = (num > 1) ? @"s" : @"s";
    }
    if([[NSString stringWithFormat:@"%d",num] length]==1){
        return [NSString stringWithFormat:@"0%d%@ %@", num, unit, beforeOrAfter];
    } else {
        return [NSString stringWithFormat:@"%d%@ %@", num, unit, beforeOrAfter];
    }
    
}

//. Social Methods

- (void)socailShareType: (NSString *) type withText: (NSString *)text
{
    
    // if we're not on iOS 6, SLComposeViewController won't be available. Then fallback on website.
    Class composeViewControllerClass = [SLComposeViewController class];
    
    id service;
    
    if([type isEqual:@"facebook"]) {
        service = SLServiceTypeFacebook;
    } else {
        service = SLServiceTypeTwitter;
    }
    
    SLComposeViewController *composeViewController = [composeViewControllerClass composeViewControllerForServiceType:service];
    [composeViewController setInitialText:text];

    
    //[self presentModalViewController:composeViewController animated:YES ];
    [self.viewController presentViewController:composeViewController animated:YES completion:nil];
}

- (void)socailShareType: (NSString *) type withImage: (UIImage *)img
{
    
    // if we're not on iOS 6, SLComposeViewController won't be available. Then fallback on website.
    Class composeViewControllerClass = [SLComposeViewController class];
    
    id service;
    
    if([type isEqual:@"facebook"]) {
        service = SLServiceTypeFacebook;
    } else {
        service = SLServiceTypeTwitter;
    }
    
    SLComposeViewController *composeViewController = [composeViewControllerClass composeViewControllerForServiceType:service];
    [composeViewController addImage:img];
    
    
    //[self presentModalViewController:composeViewController animated:YES ];
    [self.viewController presentViewController:composeViewController animated:YES completion:nil];
}


/* Mail Methods starts from here */
-(void) sendMailWithSubject:(NSString *) subject andBody:(NSString *)mailBody {
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        mailer.mailComposeDelegate = self;
        [mailer setSubject:subject];
        NSArray *toRecipients = [NSArray arrayWithObjects:@"amit.rana@60degree.com", nil];
        [mailer setToRecipients:toRecipients];
        NSString *emailBody = mailBody;
        [mailer setMessageBody:emailBody isHTML:NO];
        [self.viewController presentViewController:mailer animated:YES completion:nil];
    }
    else
    {
        [self alert:@"Your device doesn't support the composer sheet" withObject:@"Failure"];
    }
}

- (void) sendMailWithSubject:(NSString *) subject andBody:(NSString *)mailBody i:(UIImage *)__img
{
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        
        NSData *data = UIImagePNGRepresentation(__img);
        [mailer addAttachmentData:data mimeType:@"image/png" fileName:@"Moji Sticker"];
        
        mailer.mailComposeDelegate = self;
        [mailer setSubject:subject];
        NSArray *toRecipients = [NSArray arrayWithObjects:@"amit.rana@60degree.com", nil];
        [mailer setToRecipients:toRecipients];
        NSString *emailBody = mailBody;
        [mailer setMessageBody:emailBody isHTML:NO];
        [self.viewController presentViewController:mailer animated:YES completion:nil];
    }
    else
    {
        [self alert:@"Your device doesn't support the composer sheet" withObject:@"Failure"];
    }
}

#pragma mark - MFMailComposeViewControllerDelegate
-(void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult: (MFMailComposeResult)result error:(NSError*)error {
    [self.viewController dismissViewControllerAnimated:YES completion:Nil];
}


#pragma mark -
#pragma mark - get Menus list from JSON

- (void) getStickersFromJSON
{
    if ([self.__stickersArr count]>0)
    {
        [self.__stickersArr removeAllObjects];
    }
    
    // Fill myString with questions from the .txt file and then read .txt file
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"stickers" ofType:@"json"];
    // Retrieve local JSON file called example.json
    
    NSStringEncoding encoding;
    NSError *error;
    NSString *fileContent = [[NSString alloc] initWithContentsOfFile:filePath usedEncoding:&encoding error:&error];
    
    if (!fileContent) {
        NSLog(@"error: %@", error);
        return;
    }
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[fileContent dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    
    NSMutableArray *getCategoriesArr = [json objectForKey:@"categories"];
    
    //NSLog(@"[getCategoriesArr count] == %d",[getCategoriesArr count]);
    
    
    for (int j = 0; j<[getCategoriesArr count]; j++)
    {
        
        NSMutableDictionary *catDict = [[NSMutableDictionary alloc] init];
        catDict = [getCategoriesArr objectAtIndex:j];

        self.__stickersCategories = [[StickersCategories alloc] init];
        
        self.__stickersCategories.__title = [catDict valueForKey:@"name"];
        
        NSMutableArray *getSubCatListArr = [catDict valueForKey:@"cats"];
        
        //NSLog(@"Category = %@",self.__stickersCategories.__title);
        
        //NSLog(@"[getSubCatListArr count] == %d",[getSubCatListArr count]);
        if ([getSubCatListArr count]>0)
        {
            self.__stickersCategories.__subCatArr = [[NSMutableArray alloc] init];
            
            for (int i = 0; i<[getSubCatListArr count]; i++)
            {
                NSMutableDictionary *subCatDict = [[NSMutableDictionary alloc] init];
                subCatDict = [getSubCatListArr objectAtIndex:i];
                
                self.__stickerSubCat = [[StickerSubCat alloc] init];
                
                self.__stickerSubCat.__title = [subCatDict valueForKey:@"name"];
                
                //NSLog(@"Sub Category = %@",self.__stickerSubCat.__title);
                
                NSMutableArray *getSubCatImagesListArr = [subCatDict valueForKey:@"images"];
                
                if ([getSubCatImagesListArr count]>0)
                {
                     self.__stickerSubCat.__imagesArr = [[NSMutableArray alloc] init];
                    
                    for (int k = 0; k<[getSubCatImagesListArr count]; k++)
                    {
                        NSMutableDictionary *subCatImageDict = [[NSMutableDictionary alloc] init];
                        subCatImageDict = [getSubCatImagesListArr objectAtIndex:k];
                        
                        self.__stickerImage = [[StickerImage alloc] init];
                        //NSLog(@"ID == %@",[subCatImageDict valueForKey:@"id"]);
                        self.__stickerImage.__id = [subCatImageDict valueForKey:@"id"];
                        self.__stickerImage.__path = [subCatImageDict valueForKey:@"path"];
                        
                        [self.__stickerSubCat.__imagesArr addObject:self.__stickerImage];
                        
                    }
                    
                }
                
                [self.__stickersCategories.__subCatArr addObject:self.__stickerSubCat];
                
            }
        }
        
        [self.__stickersArr addObject:self.__stickersCategories];
    }
}

-(void)sendSMSFromController:(NSString *)textBody
{
    self.messageComposer = [MFMessageComposeViewController new];
    
    if([MFMessageComposeViewController canSendText]) {
        [_messageComposer setBody:textBody];
        //[_messageComposer setRecipients:[NSArray arrayWithObjects:_recipient, nil]];
        [_messageComposer setMessageComposeDelegate:self];
        [self.viewController presentViewController:_messageComposer animated:NO completion:NULL];
    }
}

-(void)sendSMSFromControllerWithImageData:(NSData*)imgData
{
    self.messageComposer = [MFMessageComposeViewController new];
    
    if([MFMessageComposeViewController canSendText]) {
        
        BOOL didAttachImage = [_messageComposer addAttachmentData:imgData typeIdentifier:@"public.data" filename:@"image"];
        
        if (didAttachImage)
        {
            // Present message view controller on screen
            [_messageComposer setMessageComposeDelegate:self];
            [self.viewController presentViewController:_messageComposer animated:NO completion:NULL];
        }
        else
        {
            UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                   message:@"Failed to attach image"
                                                                  delegate:nil
                                                         cancelButtonTitle:@"OK"
                                                         otherButtonTitles:nil];
            [warningAlert show];
            return;
        }
        
    }
    
//    
//    if([MFMessageComposeViewController canSendText]) {
//        [_messageComposer setBody:textBody];
//        //[_messageComposer setRecipients:[NSArray arrayWithObjects:_recipient, nil]];
//        [_messageComposer setMessageComposeDelegate:self];
//        [self.viewController presentViewController:_messageComposer animated:NO completion:NULL];
//    }
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    switch (result) {
        case MessageComposeResultCancelled:
            NSLog(@"Message sending cancelled.");
            break;
            
        case MessageComposeResultFailed:
            NSLog(@"Message sending failed.");
            break;
            
        case MessageComposeResultSent:
            NSLog(@"Message sent.");
        default:
            break;
    }
    
    [controller dismissViewControllerAnimated:YES completion:^(){
        self.messageComposer = nil;
    }];
}

@end
