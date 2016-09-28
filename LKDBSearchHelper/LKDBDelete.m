 
#import "LKDBDelete.h"
#import "LKDBConditionGroup.h"
#import "LKDBQueryBuilder.h"

#import "LKDBHelper.h"



@interface LKDBHelper(LKDBDelete)
 

- (BOOL)executeSQL:(NSString*  _Nonnull )sql;


@end

@implementation LKDBHelper(LKDBDelete)

- (BOOL)executeSQL:(NSString*  _Nonnull )sql
{
    return [self executeSQL:sql arguments:nil];
}
@end

@interface LKDBDelete(){
    
    
    LKDBConditionGroup *  _Nonnull conditionGroup;
    
    int limit ;
    int offset ;
    
    NSMutableArray<NSString *> *  _Nonnull groupByList;
    NSMutableArray<NSString *> *  _Nonnull orderByList;
    
    
    Class _fromtable;
    
    BOOL selectCount;
    
    LKDBHelper *  _Nonnull helper;
}

@end

@implementation LKDBDelete
-(instancetype _Nonnull)init{
    
    self = [super init];
    if (self) {
        conditionGroup =[LKDBConditionGroup clause];
        
        groupByList =[NSMutableArray new];
        orderByList =[NSMutableArray new];
        
        limit = -1;
        offset = -1;
        helper = [LKDBHelper getUsingLKDBHelper];
        
    }
    return self;
}
-(instancetype _Nonnull)from:(Class)fromtable{
    _fromtable =fromtable;
    return self;
}
 
-(instancetype _Nonnull)Where:(LKDBSQLCondition *  _Nonnull )sqlCondition{
    [conditionGroup operator:nil sqlCondition:sqlCondition];
    return self;
}

-(instancetype _Nonnull)or:(LKDBSQLCondition *  _Nonnull )sqlCondition{
    [conditionGroup or:sqlCondition];
    return self;
}
-(instancetype _Nonnull)and:(LKDBSQLCondition *  _Nonnull )sqlCondition{
    [conditionGroup and:sqlCondition];
    return self;
} 

-(instancetype _Nonnull)andAll:(NSArray<LKDBSQLCondition *> *  _Nonnull )sqlConditions{
    [conditionGroup andAll:sqlConditions];
    return self;
}

-(instancetype _Nonnull)orAll:(NSArray<LKDBSQLCondition *> *  _Nonnull )sqlConditions{
    [conditionGroup orAll:sqlConditions];
    return self;
}
 

-(LKDBConditionGroup *  _Nonnull )innerAndConditionGroup{
    return [conditionGroup innerAndConditionGroup];
}

-(LKDBConditionGroup *  _Nonnull )orConditionGroup{
    return [conditionGroup innerOrConditionGroup];
}

-(NSString *  _Nonnull )executeSQL{
    
    NSMutableString *sql =[NSMutableString new];
    [sql appendString:@"DELETE FROM "];
    
    [sql appendString:[_fromtable getTableName]];
    
    [sql appendString:@" "];
    
    NSString *conditionQuery = [conditionGroup getQuery];
    
    if(conditionQuery.length>0){
        
        [sql appendString:@"WHERE "];
    }
    
    [sql appendString:conditionQuery];
    
    NSLog(@"sql:%@",sql);
    return sql;
}
-(NSString *  _Nonnull )getQuery{
    return [self executeSQL];
}

-(BOOL)execute{
    return [helper  executeSQL:[self executeSQL]];
 
}
 
@end
