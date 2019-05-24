

#import "LKSQLCompositeCondition.h"
#import "LKSQLCondition.h"

@interface LKSQLCompositeCondition(){
    NSMutableArray <LKSQLCondition *>* _conditionsList;
    
    LKDBStringBuilder *_query;
    NSString *_defaultConnector;
}

@property (nonatomic, assign) BOOL allCommaSeparated;

- (void)connect:(NSString *)connector sqlCondition:(LKSQLCondition *)sqlCondition;
- (void)setPreviousConnector:(NSString *)connector;
- (NSString *)getQuery;
//- (void)appendConditionToQuery:(LKDBStringBuilder * )queryBuilder; // TODO: optm string alloc

@end

@implementation LKSQLCompositeCondition
// MARK:- Init
- (instancetype)init
{
    self = [super init];
    if (self) {
        _conditionsList = [NSMutableArray array];
        _defaultConnector = LKDB_OP_AND;
    }
    return self;
}

+ (instancetype)clause
{
    return [LKSQLCompositeCondition new];
}

// MARK:- SQL criteria Chaining
- (LKSQLCompositeCondition *)where {return self;}

- (LKSQLCompositeCondition *)or
{
    [self setPreviousConnector:LKDB_OP_OR];
    return self;
}

- (LKSQLCompositeCondition *)and
{
    [self setPreviousConnector:LKDB_OP_AND];
    return self;
}

- (LKSQLCompositeCondition *(^)(LKSQLCondition *))expr
{
    return ^id(LKSQLCondition *innerCond) {
        [self connectSqlCondition:innerCond];
        return self;
    };
}

- (LKSQLCompositeCondition *(^)(NSArray<LKSQLCondition *> *))matchAll
{
    return ^id(NSArray<LKSQLCondition *>* conds) {
        for (LKSQLCondition *cond in conds) {
            [self connect:LKDB_OP_AND sqlCondition:cond];
        }
        return self;
    };
}

- (LKSQLCompositeCondition *(^)(NSArray<LKSQLCondition *> *))matchAny
{
    return ^id(NSArray<LKSQLCondition *>* conds) {
        for (LKSQLCondition *cond in conds) {
            [self connect:LKDB_OP_OR sqlCondition:cond];
        }
        return self;
    };
}

- (LKSQLCompositeCondition *(^)(NSString *, id))eq
{
    return [self operation:LKDB_OP_Eq];
}

- (LKSQLCompositeCondition *(^)(NSString *, id))neq
{
    return [self operation:LKDB_OP_Neq];
}

- (LKSQLCompositeCondition *(^)(NSString *, id))lt
{
    return [self operation:LKDB_OP_Lt];
}

- (LKSQLCompositeCondition *(^)(NSString *, id))lte
{
    return [self operation:LKDB_OP_Lte];
}

- (LKSQLCompositeCondition *(^)(NSString *, id))gt
{
    return [self operation:LKDB_OP_Gt];
}

- (LKSQLCompositeCondition *(^)(NSString *, id))gte
{
    return [self operation:LKDB_OP_Gte];
}

- (LKSQLCompositeCondition *(^)(NSString *, id))like
{
    return [self operation:LKDB_OP_LIKE];
}

- (LKSQLCompositeCondition *(^)(NSString *, id))isNot
{
    return [self operation:LKDB_OP_IsNot];
}

- (LKSQLCompositeCondition *(^)(NSString *, id))operation:(NSString *)operation
{
    return ^id(NSString *colunm, id value) {
        NSString *valueStr = [value isKindOfClass:[NSString class]] ? [NSString stringWithFormat:@"\'%@\'",value] : [value stringValue];
        LKSQLCondition *sqlCondition = [LKSQLCondition condition:colunm operation:operation value:valueStr];
        [self connectSqlCondition:sqlCondition];
        return self;
    };
}

- (LKSQLCompositeCondition *(^)(NSString *, NSArray*))inStrs
{
    return ^id(NSString *colunm, NSArray<NSString *>* values) {
        LKSQLCondition *sqlCondition = [LKSQLCondition condition:colunm inStrValues:values];
        [self connectSqlCondition:sqlCondition];
        return self;
    };
}

- (LKSQLCompositeCondition *(^)(NSString *, NSArray*))inNums
{
    return ^id(NSString *colunm, NSArray<NSNumber *>* values) {
        LKSQLCondition *sqlCondition = [LKSQLCondition condition:colunm inNumValues:values];
        [self connectSqlCondition:sqlCondition];
        return self;
    };
}

// MARK:- Condition Builder
- (void)setPreviousConnector:(NSString *)connector{
    [_conditionsList.lastObject setConnector:connector];
}

- (void)connectSqlCondition:(LKSQLCondition *)sqlCondition{
    if(sqlCondition){
        [_conditionsList addObject:sqlCondition];
    }
}

- (void)connect:(NSString *)connector sqlCondition:(LKSQLCondition *)sqlCondition{
    if(sqlCondition){
        [self setPreviousConnector:connector];
        [_conditionsList addObject:sqlCondition];
    }
}

// MARK:- SQL Translator
- (NSString *)toString
{
    return [self getQuery];
}

- (NSString *)getQuery{
    _query = [LKDBStringBuilder new];
    
    int count = 0;
    NSUInteger size = _conditionsList.count;
    for (int i = 0; i < size; i++) {
        LKSQLCondition *condition = _conditionsList[i];
        
        // 1. add condition
        if ([condition isKindOfClass:[LKSQLCompositeCondition class]]) {
            LKSQLCompositeCondition *innerConditionGroup = (LKSQLCompositeCondition *)condition;
            NSString *innerQuery = [innerConditionGroup getQuery]; // string alloc optm
            // fault tolerant
            if(0 == innerQuery.length){
                innerQuery = @"1=1";
            }
            [_query append:@"(" ];
            [_query append:innerQuery];
            [_query append:@")" ];
        }else{
            [_query append:condition.toString]; // string alloc optm
        }
        
        // 2. add connector
        if (count < size - 1) {
            if (NO == _allCommaSeparated) {
                [_query appendSpace];
                [_query append: condition.hasConnector ? condition.connector : _defaultConnector];
            } else {
                [_query append:@","];
            }
            [_query appendSpace];
        }
        
        count++;
    }
    return _query ? [_query toString] : @"";
}

@end
