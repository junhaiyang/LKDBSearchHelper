

#import <Foundation/Foundation.h>
#import "LKDBStringBuilder.h"

extern NSString* const LKDB_OP_Eq;
extern NSString* const LKDB_OP_Neq;
extern NSString* const LKDB_OP_Lt;
extern NSString* const LKDB_OP_Gt;
extern NSString* const LKDB_OP_Lte;
extern NSString* const LKDB_OP_Gte;
extern NSString* const LKDB_OP_IsNot;
extern NSString* const LKDB_OP_LIKE;
extern NSString* const LKDB_OP_IN;

extern NSString* const LKDB_OP_AND;
extern NSString* const LKDB_OP_OR;


/* Single Condition Builder */

@interface LKSQLCondition : NSObject
@property (nonatomic, copy) NSString * connector;

+ (LKSQLCondition *)condition:(NSString *)name operation:(NSString *)operation value:(NSString *)value;

+ (LKSQLCondition *)condition:(NSString *)name inStrValues:(NSArray <NSString *> *)value; // e.g. ('1', '2' ,'3')
+ (LKSQLCondition *)condition:(NSString *)name inNumValues:(NSArray <NSNumber *> *)value; // e.g. (1, 2, 3)

- (BOOL)hasConnector;

- (NSString *)toString;

@end
