 

#import "LKDBConditionGroup.h"
#import "LKDBQueryBuilder.h"
#import "LKDBSQLCondition.h"

@interface LKDBConditionGroup(){
    
    NSMutableArray *  _Nonnull conditionsList ;
    
    LKDBQueryBuilder *  _Nonnull query;
    BOOL isChanged;
    BOOL allCommaSeparated;
    BOOL useParenthesis;

    
    NSString   *  _Nonnull separator;
}

@end

@implementation LKDBConditionGroup
- (instancetype _Nonnull)init
{
    self = [super init];
    if (self) {
        conditionsList =  [NSMutableArray new];
        useParenthesis =true;
        
        separator =@"AND";
    }
    return self;
} 

-(LKDBConditionGroup *  _Nonnull )innerAndConditionGroup{
    LKDBConditionGroup *conditionGroup =[LKDBConditionGroup clause];
    [self setPreviousSeparator:@"AND"];
    [conditionsList addObject:conditionGroup];
    isChanged =true;
    return conditionGroup;
}
-(LKDBConditionGroup *  _Nonnull )innerOrConditionGroup{
    LKDBConditionGroup *conditionGroup =[LKDBConditionGroup clause];
    [self setPreviousSeparator:@"OR"];
    [conditionsList addObject:conditionGroup];
    isChanged =true;
    return conditionGroup;
}

+(instancetype _Nonnull)clause{
    return [LKDBConditionGroup new];
}
+(instancetype _Nonnull)nonGroupingClause{
    return [[LKDBConditionGroup new] setUseParenthesis:false];
}
-(instancetype _Nonnull)setUseParenthesis:(BOOL)_useParenthesis{
    useParenthesis = _useParenthesis;
    isChanged =true;
    return self;
}
-(instancetype _Nonnull)setAllCommaSeparated:(BOOL)_allCommaSeparated{
    allCommaSeparated = _allCommaSeparated;
    isChanged =true;
    return self;
}
-(void)setPreviousSeparator:(NSString * _Nonnull)_separator{
    if(conditionsList.count>0){
        [conditionsList.lastObject separator:_separator];
    }
    
}

-(instancetype _Nonnull)operator:(NSString *  _Nonnull )_separator sqlCondition:(LKDBSQLCondition *  _Nonnull )sqlCondition{
    if(sqlCondition){
        [self setPreviousSeparator:_separator];
        [conditionsList addObject:sqlCondition];
        isChanged =true;
    }
    return self;
}
-(instancetype _Nonnull)where:(LKDBSQLCondition *  _Nonnull )sqlCondition{
    [self operator:nil sqlCondition:sqlCondition];
    return self;
}
-(instancetype _Nonnull)or:(LKDBSQLCondition *  _Nonnull )sqlCondition{
    [self operator:@"OR" sqlCondition:sqlCondition];
    return self;
}
-(instancetype _Nonnull)and:(LKDBSQLCondition *  _Nonnull )sqlCondition{
    [self operator:@"AND" sqlCondition:sqlCondition];
    return self;
}
-(instancetype _Nonnull)andAll:(NSArray<LKDBSQLCondition *> *  _Nonnull )sqlConditions{
    for (LKDBSQLCondition *sqlCondition in sqlConditions) {
        [self and:sqlCondition];
    }
    return self;
}
-(instancetype _Nonnull)orAll:(NSArray<LKDBSQLCondition *> *  _Nonnull )sqlConditions{
    for (LKDBSQLCondition *sqlCondition in sqlConditions) {
        [self or:sqlCondition];
    }
    return self;
}

-(void)appendConditionToQuery:(LKDBQueryBuilder *  _Nonnull )queryBuilder{
    if (useParenthesis && conditionsList.count > 0) {
        [queryBuilder append:@"(" ];
    }
    for (LKDBSQLCondition *condition in  conditionsList) {
        [condition appendConditionToQuery:queryBuilder];
        if ([condition hasSeparator]) {
            [queryBuilder appendSpaceSeparated:[condition separator]];
        }
    }
    if (useParenthesis && conditionsList.count > 0) {
        [queryBuilder append:@")" ];
    }
}
 
-(NSString *  _Nonnull )getQuery{
    if (isChanged) {
        query = [LKDBQueryBuilder new];
        
        int count = 0;
        int size = (int)conditionsList.count;
        for (int i = 0; i < size; i++) {
            LKDBSQLCondition *condition = [conditionsList objectAtIndex:i];
            if ([condition isKindOfClass:[LKDBConditionGroup class]]) {
                LKDBConditionGroup *innerConditionGroup = (LKDBConditionGroup *)condition;
                NSString *innerQuery = [innerConditionGroup getQuery];
                //容错处理
                if(innerQuery.length==0){
                    innerQuery =@"1=1";
                }
                [query append:@"(" ];
                [query append:innerQuery];
                [query append:@")" ]; 
            }else{
                
                [condition appendConditionToQuery:query];
            }
            if (count < size - 1) {
                if (!allCommaSeparated) {
                    [[query appendSpace] append:[condition hasSeparator] ? [condition separator] : separator];
                } else {
                    [query append:@","];
                }
                [query appendSpace];
            }
            
            
            count++;
        }
    }
    return query == nil ? @"" : [query toString];

}

-(NSString *  _Nonnull )toString{
    return [self getQuery];
}

-(int)size{
    return (int)conditionsList.count;
}

-(NSArray<LKDBSQLCondition *> *  _Nonnull )getConditions{
    return conditionsList;
}

@end
