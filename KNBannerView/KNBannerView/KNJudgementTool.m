//
//  KNJudgementTool.m
//  
//
//  Created by LUKHA_Lu on 15/7/16.
//  Copyright (c) 2015年 KNKane. All rights reserved.
//

#import "KNJudgementTool.h"

@implementation KNJudgementTool

+ (BOOL)isEmptyString:(NSString *)string{
    if(string == nil || string == NULL || [string isKindOfClass:[NSNull class]] || [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0){
        return YES;
    }
    return NO;
}

+ (BOOL)isEmptyArray:(NSArray *)array{
    if(array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0){
        return YES;
    }
    return NO;
}

@end
