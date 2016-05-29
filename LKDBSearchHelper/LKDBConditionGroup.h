 

#import <Foundation/Foundation.h>
#import "LKDBSQLCondition.h" 
@class LKDBQueryBuilder;

@interface LKDBConditionGroup : LKDBSQLCondition


+(instancetype)clause;
+(instancetype)nonGroupingClause;
-(instancetype)setUseParenthesis:(BOOL)_useParenthesis;
-(instancetype)setAllCommaSeparated:(BOOL)_allCommaSeparated;
-(void)setPreviousSeparator:(NSString *)_separator;

-(LKDBConditionGroup *)createInnerConditionGroup;

-(LKDBConditionGroup *)createInnerAndConditionGroup;

-(LKDBConditionGroup *)createInnerOrConditionGroup;

-(instancetype)operator:(NSString *)_separator sqlCondition:(LKDBSQLCondition *)sqlCondition;


-(instancetype)where:(LKDBSQLCondition *)sqlCondition;

-(instancetype)or:(LKDBSQLCondition *)sqlCondition;

-(instancetype)and:(LKDBSQLCondition *)sqlCondition; 

-(instancetype)andAll:(NSArray<LKDBSQLCondition *> *)sqlConditions;

-(instancetype)orAll:(NSArray<LKDBSQLCondition *> *)sqlConditions;

-(void)appendConditionToQuery:(LKDBQueryBuilder *)queryBuilder;

-(NSString *)getQuery;

-(NSString *)toString;

-(int)size;

-(NSArray<LKDBSQLCondition *> *)getConditions;

@end
