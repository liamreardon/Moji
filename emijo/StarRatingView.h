//
//  StarRatingView.h
//  StarRatingDemo
//
//  Created by HengHong on 5/4/13.
//  Copyright (c) 2013 Fixel Labs Pte. Ltd. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface StarRatingView : UIControl

- (id)initWithFrame:(CGRect)frame andRating:(int)rating withLabel:(BOOL)label animated:(BOOL)animated selectedColor:(UIColor*)color;

@property(nonatomic, retain) UIColor *selectedColor;

@property (nonatomic) int ratingValue;
@end