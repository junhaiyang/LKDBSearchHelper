

#import <Foundation/Foundation.h>
#import "LKSQLCondition.h"

/* Multi Condition Builder */

#define _SQLWhere LKSQLCompositeCondition.clause

@interface LKSQLCompositeCondition : LKSQLCondition

+ (instancetype)clause;

// SQL criteria
- (LKSQLCompositeCondition *)where;
- (LKSQLCompositeCondition *)or;
- (LKSQLCompositeCondition *)and;

- (LKSQLCompositeCondition *(^)(LKSQLCondition *))expr;
- (LKSQLCompositeCondition *(^)(NSArray<LKSQLCondition *> *))matchAll;
- (LKSQLCompositeCondition *(^)(NSArray<LKSQLCondition *> *))matchAny;

- (LKSQLCompositeCondition *(^)(NSString *, id))eq;
- (LKSQLCompositeCondition *(^)(NSString *, id))neq;
- (LKSQLCompositeCondition *(^)(NSString *, id))lt;
- (LKSQLCompositeCondition *(^)(NSString *, id))lte;
- (LKSQLCompositeCondition *(^)(NSString *, id))gt;
- (LKSQLCompositeCondition *(^)(NSString *, id))gte;
- (LKSQLCompositeCondition *(^)(NSString *, id))like;
- (LKSQLCompositeCondition *(^)(NSString *, id))isNot;
- (LKSQLCompositeCondition *(^)(NSString *, NSArray*))inStrs;
- (LKSQLCompositeCondition *(^)(NSString *, NSArray*))inNums;


- (NSString *)toString;

@end
