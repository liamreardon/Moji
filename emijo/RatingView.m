//
//  RatingView.m
//  emijo
//
//  Created by 60Degree on 12/23/13.
//  Copyright (c) 2013 60Degree. All rights reserved.
//

#define kLabelAllowance 00.0f
#define kStarViewHeight 14.0f
#define kStarViewWidth 76.0f
#define kLeftPadding 0.0f


#import "RatingView.h"

@implementation RatingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        __appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    return self;
}

- (void) drawElements: (int) mojiID ratedMojis:(NSArray *)rated
{
    
    if([rated valueForKey:[NSString stringWithFormat:@"%d", mojiID]]) {
        int __starWidth = kStarViewWidth+kLabelAllowance+kLeftPadding;
        
        StarRatingView *starviewR = [[StarRatingView alloc]initWithFrame:CGRectMake(0, 0, __starWidth, kStarViewHeight) andRating:[[rated valueForKey:[NSString stringWithFormat:@"%d", mojiID]] intValue] withLabel:NO animated:YES selectedColor:[UIColor colorWithRed:0.0/255.0 green:90.0/255.0 blue:115.0/255.0 alpha:1.0]];
        starviewR.tag = mojiID;
        [starviewR addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
        
        UIControl *mask = [[UIControl alloc] init];
        [mask addSubview:starviewR];
        
        [self addSubview:mask];
        
        UILabel *rateIt = [[UILabel alloc] initWithFrame:CGRectMake(starviewR.frame.origin.x + starviewR.frame.size.width + 5, 0, 80, 20)];
        rateIt.text = [NSString stringWithFormat:@"Your: %@%@", [rated valueForKey:[NSString stringWithFormat:@"%d", mojiID]], @"%"];
        rateIt.textColor = [UIColor grayColor];
        rateIt.font = [UIFont fontWithName:@"HelveticaNeue" size:13.0];
        [rateIt setBackgroundColor: [UIColor clearColor]];
        [self addSubview:rateIt];
        
    } else {
        
        int __starWidth = kStarViewWidth+kLabelAllowance+kLeftPadding;
        
        StarRatingView *starviewR = [[StarRatingView alloc]initWithFrame:CGRectMake(0, 0, __starWidth, kStarViewHeight) andRating:0 withLabel:NO animated:YES selectedColor:[UIColor colorWithRed:0.0/255.0 green:90.0/255.0 blue:115.0/255.0 alpha:1.0]];
        starviewR.tag = mojiID;
        [starviewR addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
        
        [self addSubview:starviewR];
        
        
        UIButton *rateIt = [[UIButton alloc] initWithFrame:CGRectMake(starviewR.frame.origin.x + starviewR.frame.size.width + 5, 0, 40, 16)];
        [rateIt setTitle:@"Rate" forState:UIControlStateNormal];
        [rateIt.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:11.0]];
        [rateIt setBackgroundColor: [UIColor redColor]];
        
        [rateIt addTarget:self action:@selector(rateIt:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:rateIt];
    }
    
    
}

- (void) valueChanged:(StarRatingView *)sender
{
    self.__rateValue = sender.ratingValue;
    self.__tag = sender.tag;
}

-(void) rateIt:(id) sender{
    int userId = 1;
    float ratingpercentage = self.__rateValue;
    int mojiId = self.__tag;
    if(ratingpercentage>0) {
        NSString *bodyData = [NSString stringWithFormat: @"a=rateItAction&mojiID=%d&userID=%d&ratingpercentage=%f", mojiId, userId, ratingpercentage];
        NSLog(@"%@",bodyData);
        NSMutableDictionary *res = [[__appDelegate makeRequest:bodyData] objectForKey:@"data"];
        NSLog(@"%@",res);
        [__appDelegate alert:@"Rated" withObject:@"Alert"];
    } else {
        [__appDelegate alert:@"Please rate first..... " withObject:@"Fail"];
    }
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
