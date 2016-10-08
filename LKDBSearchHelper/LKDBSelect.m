 
#import "LKDBSelect.h"
#import "LKDBConditionGroup.h"
#import "LKDBQueryBuilder.h"

#import "LKDBHelper.h" 

extern NSString* _Nonnull  LKDB_Distinct(NSString * _Nonnull name){
    return [@"DISTINCT " stringByAppendingString:name];
}
@interface LKDBHelper(LKDBSelect)
 


-(NSMutableArray *  _Nonnull )executeQuery:(NSString *  _Nonnull )sql toClass:(Class)modelClass;


-(NSMutableArray *  _Nonnull )executeQuery:(NSString *  _Nonnull )sql;


- (NSMutableArray *  _Nonnull )executeResult:(FMResultSet *  _Nonnull )set Class:(Class)modelClass tableName:(NSString * _Nullable )tableName;


@end

@implementation LKDBHelper(LKDBSelect)

-(NSMutableArray *  _Nonnull )executeQuery:(NSString *  _Nonnull )executeSQL toClass:(Class)modelClass
{
    
    __block NSMutableArray* results = nil;
    [self executeDB:^(FMDatabase *db) {
        FMResultSet* set = [db executeQuery:executeSQL];
        results = [self executeResult:set Class:modelClass tableName:nil];
        [set close];
    }];
    return results;
}

-(NSMutableArray *  _Nonnull )executeQuery:(NSString *  _Nonnull )executeSQL
{
    
    __block NSMutableArray* results = nil;
    [self executeDB:^(FMDatabase *db) {
        FMResultSet* set = [db executeQuery:executeSQL];
        results = [self executeResult:set];
        [set close];
    }];
    return results;
}

- (NSMutableArray *  _Nonnull )executeResult:(FMResultSet *  _Nonnull )set
{
    NSMutableArray*   _Nonnull array = [NSMutableArray arrayWithCapacity:0];
    int columnCount = [set columnCount];
    while ([set next]) {
        
        NSMutableDictionary*  _Nonnull  bindingModel = [[NSMutableDictionary alloc]init];
        
        for (int i=0; i<columnCount; i++) {
            
            NSString*  _Nonnull  sqlName = [set columnNameForIndex:i];
            NSObject*   _Nonnull sqlValue = [set objectForColumnIndex:i];
            
            [bindingModel setObject:sqlValue forKey:sqlName];
        }
        [array addObject:bindingModel];
    }
    return array;
}
@end

@interface LKDBSelect(){
    
    
    LKDBConditionGroup *  _Nonnull conditionGroup;
    
    int limit ;
    int offset ;
    
    NSMutableArray<NSString *> *  _Nonnull groupByList;
    NSMutableArray<NSString *> *  _Nonnull orderByList;
    
    
    Class _fromtable;
    
    BOOL selectCount;
    
    LKDBHelper *  _Nonnull helper;
    
    NSMutableArray<NSString *> *  _Nonnull propNames;
}

@end

@implementation LKDBSelect
-(instancetype _Nonnull)init:(NSArray * _Nullable)propName{
    
    self = [super init];
    if (self) {
        conditionGroup =[LKDBConditionGroup clause];
        
        groupByList =[NSMutableArray new];
        orderByList =[NSMutableArray new];
        
        propNames =[NSMutableArray new];
        
        if(propName)
            [propNames addObjectsFromArray:propName];
        
        limit = -1;
        offset = -1;
        helper = [LKDBHelper getUsingLKDBHelper];
        
    }
    return self;
}
-(instancetype _Nonnull)from:(Class _Nonnull)fromtable{
    _fromtable =fromtable;
    return self;
}
 
-(instancetype _Nonnull)Where:(LKDBSQLCondition *  _Nonnull )sqlCondition{
    [conditionGroup operator:nil sqlCondition:sqlCondition];
    return self;
}

-(instancetype _Nonnull)or:(LKDBSQLCondition * _Nonnull )sqlCondition{
    [conditionGroup or:sqlCondition];
    return self;
}
-(instancetype _Nonnull)and:(LKDBSQLCondition * _Nonnull )sqlCondition{
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

-(instancetype _Nonnull)orderBy:(NSString *  _Nonnull)orderBy ascending:(BOOL)ascending{
    if(ascending){
        [orderByList addObject:[NSString stringWithFormat:@"%@ ASC",orderBy]];
    }else{
        [orderByList addObject:[NSString stringWithFormat:@"%@ DESC",orderBy]];
    } 
    return self;
}
 
-(instancetype _Nonnull)groupBy:(NSString *  _Nonnull)groupBy{
    [groupByList addObject:groupBy];
    return self;
}

-(instancetype _Nonnull)offset:(int)_offset{
    offset = _offset;
    return self;
}
-(instancetype _Nonnull)limit:(int)_limit{
    limit = _limit;
    return self;
} 

-(NSString *  _Nonnull )executeSQL{
    
    NSString * _Nullable select = @"*";
    if(propNames.count>0){
        select = [propNames componentsJoinedByString:@","];
    }
    
    NSMutableString * _Nullable sql =[NSMutableString new];
    [sql appendString:@"SELECT "];
    if(selectCount){
        [sql appendString:@"COUNT("];
        [sql appendString:select];
        [sql appendString:@") as count"];
    }else{
        [sql appendString:select];
    }
    [sql appendString:@" FROM "];
    
    [sql appendString:[_fromtable getTableName]];
    
    [sql appendString:@" "];
    
    NSString *conditionQuery = [conditionGroup getQuery];
    
    if(conditionQuery.length>0){
        
        [sql appendString:@"WHERE "];
    }
    
    [sql appendString:conditionQuery];
    
    if(groupByList.count>0){
        [sql appendString:@" GROUP BY "];
        
        [sql appendString:[groupByList componentsJoinedByString:@","]];
        
    }
    
    if(orderByList.count>0){
        [sql appendString:@" ORDER BY "];
        
        
        [sql appendString:[orderByList componentsJoinedByString:@","]];
        
    }
    
    if(offset!=-1&&limit!=-1){
        [sql appendFormat:@" LIMIT %d,%d",offset,limit];
    }else if (limit!=-1){
        [sql appendFormat:@" LIMIT %d",limit];
    }
    NSLog(@"sql:%@",sql);
    return sql;
}
-(NSString * _Nonnull )getQuery{
    return [self executeSQL];
}

-(NSMutableArray *  _Nonnull )queryList{
    return [helper  executeQuery:[self executeSQL] toClass:_fromtable];
    
}
-(NSMutableArray *  _Nonnull )queryOriginalList{
    return [helper  executeQuery:[self executeSQL]];
    
}
-(id _Nonnull)querySingle{
    limit = 1;
    
    NSMutableArray *result =  [helper  executeQuery:[self executeSQL] toClass:_fromtable];
    if(result.count>0)
        return result.firstObject;
    
    return  nil;
     
}
-(id _Nonnull)queryOriginaSingle{
    
    limit = 1;
    
    NSMutableArray *result =  [helper  executeQuery:[self executeSQL]];
    if(result.count>0)
        return result.firstObject;
    
    return  nil;
    
}
-(int)queryCount{
    selectCount =YES;
    NSArray *counts = [helper  executeQuery:[self executeSQL]];
    int _count=0;
    if([counts count]>0){
        _count=(int)((NSNumber *)[((NSDictionary *)[counts firstObject]) objectForKey:@"count"]).intValue;
    }
    return _count;
}
@end
