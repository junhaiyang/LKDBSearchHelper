 

#import <Foundation/Foundation.h>
#import "LKDBSQLCondition.h" 
@class LKDBQueryBuilder;

@interface LKDBConditionGroup : LKDBSQLCondition


+(instancetype _Nonnull)clause;
+(instancetype _Nonnull)nonGroupingClause;
-(instancetype _Nonnull)setUseParenthesis:(BOOL)_useParenthesis;
-(instancetype _Nonnull)setAllCommaSeparated:(BOOL)_allCommaSeparated;
-(void)setPreviousSeparator:(NSString *  _Nonnull)_separator;


-(LKDBConditionGroup * _Nonnull)innerAndConditionGroup;

-(LKDBConditionGroup * _Nonnull)innerOrConditionGroup;

-(instancetype _Nonnull)operator:(NSString *  _Nonnull)_separator sqlCondition:(LKDBSQLCondition * _Nonnull)sqlCondition;


-(instancetype _Nonnull)where:(LKDBSQLCondition *  _Nonnull)sqlCondition;

-(instancetype _Nonnull)or:(LKDBSQLCondition *  _Nonnull)sqlCondition;

-(instancetype _Nonnull)and:(LKDBSQLCondition *  _Nonnull)sqlCondition;

-(instancetype _Nonnull)andAll:(NSArray<LKDBSQLCondition *> * _Nonnull)sqlConditions;

-(instancetype _Nonnull)orAll:(NSArray<LKDBSQLCondition *> *  _Nonnull)sqlConditions;

-(void)appendConditionToQuery:(LKDBQueryBuilder *  _Nonnull)queryBuilder;

-(NSString * _Nonnull)getQuery;

-(NSString * _Nonnull)toString;

-(int)size;

-(NSArray<LKDBSQLCondition *> * _Nonnull)getConditions;

@end
