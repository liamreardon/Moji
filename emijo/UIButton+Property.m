#import "UIButton+Property.h"
#import <objc/runtime.h>

@implementation UIButton(Property)

static char UIB_PROPERTY_KEY;

@dynamic property;

-(void)setProperty:(NSMutableDictionary *)property
{
    objc_setAssociatedObject(self, &UIB_PROPERTY_KEY, property, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSMutableDictionary*)property
{
    return (NSMutableDictionary*)objc_getAssociatedObject(self, &UIB_PROPERTY_KEY);
}

@end