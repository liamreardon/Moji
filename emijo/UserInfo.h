//
//  UserInfo.h
//  emijo
//
//  Created by karamvir singh on 31/01/14.
//  Copyright (c) 2014 60Degree. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface UserInfo : NSManagedObject

@property (nonatomic, retain) NSString * followers;
@property (nonatomic, retain) NSString * following;
@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSString * img;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * sessionToken;
@property (nonatomic, retain) NSString * status;
@property (nonatomic, retain) NSString * firstname;
@property (nonatomic, retain) NSString * lastname;
@property (nonatomic, retain) NSString * email;

@end
