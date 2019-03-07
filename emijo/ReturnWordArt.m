//
//  ReturnWordArt.m
//  TestingWordMaker
//
//  Created by karamvir singh on 06/01/14.
//  Copyright (c) 2014 karamvir singh. All rights reserved.
//

#import "ReturnWordArt.h"

@implementation ReturnWordArt

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (NSString *)returnEmoWord:(NSString *)__emoStr w:(NSString *)__word
{
    NSString *__str = @"\n";
    
    if ([__word isEqualToString:@"A"] || [__word isEqualToString:@"a"]) {
        //.. A
        
        __str = [NSString stringWithFormat:@"        %@%@%@%@\n   %@%@%@%@%@%@\n   %@%@         %@%@\n   %@%@         %@%@\n   %@%@%@%@%@%@\n   %@%@%@%@%@%@\n   %@%@         %@%@\n   %@%@         %@%@\n",__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr];
        
    }else if ([__word isEqualToString:@"B"] || [__word isEqualToString:@"b"]) {
        
        //.. B
        
        __str = [NSString stringWithFormat:@"   %@%@%@%@%@\n   %@%@%@%@%@%@\n   %@%@         %@%@\n   %@%@         %@\n   %@%@%@%@%@\n   %@%@         %@%@\n   %@%@         %@%@\n   %@%@%@%@%@%@\n   %@%@%@%@%@\n",__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr];
        
    }else if ([__word isEqualToString:@"C"] || [__word isEqualToString:@"c"]) {
        
        //.. C
        
        __str = [NSString stringWithFormat:@"⁯⁯        %@%@%@%@%@\n   %@%@%@%@%@%@\n   %@%@\n   %@%@\n   %@%@\n   %@%@\n   %@%@%@%@%@%@\n        %@%@%@%@%@\n",__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr];
        
    }else if ([__word isEqualToString:@"D"] || [__word isEqualToString:@"d"]) {
        
        //.. D
        
        __str = [NSString stringWithFormat:@"   %@%@%@%@\n   %@%@%@%@%@\n   %@%@         %@%@\n   %@%@         %@%@\n   %@%@         %@%@\n   %@%@         %@%@\n   %@%@%@%@%@\n   %@%@%@%@\n",__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr];
        
    }else if ([__word isEqualToString:@"E"] || [__word isEqualToString:@"e"]) {
        
        //.. E
        
        __str = [NSString stringWithFormat:@"⁯⁯   %@%@%@%@%@%@\n   %@%@%@%@%@%@\n   %@%@\n   %@%@%@%@%@\n   %@%@%@%@%@\n   %@%@\n   %@%@%@%@%@%@\n   %@%@%@%@%@%@\n",__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr];
        
    }else if ([__word isEqualToString:@"F"] || [__word isEqualToString:@"f"]) {
        
        //.. F
        
        __str = [NSString stringWithFormat:@"⁯⁯   %@%@%@%@%@%@\n⁯⁯   %@%@%@%@%@%@\n⁯⁯   %@%@\n⁯⁯   %@%@%@%@%@\n⁯⁯   %@%@%@%@%@\n⁯⁯   %@%@\n⁯⁯   %@%@\n⁯⁯   %@%@\n",__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr];
        
    }else if ([__word isEqualToString:@"G"] || [__word isEqualToString:@"g"]) {
        
        //.. G
        
        __str = [NSString stringWithFormat:@"      %@%@%@%@%@\n %@%@%@%@%@%@%@\n %@%@\n %@%@\n %@%@          %@%@%@\n %@%@               %@%@\n %@%@%@%@%@%@%@\n      %@%@%@%@%@\n",__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr];
        
    }else if ([__word isEqualToString:@"H"] || [__word isEqualToString:@"h"]) {
        
        //.. H
        
        __str = [NSString stringWithFormat:@"⁯⁯   %@%@         %@%@\n⁯⁯   %@%@         %@%@\n⁯⁯   %@%@         %@%@\n⁯⁯   %@%@%@%@%@%@\n⁯⁯   %@%@%@%@%@%@\n⁯⁯   %@%@         %@%@\n⁯⁯   %@%@         %@%@\n⁯⁯   %@%@         %@%@\n",__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr];
        
    }else if ([__word isEqualToString:@"I"] || [__word isEqualToString:@"i"]) {
        
        //.. I
        
        __str = [NSString stringWithFormat:@"⁯        %@%@%@%@\n⁯        %@%@%@%@\n             %@%@\n             %@%@\n             %@%@\n             %@%@\n        %@%@%@%@\n        %@%@%@%@\n",__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr];
        
    }else if ([__word isEqualToString:@"J"] || [__word isEqualToString:@"j"]) {
        
        //.. J
        
        __str = [NSString stringWithFormat:@"                 %@%@%@\n                 %@%@%@\n                      %@%@\n                      %@%@\n                      %@%@\n                      %@%@\n   %@%@          %@%@\n   %@%@%@%@%@%@\n        %@%@%@%@\n",__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr];
        
    }else if ([__word isEqualToString:@"K"] || [__word isEqualToString:@"k"]) {
        
        //.. K
        
        __str = [NSString stringWithFormat:@"%@%@         %@%@\n%@%@    %@%@\n%@%@%@%@\n%@%@%@\n%@%@%@%@\n%@%@    %@%@\n%@%@         %@%@\n%@%@              %@%@\n",__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr];
        
    }else if ([__word isEqualToString:@"L"] || [__word isEqualToString:@"l"]) {
        
        //.. L
        
        __str = [NSString stringWithFormat:@"⁯⁯⁯⁯   %@%@\n⁯⁯   %@%@\n⁯⁯   %@%@\n⁯⁯   %@%@\n⁯⁯   %@%@\n⁯⁯   %@%@\n⁯⁯   %@%@%@%@%@%@\n⁯⁯   %@%@%@%@%@%@\n",__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr];
        
    }else if ([__word isEqualToString:@"M"] || [__word isEqualToString:@"m"]) {
        
        //.. M
        
        __str = [NSString stringWithFormat:@"%@%@             %@%@\n%@%@%@    %@%@%@\n%@%@%@%@%@%@%@\n%@%@     %@    %@%@\n%@%@     %@    %@%@\n%@%@              %@%@\n%@%@              %@%@\n",__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr];
        
        
    }else if ([__word isEqualToString:@"N"] || [__word isEqualToString:@"n"]) {
        
        //.. N
        
        __str = [NSString stringWithFormat:@"   %@              %@%@\n   %@%@         %@%@\n   %@%@%@    %@%@\n   %@%@%@%@%@%@\n   %@%@     %@%@%@\n   %@%@         %@%@\n   %@%@              %@\n",__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr];
        
    }else if ([__word isEqualToString:@"O"] || [__word isEqualToString:@"o"]) {
        
        //.. O
        
        __str = [NSString stringWithFormat:@"        %@%@%@%@\n   %@%@%@%@%@%@\n   %@%@          %@%@\n   %@%@          %@%@\n   %@%@          %@%@\n   %@%@          %@%@\n   %@%@%@%@%@%@\n        %@%@%@%@\n",__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr];
        
        
    }else if ([__word isEqualToString:@"P"] || [__word isEqualToString:@"p"]) {
        
        //.. P
        
        __str = [NSString stringWithFormat:@"   %@%@%@%@%@\n   %@%@%@%@%@%@\n   %@%@          %@%@\n   %@%@          %@%@\n   %@%@%@%@%@%@\n   %@%@%@%@%@\n   %@%@\n   %@%@\n   %@%@\n",__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr];
        
        
    }else if ([__word isEqualToString:@"Q"] || [__word isEqualToString:@"q"]) {
        
        //.. Q
        
        __str = [NSString stringWithFormat:@"⁯⁯⁯⁯       %@%@%@%@\n   %@%@%@%@%@%@\n   %@%@         %@%@\n   %@%@         %@%@\n   %@%@    %@%@%@\n   %@%@         %@%@\n   %@%@%@%@%@%@\n       %@%@%@%@   %@\n",__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr];
        
    }else if ([__word isEqualToString:@"R"] || [__word isEqualToString:@"r"]) {
        
        //.. R
        
        __str = [NSString stringWithFormat:@"   %@%@%@%@\n   %@%@%@%@%@\n   %@%@     %@%@\n   %@%@     %@%@\n   %@%@%@%@\n   %@%@%@%@\n   %@%@     %@%@\n   %@%@          %@%@\n",__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr];
        
        
    }else if ([__word isEqualToString:@"S"] || [__word isEqualToString:@"s"]) {
        
        //.. S
        
        __str = [NSString stringWithFormat:@"⁯⁯        %@%@%@%@\n   %@%@%@%@%@%@\n   %@%@\n   %@%@%@%@%@\n⁯⁯        %@%@%@%@%@\n                       %@%@\n   %@%@%@%@%@%@\n   %@%@%@%@%@\n",__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr];
        
    }else if ([__word isEqualToString:@"T"] || [__word isEqualToString:@"t"]) {
        
        //.. T
        
        __str = [NSString stringWithFormat:@"   %@%@%@%@%@%@\n   %@%@%@%@%@%@\n             %@%@\n             %@%@\n             %@%@\n             %@%@\n             %@%@\n",__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr];
        
    }else if ([__word isEqualToString:@"U"] || [__word isEqualToString:@"u"]) {
        
        //.. U
        
        __str = [NSString stringWithFormat:@"⁯⁯   %@%@          %@%@\n   %@%@          %@%@\n   %@%@          %@%@\n   %@%@          %@%@\n   %@%@          %@%@\n   %@%@          %@%@\n   %@%@%@%@%@%@\n        %@%@%@%@\n",__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr];
        
    }else if ([__word isEqualToString:@"V"] || [__word isEqualToString:@"v"]) {
        
        //.. V
        
        __str = [NSString stringWithFormat:@"   %@%@          %@%@\n   %@%@          %@%@\n   %@%@          %@%@\n   %@%@          %@%@\n   %@%@          %@%@\n   %@%@%@%@%@%@\n        %@%@%@%@\n            %@%@\n",__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr];
        
        
    }else if ([__word isEqualToString:@"W"] || [__word isEqualToString:@"w"]) {
        
        //.. W
        
        __str = [NSString stringWithFormat:@"%@%@               %@%@\n%@%@               %@%@\n%@%@     %@     %@%@\n%@%@     %@     %@%@\n%@%@     %@     %@%@\n%@%@%@%@%@%@%@\n   %@%@     %@%@\n",__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr];
        
        
    }else if ([__word isEqualToString:@"X"] || [__word isEqualToString:@"x"]) {
        
        //.. X
        
        __str = [NSString stringWithFormat:@"   %@%@          %@%@\n   %@%@          %@%@\n        %@%@%@%@\n             %@%@\n             %@%@\n        %@%@%@%@\n   %@%@          %@%@\n   %@%@          %@%@\n",__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr];
        
        
    }else if ([__word isEqualToString:@"Y"] || [__word isEqualToString:@"y"]) {
        
        //.. Y
        
        __str = [NSString stringWithFormat:@"   %@%@          %@%@\n   %@%@          %@%@\n   %@%@          %@%@\n   %@%@%@%@%@%@\n        %@%@%@%@\n             %@%@\n             %@%@\n             %@%@\n",__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr];
        
    }else if ([__word isEqualToString:@"Z"] || [__word isEqualToString:@"z"]) {
        
        //.. Z
        
        __str = [NSString stringWithFormat:@"   %@%@%@%@%@\n   %@%@%@%@%@\n               %@%@\n            %@%@\n         %@%@\n      %@%@\n   %@%@%@%@%@\n   %@%@%@%@%@\n",__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr];
        
    }else if ([__word isEqualToString:@"0"]) {
        
        //.. 0
        
        __str = [NSString stringWithFormat:@"        %@%@%@%@\n   %@%@%@%@%@%@\n   %@%@          %@%@\n   %@%@          %@%@\n   %@%@          %@%@\n   %@%@          %@%@\n   %@%@          %@%@\n   %@%@%@%@%@%@\n        %@%@%@%@\n",__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr];
        
    }else if ([__word isEqualToString:@"1"]) {
        
        //.. 1
        
        __str = [NSString stringWithFormat:@"                  %@%@\n             %@%@%@\n        %@%@%@%@\n                 %@%@\n                 %@%@\n                 %@%@\n                 %@%@\n                 %@%@\n",__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr];
        
    }else if ([__word isEqualToString:@"2"]) {
        
        //.. 2
        
        __str = [NSString stringWithFormat:@"⁯⁯             %@%@%@\n        %@%@%@%@%@\n   %@%@          %@%@\n                      %@%@\n                  %@%@\n             %@%@\n        %@%@\n   %@%@%@%@%@%@\n   %@%@%@%@%@%@\n",__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr];
        
    }else if ([__word isEqualToString:@"3"]) {
        
        //.. 3
        
        __str = [NSString stringWithFormat:@"   %@%@%@%@%@\n   %@%@%@%@%@%@\n                       %@%@\n                       %@%@\n             %@%@%@\n             %@%@%@\n                       %@%@\n                       %@%@\n   %@%@%@%@%@%@\n   %@%@%@%@%@\n",__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr];
        
    }else if ([__word isEqualToString:@"4"]) {
        
        //.. 4
        
        __str = [NSString stringWithFormat:@"⁯⁯   %@%@     %@%@\n   %@%@     %@%@\n   %@%@     %@%@\n⁯⁯   %@%@     %@%@\n⁯⁯   %@%@%@%@%@%@\n⁯⁯   %@%@%@%@%@%@\n⁯⁯                  %@%@\n⁯⁯⁯⁯⁯⁯                  %@%@\n",__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr];
        
    }else if ([__word isEqualToString:@"5"]) {
        
        //.. 5
        
        __str = [NSString stringWithFormat:@"         %@%@%@%@%@\n       %@%@%@%@%@\n     %@%@\n   %@%@%@%@%@\n⁯⁯        %@%@%@%@%@\n                       %@%@\n   %@%@%@%@%@%@\n   %@%@%@%@%@\n",__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr];
        
    }else if ([__word isEqualToString:@"6"]) {
        
        //.. 6
        
        __str = [NSString stringWithFormat:@"        %@%@%@%@\n   %@%@%@%@%@%@\n   %@%@          %@%@\n   %@%@          \n   %@%@%@%@%@\n   %@%@          %@%@\n   %@%@          %@%@\n   %@%@%@%@%@%@\n        %@%@%@%@\n",__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr];
        
    }else if ([__word isEqualToString:@"7"]) {
        
        //.. 7
        
//        __str = [NSString stringWithFormat:@"   %@%@%@%@%@\n   %@%@%@%@%@\n               %@%@\n             %@%@\n           %@%@\n         %@%@\n       %@%@\n     %@%@\n",__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr];
        
        __str = [NSString stringWithFormat:@"   %@%@%@%@%@\n   %@%@%@%@%@\n               %@%@\n             %@%@\n           %@%@\n         %@%@\n       %@%@\n     %@%@\n    %@%@\n",__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr];
        
    }else if ([__word isEqualToString:@"8"]) {
        
        //.. 8
        
        __str = [NSString stringWithFormat:@"        %@%@%@%@\n   %@%@%@%@%@%@\n   %@%@          %@%@\n   %@%@          %@%@\n        %@%@%@%@\n   %@%@          %@%@\n   %@%@          %@%@\n   %@%@%@%@%@%@\n        %@%@%@%@\n",__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr];
        
    }else if ([__word isEqualToString:@"9"]) {
        
        //.. 9
        
        __str = [NSString stringWithFormat:@"        %@%@%@%@\n   %@%@%@%@%@%@\n   %@%@          %@%@\n   %@%@          %@%@\n        %@%@%@%@%@\n                      %@%@\n   %@%@          %@%@\n   %@%@%@%@%@%@\n        %@%@%@%@\n",__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr,__emoStr];
        
    }
    
    return __str;
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
