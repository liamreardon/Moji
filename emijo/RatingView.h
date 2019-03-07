//
//  RatingView.h
//  emijo
//
//  Created by 60Degree on 12/23/13.
//  Copyright (c) 2013 60Degree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarRatingView.h"
#import "AppDelegate.h"

@interface RatingView : UIControl{
    AppDelegate *__appDelegate;
}

@property (nonatomic, assign) int __tag;
@property (nonatomic, assign) int __rateValue;

- (void) drawElements: (int) mojiID ratedMojis:(NSArray *)rated;

@end
