

#import "LKDBSQLConstant.h"
#import "LKSQLSelect.h"
#import "LKSQLCompositeCondition.h"
#import <LKDBHelper.h>

@interface LKSQLSelect()
@end

@implementation LKSQLSelect

- (id (^)())exec
{
    return ^id() {
        return [[self.tblClass getUsingLKDBHelper] searchWithRAWSQL:self.toString toClass:self.tblClass];
    };
}

- (id (^)(LKDBHelper* dbHelper))execIn
{
    return ^id(LKDBHelper* dbHelper) {
        return [dbHelper searchWithRAWSQL:self.toString toClass:self.tblClass];
    };
}

// MARK:- Translate `SELECT`
- (NSString * )toString{
    NSString * colunms = @"*";
    NSMutableString * sql = [NSMutableString string];
    [sql appendString:LKSQL_SELECT@" "];
    if(self.countOnly){
        [sql appendString:LKSQL_COUNT@"("];
        [sql appendString:colunms];
        [sql appendString:@") as count"];
    }else{
        [sql appendString:colunms];
    }
    
    [sql appendString:@" "LKSQL_FROM@" "];
    [sql appendString:[self.tblClass getTableName]];
    [sql appendString:@" "];
    
    NSString *conditionQuery = [self.conditionGroup toString];
    if(self.conditionGroup && conditionQuery.length > 0){
        [sql appendString:LKSQL_WHERE@" "];
        [sql appendString:conditionQuery];
    }
    
    if(self.groupByList.count > 0){
        [sql appendString:@" "LKSQL_GROUP_BY@" "];
        [sql appendString:[self.groupByList componentsJoinedByString:@","]];
    }
    
    if(self.orderByList.count > 0){
        [sql appendString:@" "LKSQL_ORDER_BY@" "];
        [sql appendString:[self.orderByList componentsJoinedByString:@","]];
    }
    
    if (self.mLimit > 0) {
        [sql appendFormat:@" "LKSQL_LIMIT@" %ld "LKSQL_OFFSET@" %ld", (long)self.mLimit, (long)self.mOffset];
    } else if (self.mOffset > 0) {
        [sql appendFormat:@" "LKSQL_LIMIT@" %d "LKSQL_OFFSET@" %ld", INT_MAX, (long)self.mOffset];
    }
    
    return sql;
}

@end


