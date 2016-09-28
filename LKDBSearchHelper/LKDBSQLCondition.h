 

#import <Foundation/Foundation.h>
@class LKDBQueryBuilder;


extern NSString* _Nonnull const LKDB_OPERATION_Equal;
extern NSString* _Nonnull const LKDB_OPERATION_NotEqual;
extern NSString* _Nonnull const LKDB_OPERATION_IsNot;
extern NSString* _Nonnull const LKDB_OPERATION_LIKE;
extern NSString* _Nonnull const LKDB_OPERATION_IN;


extern NSString* _Nonnull const LKDB_OPERATION_LessThan;
extern NSString* _Nonnull const LKDB_OPERATION_GreaterThan;

extern NSString* _Nonnull const LKDB_OPERATION_LessAndEqualThan;
extern NSString* _Nonnull const LKDB_OPERATION_GreaterAndEqualThan;



@interface LKDBSQLCondition : NSObject

+(LKDBSQLCondition *_Nonnull)condition:(NSString *_Nonnull)name operation:(NSString *_Nonnull)operation value:(NSString *_Nonnull)value;

+(LKDBSQLCondition *_Nonnull)condition:(NSString *_Nonnull)name inString:(NSArray *_Nonnull)value;
+(LKDBSQLCondition *_Nonnull)condition:(NSString *_Nonnull)name inInt:(NSArray *_Nonnull)value;

+(LKDBSQLCondition *_Nonnull)condition:(NSString *_Nonnull)name operation:(NSString *_Nonnull)operation valueString:(NSString *_Nonnull)value;
+(LKDBSQLCondition *_Nonnull)condition:(NSString *_Nonnull)name operation:(NSString *_Nonnull)operation valueInt:(int64_t)value;
+(LKDBSQLCondition *_Nonnull)condition:(NSString *_Nonnull)name operation:(NSString *_Nonnull)operation valueFloat:(float)value;



-(void)appendConditionToQuery:(LKDBQueryBuilder *_Nonnull)queryBuilder;
-(LKDBSQLCondition *_Nonnull)separator:(NSString *_Nonnull)separator;
-(BOOL)hasSeparator;
-(NSString *_Nonnull)separator;


@end




//基本条件语句

//条件等于
extern LKDBSQLCondition* _Nonnull LKDB_Equal_String(NSString * _Nonnull name,NSString *_Nonnull value);
extern LKDBSQLCondition* _Nonnull LKDB_Equal_Int(NSString *_Nonnull name,int64_t value);
extern LKDBSQLCondition* _Nonnull LKDB_Equal_Float(NSString *_Nonnull name,float value);



//条件不等于

extern LKDBSQLCondition* _Nonnull LKDB_NotEqual_String(NSString * _Nonnull name,NSString *_Nonnull value);
extern LKDBSQLCondition*_Nonnull  LKDB_NotEqual_Int(NSString * _Nonnull name,int64_t value);
extern LKDBSQLCondition* _Nonnull LKDB_NotEqual_Float(NSString * _Nonnull name,float value);




//字符串不等于
extern LKDBSQLCondition* _Nonnull LKDB_IsNot_String(NSString * _Nonnull name,NSString * _Nonnull value);
//字符串LIKE
extern LKDBSQLCondition* _Nonnull LKDB_LIKE_String(NSString * _Nonnull name,NSString * _Nonnull value);

//条件小于
extern LKDBSQLCondition* _Nonnull LKDB_LessThan_String(NSString * _Nonnull name,NSString * _Nonnull value);
extern LKDBSQLCondition* _Nonnull LKDB_LessThan_Int(NSString * _Nonnull name,int64_t value);
extern LKDBSQLCondition* _Nonnull LKDB_LessThan_Float(NSString * _Nonnull name,float value);

//条件大于
extern LKDBSQLCondition* _Nonnull  LKDB_GreaterThan_String(NSString * _Nonnull name,NSString * _Nonnull value);
extern LKDBSQLCondition* _Nonnull  LKDB_GreaterThan_Int(NSString * _Nonnull name,int64_t value);
extern LKDBSQLCondition* _Nonnull  LKDB_GreaterThan_Float(NSString * _Nonnull name,float value);

//条件小于等于
extern LKDBSQLCondition* _Nonnull  LKDB_LessAndEqualThan_String(NSString * _Nonnull name,NSString * _Nonnull value);
extern LKDBSQLCondition* _Nonnull  LKDB_LessAndEqualThan_Int(NSString * _Nonnull name,int64_t value);
extern LKDBSQLCondition* _Nonnull  LKDB_LessAndEqualThan_Float(NSString * _Nonnull name,float value);

//条件大于等于
extern LKDBSQLCondition* _Nonnull  LKDB_GreaterAndEqualThan_String(NSString * _Nonnull name,NSString * _Nonnull value);
extern LKDBSQLCondition* _Nonnull  LKDB_GreaterAndEqualThan_Int(NSString * _Nonnull name,int64_t value);
extern LKDBSQLCondition* _Nonnull  LKDB_GreaterAndEqualThan_Float(NSString * _Nonnull name,float value);

//IN条件
extern LKDBSQLCondition* _Nonnull  LKDB_IN_String(NSString * _Nonnull name,NSArray<NSString *> * _Nonnull value);
extern LKDBSQLCondition* _Nonnull  LKDB_IN_Int(NSString * _Nonnull name,NSArray<NSString *> * _Nonnull value);

//基本条件
extern LKDBSQLCondition* _Nonnull  LKDB_Condition(NSString * _Nonnull name,NSString * _Nonnull operation,NSString * _Nonnull value);
