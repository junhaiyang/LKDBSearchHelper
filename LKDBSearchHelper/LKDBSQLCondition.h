 

#import <Foundation/Foundation.h>
@class LKDBQueryBuilder;

#define LKDB_OPERATION_Equal @"="
#define LKDB_OPERATION_NotEqual @"<>"
#define LKDB_OPERATION_IsNot @"IS NOT"
#define LKDB_OPERATION_LIKE @"LIKE"
#define LKDB_OPERATION_IN @"IN"

#define LKDB_OPERATION_LessThan @"<"
#define LKDB_OPERATION_GreaterThan @">"

#define LKDB_OPERATION_LessAndEqualThan @"<="
#define LKDB_OPERATION_GreaterAndEqualThan @">="

//基本条件语句

//条件等于
#define LKDB_Equal_String(name,value)                           [LKDBSQLCondition condition:name operation:LKDB_OPERATION_Equal valueString:value]
#define LKDB_Equal_Int(name,value)                              [LKDBSQLCondition condition:name operation:LKDB_OPERATION_Equal valueInt:value]
#define LKDB_Equal_Float(name,value)                            [LKDBSQLCondition condition:name operation:LKDB_OPERATION_Equal valueFloat:value]



//条件不等于
#define LKDB_NotEqual_String(name,value)                        [LKDBSQLCondition condition:name operation:LKDB_OPERATION_NotEqual valueString:value]
#define LKDB_NotEqual_Int(name,value)                           [LKDBSQLCondition condition:name operation:LKDB_OPERATION_NotEqual valueInt:value]
#define LKDB_NotEqual_Float(name,value)                         [LKDBSQLCondition condition:name operation:LKDB_OPERATION_NotEqual valueFloat:value]



//字符串不等于
#define LKDB_IsNot_String(name,value)                           [LKDBSQLCondition condition:name operation:LKDB_OPERATION_IsNot valueString:value]
//字符串LIKE
#define LKDB_LIKE_String(name,value)                            [LKDBSQLCondition condition:name operation:LKDB_OPERATION_LIKE valueString:value]

//条件小于
#define LKDB_LessThan_String(name,value)                        [LKDBSQLCondition condition:name operation:LKDB_OPERATION_LessThan valueString:value]
#define LKDB_LessThan_Int(name,value)                           [LKDBSQLCondition condition:name operation:LKDB_OPERATION_LessThan valueInt:value]
#define LKDB_LessThan_Float(name,value)                         [LKDBSQLCondition condition:name operation:LKDB_OPERATION_LessThan valueFloat:value]

//条件大于
#define LKDB_GreaterThan_String(name,value)                     [LKDBSQLCondition condition:name operation:LKDB_OPERATION_GreaterThan valueString:value]
#define LKDB_GreaterThan_Int(name,value)                        [LKDBSQLCondition condition:name operation:LKDB_OPERATION_GreaterThan valueInt:value]
#define LKDB_GreaterThan_Float(name,value)                      [LKDBSQLCondition condition:name operation:LKDB_OPERATION_GreaterThan valueFloat:value]

//条件小于等于
#define LKDB_LessAndEqualThan_String(name,value)                [LKDBSQLCondition condition:name operation:LKDB_OPERATION_LessAndEqualThan valueString:value]
#define LKDB_LessAndEqualThan_Int(name,value)                   [LKDBSQLCondition condition:name operation:LKDB_OPERATION_LessAndEqualThan valueInt:value]
#define LKDB_LessAndEqualThan_Float(name,value)                 [LKDBSQLCondition condition:name operation:LKDB_OPERATION_LessAndEqualThan valueFloat:value]

//条件大于等于
#define LKDB_GreaterAndEqualThan_String(name,value)             [LKDBSQLCondition condition:name operation:LKDB_OPERATION_GreaterAndEqualThan valueString:value]
#define LKDB_GreaterAndEqualThan_Int(name,value)                [LKDBSQLCondition condition:name operation:LKDB_OPERATION_GreaterAndEqualThan valueInt:value]
#define LKDB_GreaterAndEqualThan_Float(name,value)              [LKDBSQLCondition condition:name operation:LKDB_OPERATION_GreaterAndEqualThan valueFloat:value]

//IN条件
#define LKDB_IN_String(name,values)                             [LKDBSQLCondition condition:name  inString:value]
#define LKDB_IN_Int(name,values)                                [LKDBSQLCondition condition:name  inInt:value]
 
//基本条件
#define LKDB_Condition(name,operation,value)                    [LKDBSQLCondition condition:name operation:operation value:value]


@interface LKDBSQLCondition : NSObject

+(LKDBSQLCondition *)condition:(NSString *)name operation:(NSString *)operation value:(NSString *)value;

+(LKDBSQLCondition *)condition:(NSString *)name inString:(NSArray *)value;
+(LKDBSQLCondition *)condition:(NSString *)name inInt:(NSArray *)value;

+(LKDBSQLCondition *)condition:(NSString *)name operation:(NSString *)operation valueString:(NSString *)value;
+(LKDBSQLCondition *)condition:(NSString *)name operation:(NSString *)operation valueInt:(int64_t)value;
+(LKDBSQLCondition *)condition:(NSString *)name operation:(NSString *)operation valueFloat:(float)value;



-(void)appendConditionToQuery:(LKDBQueryBuilder *)queryBuilder;
-(LKDBSQLCondition *)separator:(NSString *)separator;
-(BOOL)hasSeparator;
-(NSString *)separator;


@end
