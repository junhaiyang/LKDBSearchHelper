 

#import <Foundation/Foundation.h> 
#import "LKDBConditionGroup.h"
#import "LKDBSQLCondition.h"
#import "LKDBPersistenceObject.h"


@interface LKDBDelete : NSObject

-(instancetype _Nonnull)init;

-(instancetype _Nonnull)from:(__unsafe_unretained Class _Nonnull)fromtable;
 
-(instancetype _Nonnull)Where:(LKDBSQLCondition * _Nonnull)sqlCondition;
-(instancetype _Nonnull)and:(LKDBSQLCondition * _Nonnull)sqlCondition;
-(instancetype _Nonnull)or:(LKDBSQLCondition * _Nonnull)sqlCondition;

//查询条件包含括号,会构造一个新的 LKDBConditionGroup,小括号包含 
-(LKDBConditionGroup * _Nonnull)innerAndConditionGroup;

-(LKDBConditionGroup * _Nonnull)innerOrConditionGroup;


-(NSString * _Nonnull)getQuery;

-(BOOL)execute;


@end
