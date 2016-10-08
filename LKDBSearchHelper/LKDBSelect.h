 

#import <Foundation/Foundation.h> 
#import "LKDBConditionGroup.h"
#import "LKDBSQLCondition.h"
#import "LKDBPersistenceObject.h"



extern NSString* _Nonnull  LKDB_Distinct(NSString * _Nonnull name);

@interface LKDBSelect : NSObject

-(instancetype  _Nonnull)init:(NSArray * _Nullable)propNames;

-(instancetype  _Nonnull)from:(__unsafe_unretained Class  _Nonnull)fromtable;
 
-(instancetype _Nonnull)Where:(LKDBSQLCondition * _Nonnull)sqlCondition;
-(instancetype _Nonnull)and:(LKDBSQLCondition * _Nonnull)sqlCondition;
-(instancetype _Nonnull)or:(LKDBSQLCondition * _Nonnull)sqlCondition;

//查询条件包含括号,会构造一个新的 LKDBConditionGroup,小括号包含 
-(LKDBConditionGroup * _Nonnull)innerAndConditionGroup;

-(LKDBConditionGroup * _Nonnull)innerOrConditionGroup;
 
-(instancetype _Nonnull)orderBy:(NSString *  _Nonnull)orderBy ascending:(BOOL)ascending;
-(instancetype _Nonnull)groupBy:(NSString *  _Nonnull)groupBy;

-(instancetype _Nonnull)offset:(int)offset;
-(instancetype _Nonnull)limit:(int)limit;


-( NSString * _Nonnull )getQuery;


-(NSArray<LKDBPersistenceObject *> *  _Nonnull)queryList;
-(id _Nonnull)querySingle;

-(NSArray *  _Nonnull)queryOriginalList;
-(id  _Nonnull)queryOriginaSingle;

-(int)queryCount;


@end
