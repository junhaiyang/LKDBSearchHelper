

#import "LKSQLDelete.h"
#import "LKSQLCompositeCondition.h"
#import <LKDBHelper.h>

/* Refer:   https://www.sqlite.org/lang_delete.html
 *  These conditions below are supported by SQLite. But we just ignore them for simple...
 *
 *   `limit`
 *   `offset`
 *   `orderBy`
 */

@implementation LKSQLDelete

- (id (^)())exec
{
    return ^id() {
        BOOL succ = [[self.tblClass getUsingLKDBHelper] executeSQL:self.toString arguments:nil];
        return @(succ);
    };
}

- (id (^)(LKDBHelper* dbHelper))execIn
{
    return ^id(LKDBHelper* dbHelper) {
        BOOL succ = [dbHelper executeSQL:self.toString arguments:nil];
        return @(succ);
    };
}

// MARK: SQL translate
- (NSString *)toString{
    NSMutableString *sql = [NSMutableString string];
    [sql appendString:@"DELETE FROM "];
    [sql appendString:[self.tblClass getTableName]];
    
    NSString *conditionQuery = [self.conditionGroup toString];
    if(self.conditionGroup && conditionQuery.length > 0){
        [sql appendString:@" WHERE "];
        [sql appendString:conditionQuery];
    }
    
    return sql;
}

@end
