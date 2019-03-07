//
//  Mojis.h
//  emijo
//
//  Created by karamvir singh on 21/01/14.
//  Copyright (c) 2014 60Degree. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Mojis : NSManagedObject

@property (nonatomic, retain) NSDate * created;
@property (nonatomic, retain) NSString * data;
@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSString * name;

@end
