//
//  mojiAPI.h
//  emijo
//
//  Created by karamvir singh on 22/01/14.
//  Copyright (c) 2014 60Degree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSON/NSObject+SBJson.h"

@interface mojiAPI : UINavigationController

+(NSMutableDictionary *)requestForUpdateUserPic:(NSData *)__imageData uid:(NSString *)__uid;

@end
