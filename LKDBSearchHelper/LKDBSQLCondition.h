 

#import <Foundation/Foundation.h>
@class LKDBQueryBuilder;


extern NSString* const LKDB_OPERATION_Equal;
extern NSString* const LKDB_OPERATION_NotEqual;
extern NSString* const LKDB_OPERATION_IsNot;
extern NSString* const LKDB_OPERATION_LIKE;
extern NSString* const LKDB_OPERATION_IN;


extern NSString* const LKDB_OPERATION_LessThan;
extern NSString* const LKDB_OPERATION_GreaterThan;

extern NSString* const LKDB_OPERATION_LessAndEqualThan;
extern NSString* const LKDB_OPERATION_GreaterAndEqualThan;



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




//基本条件语句

//条件等于
extern LKDBSQLCondition* LKDB_Equal_String(NSString *name,NSString *value);
extern LKDBSQLCondition* LKDB_Equal_Int(NSString *name,int64_t value);
extern LKDBSQLCondition* LKDB_Equal_Float(NSString *name,float value);



//条件不等于

extern LKDBSQLCondition* LKDB_NotEqual_String(NSString *name,NSString *value);
extern LKDBSQLCondition* LKDB_NotEqual_Int(NSString *name,int64_t value);
extern LKDBSQLCondition* LKDB_NotEqual_Float(NSString *name,float value);




//字符串不等于
extern LKDBSQLCondition* LKDB_IsNot_String(NSString *name,NSString *value);
//字符串LIKE
extern LKDBSQLCondition* LKDB_LIKE_String(NSString *name,NSString *value);

//条件小于
extern LKDBSQLCondition* LKDB_LessThan_String(NSString *name,NSString *value);
extern LKDBSQLCondition* LKDB_LessThan_Int(NSString *name,int64_t value);
extern LKDBSQLCondition* LKDB_LessThan_Float(NSString *name,float value);

//条件大于
extern LKDBSQLCondition* LKDB_GreaterThan_String(NSString *name,NSString *value);
extern LKDBSQLCondition* LKDB_GreaterThan_Int(NSString *name,int64_t value);
extern LKDBSQLCondition* LKDB_GreaterThan_Float(NSString *name,float value);

//条件小于等于
extern LKDBSQLCondition* LKDB_LessAndEqualThan_String(NSString *name,NSString *value);
extern LKDBSQLCondition* LKDB_LessAndEqualThan_Int(NSString *name,int64_t value);
extern LKDBSQLCondition* LKDB_LessAndEqualThan_Float(NSString *name,float value);

//条件大于等于
extern LKDBSQLCondition* LKDB_GreaterAndEqualThan_String(NSString *name,NSString *value);
extern LKDBSQLCondition* LKDB_GreaterAndEqualThan_Int(NSString *name,int64_t value);
extern LKDBSQLCondition* LKDB_GreaterAndEqualThan_Float(NSString *name,float value); 

//IN条件
extern LKDBSQLCondition* LKDB_IN_String(NSString *name,NSArray<NSString *> *value);
extern LKDBSQLCondition* LKDB_IN_Int(NSString *name,NSArray<NSString *> *value);

//基本条件
extern LKDBSQLCondition* LKDB_Condition(NSString *name,NSString *operation,NSString *value); 
