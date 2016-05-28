 

#import <Foundation/Foundation.h> 
#import "LKDBConditionGroup.h"
#import "LKDBSQLCondition.h"
#import "LKDBPersistenceObject.h"

#import "LKDBHelper.h"


@interface LKDBHelper(LKDBSelect)
 
- (NSMutableArray *)executeQuery:(NSString *)sql toClass:(Class)modelClass;


- (NSMutableArray *)executeQuery:(NSString *)sql;


- (NSMutableArray *)executeResult:(FMResultSet *)set Class:(Class)modelClass tableName:(NSString *)tableName;


@end

@interface LKDBSelect : NSObject

-(instancetype)initWithHelper:(LKDBHelper *)helper;

-(instancetype)from:(Class)fromtable;

  
 
-(instancetype)where:(LKDBSQLCondition *)sqlCondition;
-(instancetype)and:(LKDBSQLCondition *)sqlCondition;
-(instancetype)or:(LKDBSQLCondition *)sqlCondition; 

//查询条件包含括号,会构造一个新的 LKDBConditionGroup,小括号包含
-(LKDBConditionGroup *)innerConditionGroup;
 
-(instancetype)orderBy:(NSArray *)orderBys;
-(instancetype)groupBy:(NSArray *)groupBys;

-(instancetype)offset:(int)offset;
-(instancetype)limit:(int)limit;


-(NSString *)getQuery;


-(NSArray<LKDBPersistenceObject *> *)queryList;
-(LKDBPersistenceObject *)querySingle;

-(NSArray *)queryOriginalList;
-(id)queryOriginaSingle;

-(int)queryCount;


@end
