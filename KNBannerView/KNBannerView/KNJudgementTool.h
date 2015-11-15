//
//  KNJudgementTool.h
//  
//
//  Created by LUKHA_Lu on 15/7/16.
//  Copyright (c) 2015年 KNKane. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface KNJudgementTool : NSObject


/**
 *  JudgeString is not Empty
 *
 *  @param string
 *
 *  @return bool type,YES:yes  NO:not
 */
+ (BOOL)isEmptyString:(NSString *)string;


/**
 *  JudgeArray is not Empty
 *
 *  @param array
 *
 *  @return bool type,YES:yes  NO:not
 */
+ (BOOL)isEmptyArray:(NSArray *)array;


@end
