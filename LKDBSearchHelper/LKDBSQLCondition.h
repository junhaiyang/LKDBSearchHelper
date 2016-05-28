//
//  LKDBSQLCondition.h
//  wkt_app_ios
//
//  Created by junhai on 16/5/28.
//  Copyright © 2016年 junhai. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LKDBQueryBuilder;

#define LKDB_OPERATION_Equal @"="
#define LKDB_OPERATION_NotEqual @"<>"
#define LKDB_OPERATION_IsNot @"IS NOT"
#define LKDB_OPERATION_LIKE @"LIKE"

#define LKDB_OPERATION_LessThan @"<"
#define LKDB_OPERATION_GreaterThan @">"

#define LKDB_OPERATION_LessAndEqualThan @"<="
#define LKDB_OPERATION_GreaterAndEqualThan @">="

//基本条件语句

//条件等于
#define LKDB_EqualString(name,value)                           [LKDBSQLCondition condition:name operation:LKDB_OPERATION_Equal valueString:value]
#define LKDB_EqualInt(name,value)                              [LKDBSQLCondition condition:name operation:LKDB_OPERATION_Equal valueInt:value]
#define LKDB_EqualFloat(name,value)                            [LKDBSQLCondition condition:name operation:LKDB_OPERATION_Equal valueFloat:value]
#define LKDB_EqualDouble(name,value)                           [LKDBSQLCondition condition:name operation:LKDB_OPERATION_Equal valueDouble:value]
#define LKDB_EqualLong(name,value)                             [LKDBSQLCondition condition:name operation:LKDB_OPERATION_Equal valueLong:value]
#define LKDB_EqualLongLong(name,value)                         [LKDBSQLCondition condition:name operation:LKDB_OPERATION_Equal valueLongLong:value]



//条件不等于
#define LKDB_NotEqualString(name,value)                        [LKDBSQLCondition condition:name operation:LKDB_OPERATION_NotEqual valueString:value]
#define LKDB_NotEqualInt(name,value)                           [LKDBSQLCondition condition:name operation:LKDB_OPERATION_NotEqual valueInt:value]
#define LKDB_NotEqualFloat(name,value)                         [LKDBSQLCondition condition:name operation:LKDB_OPERATION_NotEqual valueFloat:value]
#define LKDB_NotEqualDouble(name,value)                        [LKDBSQLCondition condition:name operation:LKDB_OPERATION_NotEqual valueDouble:value]
#define LKDB_NotEqualLong(name,value)                          [LKDBSQLCondition condition:name operation:LKDB_OPERATION_NotEqual valueLong:value]
#define LKDB_NotEqualLongLong(name,value)                      [LKDBSQLCondition condition:name operation:LKDB_OPERATION_NotEqual valueLongLong:value]



//字符串不等于
#define LKDB_IsNotString(name,value)                           [LKDBSQLCondition condition:name operation:LKDB_OPERATION_IsNot valueString:value]
//字符串LIKE
#define LKDB_LIKEString(name,value)                            [LKDBSQLCondition condition:name operation:LKDB_OPERATION_LIKE valueString:value]

//条件小于
#define LKDB_LessThanString(name,value)                        [LKDBSQLCondition condition:name operation:LKDB_OPERATION_LessThan valueString:value]
#define LKDB_LessThanInt(name,value)                           [LKDBSQLCondition condition:name operation:LKDB_OPERATION_LessThan valueInt:value]
#define LKDB_LessThanFloat(name,value)                         [LKDBSQLCondition condition:name operation:LKDB_OPERATION_LessThan valueFloat:value]
#define LKDB_LessThanDouble(name,value)                        [LKDBSQLCondition condition:name operation:LKDB_OPERATION_LessThan valueDouble:value]
#define LKDB_LessThanLong(name,value)                          [LKDBSQLCondition condition:name operation:LKDB_OPERATION_LessThan valueLong:value]
#define LKDB_LessThanLongLong(name,value)                      [LKDBSQLCondition condition:name operation:LKDB_OPERATION_LessThan valueLongLong:value]

//条件大于
#define LKDB_GreaterThanString(name,value)                     [LKDBSQLCondition condition:name operation:LKDB_OPERATION_GreaterThan valueString:value]
#define LKDB_GreaterThanInt(name,value)                        [LKDBSQLCondition condition:name operation:LKDB_OPERATION_GreaterThan valueInt:value]
#define LKDB_GreaterThanFloat(name,value)                      [LKDBSQLCondition condition:name operation:LKDB_OPERATION_GreaterThan valueFloat:value]
#define LKDB_GreaterThanDouble(name,value)                     [LKDBSQLCondition condition:name operation:LKDB_OPERATION_GreaterThan valueDouble:value]
#define LKDB_GreaterThanLong(name,value)                       [LKDBSQLCondition condition:name operation:LKDB_OPERATION_GreaterThan valueLong:value]
#define LKDB_GreaterThanLongLong(name,value)                   [LKDBSQLCondition condition:name operation:LKDB_OPERATION_GreaterThan valueLongLong:value]

//条件小于等于
#define LKDB_LessAndEqualThanString(name,value)                [LKDBSQLCondition condition:name operation:LKDB_OPERATION_LessAndEqualThan valueString:value]
#define LKDB_LessAndEqualThanInt(name,value)                   [LKDBSQLCondition condition:name operation:LKDB_OPERATION_LessAndEqualThan valueInt:value]
#define LKDB_LessAndEqualThanFloat(name,value)                 [LKDBSQLCondition condition:name operation:LKDB_OPERATION_LessAndEqualThan valueFloat:value]
#define LKDB_LessAndEqualThanDouble(name,value)                [LKDBSQLCondition condition:name operation:LKDB_OPERATION_LessAndEqualThan valueDouble:value]
#define LKDB_LessAndEqualThanLong(name,value)                  [LKDBSQLCondition condition:name operation:LKDB_OPERATION_LessAndEqualThan valueLong:value]
#define LKDB_LessAndEqualThanLongLong(name,value)              [LKDBSQLCondition condition:name operation:LKDB_OPERATION_LessAndEqualThan valueLongLong:value]

//条件大于等于
#define LKDB_GreaterAndEqualThanString(name,value)             [LKDBSQLCondition condition:name operation:LKDB_OPERATION_GreaterAndEqualThan valueString:value]
#define LKDB_GreaterAndEqualThanInt(name,value)                [LKDBSQLCondition condition:name operation:LKDB_OPERATION_GreaterAndEqualThan valueInt:value]
#define LKDB_GreaterAndEqualThanFloat(name,value)              [LKDBSQLCondition condition:name operation:LKDB_OPERATION_GreaterAndEqualThan valueFloat:value]
#define LKDB_GreaterAndEqualThanDouble(name,value)             [LKDBSQLCondition condition:name operation:LKDB_OPERATION_GreaterAndEqualThan valueDouble:value]
#define LKDB_GreaterAndEqualThanLong(name,value)               [LKDBSQLCondition condition:name operation:LKDB_OPERATION_GreaterAndEqualThan valueLong:value]
#define LKDB_GreaterAndEqualThanLongLong(name,value)           [LKDBSQLCondition condition:name operation:LKDB_OPERATION_GreaterAndEqualThan valueLongLong:value]


//基本条件
#define LKDB_Condition(name,operation,value)    [LKDBSQLCondition condition:name operation:operation value:value]

//IN条件 待完善
#define LKDB_IN(name,values)
 

@interface LKDBSQLCondition : NSObject

+(LKDBSQLCondition *)condition:(NSString *)name operation:(NSString *)operation value:(NSString *)value;

+(LKDBSQLCondition *)condition:(NSString *)name operation:(NSString *)operation valueString:(NSString *)value;
+(LKDBSQLCondition *)condition:(NSString *)name operation:(NSString *)operation valueInt:(int)value;
+(LKDBSQLCondition *)condition:(NSString *)name operation:(NSString *)operation valueFloat:(float)value;
+(LKDBSQLCondition *)condition:(NSString *)name operation:(NSString *)operation valueDouble:(double)value;
+(LKDBSQLCondition *)condition:(NSString *)name operation:(NSString *)operation valueLong:(long)value;
+(LKDBSQLCondition *)condition:(NSString *)name operation:(NSString *)operation valueLongLong:(long long)value;



-(void)appendConditionToQuery:(LKDBQueryBuilder *)queryBuilder;
-(LKDBSQLCondition *)separator:(NSString *)separator;
-(BOOL)hasSeparator;
-(NSString *)separator;


@end
