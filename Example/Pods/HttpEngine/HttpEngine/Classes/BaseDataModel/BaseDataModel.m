//
//  BaseModel.m
//  DrinkLink
//
//  Created by MaTeen on 14/12/13.
//  Copyright (c) 2014年 MaTeen. All rights reserved.
//

#import "BaseDataModel.h" 
#import <objc/runtime.h>

@interface BaseDataModel () <NSCoding,NSCopying>

@end

@implementation BaseDataModel

#pragma mark copy Protocol
- (id)copyWithZone:(nullable NSZone *)zone;
{
    return [self modelCopy];
}

#pragma mark encode Protocol
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [self modelEncodeWithCoder:aCoder];
}

#pragma mark decode Protocol
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    return [self modelInitWithCoder:aDecoder];
}

#pragma mark appendFunction(Setter、Getter)
- (SEL)appendSetterSelWithAttributeName:(NSString *)attributeName
{
    NSString *capital = [[attributeName substringToIndex:1] uppercaseString];
    NSString *setterSelStr = [NSString stringWithFormat:@"set%@%@:",capital,[attributeName substringFromIndex:1]];
    return NSSelectorFromString(setterSelStr);
}

- (SEL)appendGetterSelectorWithAttributedName:(NSString *)attributedName
{
    if (attributedName && attributedName.length > 0)
    {
        return NSSelectorFromString(attributedName);
    }
    return NSSelectorFromString(@"");
}

- (void)displayAllAttributed
{
    NSMutableString *allAttributed = [[NSMutableString alloc]init];
    unsigned int count = 0;
    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    if (count > 0)
    {
        for (int i = 0 ; i < count; i++)
        {
            objc_property_t property = propertyList[i];
            const char *tmpName = property_getName(property);
            NSString *attributedName = [NSString stringWithUTF8String:tmpName];
            if (i == 0)
            {
                [allAttributed appendFormat:@"start print attributed：-------------------------------------\n"];
            }
            if (attributedName)
            {
                SEL attributedGetterSelector = [self appendGetterSelectorWithAttributedName:attributedName];
                if ([self respondsToSelector:attributedGetterSelector])
                {
                    NSMethodSignature *signature = [self methodSignatureForSelector:attributedGetterSelector];
                    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
                    invocation.target = self;
                    invocation.selector = attributedGetterSelector;
                    [invocation invoke];
                    
                    NSUInteger length = [signature methodReturnLength];
                    void *buffer = (void *)malloc(length);
                    [invocation getReturnValue:buffer];
                    
                    [allAttributed appendFormat:@"%@ = %@\n",attributedName,[self convertObjectWithSignature:signature object:buffer]];
                    free(buffer);
                }
            }
            if (i == count-1)
            {
                [allAttributed appendString:@"print attributed over-------------------------------------"];
            }
        }
    }
    free(propertyList);
    NSLog(@"%@",allAttributed);
}

//check attributed included to Assign
- (BOOL)isAssignAttributed:(NSObject *)type
{
    BOOL isAssign = YES;
    if (type)
    {
        if ([type isKindOfClass:[NSString class]])
        {
            isAssign = NO;
        }
    }
    return isAssign;
}

//convertObjectMethod
- (id)convertObjectWithSignature:(NSMethodSignature *)sig object:(void *)object
{
    if (strcmp(sig.methodReturnType, @encode(NSInteger)) == 0)
    {
        NSInteger value = *(NSInteger*)object;
        return [NSNumber numberWithInteger:value];
    }
    else if (strcmp(sig.methodReturnType, @encode(int)) == 0)
    {
        int value = *(int *)object;
        return [NSNumber numberWithInt:value];
    }
    else if (strcmp(sig.methodReturnType, @encode(float)) == 0)
    {
        float value = *(float *)object;
        return [NSNumber numberWithFloat:value];
    }
    else if (strcmp(sig.methodReturnType, @encode(double)) == 0)
    {
        double value= *(double *)object;
        return [NSNumber numberWithDouble:value];
    }
    else if (strcmp(sig.methodReturnType, @encode(BOOL)) == 0)
    {
        BOOL value = *(BOOL *)object;
        return [NSNumber numberWithBool:value];
    }
    else
    {
        id value = *((__unsafe_unretained NSString **)(object));
        return [NSString stringWithFormat:@"%@",value];
    }
    return @"";
}

//check attiributedType
- (Class)attributedClassTypeWithConstType:(const char *)type
{
    NSString *attributedType = [NSString stringWithCString:type encoding:NSUTF8StringEncoding];
    NSArray * attributedArray = [attributedType componentsSeparatedByString:@","];
    NSString *attibutedTypeString = attributedArray.count > 0 ? attributedArray[0]: @"";
    if ([attibutedTypeString hasPrefix:@"T@"] && [attibutedTypeString length] > 1)
    {
        if(attibutedTypeString.length > 3)
        {
            NSString * typeClassName = [attibutedTypeString substringWithRange:NSMakeRange(3, [attibutedTypeString length]-4)];
            return NSClassFromString(typeClassName);
        }
        else
        {
            return [NSString class];
        }
    }
    return nil;
}

- (void)dealloc
{
    
}

@end
