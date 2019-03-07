//
//  Extensions.h
//  emijo
//
//  Created by karamvir singh on 31/01/14.
//  Copyright (c) 2014 60Degree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (MBBase64)
+ (id)dataWithBase64EncodedString:(NSString *)string;
- (NSString *)base64Encoding;
@end