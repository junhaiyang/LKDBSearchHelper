 

#import "LKDBConditionGroup.h"
#import "LKDBQueryBuilder.h"
#import "LKDBSQLCondition.h"

@interface LKDBConditionGroup(){
    
    NSMutableArray *conditionsList ;
    
    LKDBQueryBuilder *query;
    BOOL isChanged;
    BOOL allCommaSeparated;
    BOOL useParenthesis;

    NSString   *separator;
}

@end

@implementation LKDBConditionGroup
- (instancetype)init
{
    self = [super init];
    if (self) {
        conditionsList =  [NSMutableArray new];
        useParenthesis =true;
        
        separator =@"AND";
    }
    return self;
}
-(LKDBConditionGroup *)createInnerConditionGroup{
    LKDBConditionGroup *conditionGroup =[LKDBConditionGroup clause];
    [self setPreviousSeparator:@"AND"];
    [conditionsList addObject:conditionGroup];
    isChanged =true;
    return conditionGroup;
}

+(instancetype)clause{
    return [LKDBConditionGroup new];
}
+(instancetype)nonGroupingClause{
    return [[LKDBConditionGroup new] setUseParenthesis:false];
}
-(instancetype)setUseParenthesis:(BOOL)_useParenthesis{
    useParenthesis = _useParenthesis;
    isChanged =true;
    return self;
}
-(instancetype)setAllCommaSeparated:(BOOL)_allCommaSeparated{
    allCommaSeparated = _allCommaSeparated;
    isChanged =true;
    return self;
}
-(void)setPreviousSeparator:(NSString *)_separator{
    if(conditionsList.count>0){
        [conditionsList.lastObject separator:_separator];
    }
    
}

-(instancetype)operator:(NSString *)_separator sqlCondition:(LKDBSQLCondition *)sqlCondition{
    [self setPreviousSeparator:_separator];
    [conditionsList addObject:sqlCondition];
    isChanged =true;
    return self;
}
-(instancetype)where:(LKDBSQLCondition *)sqlCondition{
    [self operator:nil sqlCondition:sqlCondition];
    return self;
}
-(instancetype)or:(LKDBSQLCondition *)sqlCondition{
    [self operator:@"OR" sqlCondition:sqlCondition];
    return self;
}
-(instancetype)and:(LKDBSQLCondition *)sqlCondition{
    [self operator:@"AND" sqlCondition:sqlCondition];
    return self;
}
-(instancetype)andAll:(NSArray<LKDBSQLCondition *> *)sqlConditions{
    for (LKDBSQLCondition *sqlCondition in sqlConditions) {
        [self and:sqlCondition];
    }
    return self;
}
-(instancetype)orAll:(NSArray<LKDBSQLCondition *> *)sqlConditions{
    for (LKDBSQLCondition *sqlCondition in sqlConditions) {
        [self or:sqlCondition];
    }
    return self;
}

-(void)appendConditionToQuery:(LKDBQueryBuilder *)queryBuilder{
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
 
-(NSString *)getQuery{
    if (isChanged) {
        query = [LKDBQueryBuilder new];
        
        int count = 0;
        int size = (int)conditionsList.count;
        for (int i = 0; i < size; i++) {
            LKDBSQLCondition *condition = [conditionsList objectAtIndex:i];
            if ([condition isKindOfClass:[LKDBConditionGroup class]]) {
                LKDBConditionGroup *innerConditionGroup = (LKDBConditionGroup *)condition;
                [query append:@"(" ];
                [query append:[innerConditionGroup getQuery]];
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

-(NSString *)toString{
    return [self getQuery];
}

-(int)size{
    return (int)conditionsList.count;
}

-(NSArray<LKDBSQLCondition *> *)getConditions{
    return conditionsList;
}

@end
