 

#import <Foundation/Foundation.h> 
#import "LKDBConditionGroup.h"
#import "LKDBSQLCondition.h"
#import "LKDBPersistenceObject.h"


@interface LKDBSelect : NSObject

-(instancetype)init;

-(instancetype)from:(Class)fromtable;
 
-(instancetype)Where:(LKDBSQLCondition *)sqlCondition;
-(instancetype)and:(LKDBSQLCondition *)sqlCondition;
-(instancetype)or:(LKDBSQLCondition *)sqlCondition; 

//查询条件包含括号,会构造一个新的 LKDBConditionGroup,小括号包含 
-(LKDBConditionGroup *)innerAndConditionGroup;

-(LKDBConditionGroup *)innerOrConditionGroup;
 
-(instancetype)orderBy:(NSArray *)orderBys;
-(instancetype)groupBy:(NSArray *)groupBys;

-(instancetype)offset:(int)offset;
-(instancetype)limit:(int)limit;


-(NSString *)getQuery;


-(NSArray<LKDBPersistenceObject *> *)queryList;
-(id)querySingle;

-(NSArray *)queryOriginalList;
-(id)queryOriginaSingle;

-(int)queryCount;


@end
