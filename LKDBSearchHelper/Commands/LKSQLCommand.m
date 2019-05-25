

#import "LKSQLCommand.h"

@interface LKSQLCommand ()
@property (nonatomic, assign) NSInteger mLimit;
@property (nonatomic, assign) NSInteger mOffset;
@property (nonatomic, assign) BOOL countOnly;
@property (nonatomic, strong) Class tblClass;
@property (nonatomic, strong) LKSQLCondition* conditionGroup;
@property (nonatomic, copy)   NSArray* orderByList;
@property (nonatomic, copy)   NSArray* groupByList;
@end

@implementation LKSQLCommand
// MARK:- DB cretieria
+ (instancetype)clause { return [self new]; }

- (LKSQLCommand *(^)(Class tblClass))from
{
    return ^id(Class tblCls) {
        self.tblClass = tblCls;
        return self;
    };
}

- (LKSQLCommand *(^)(LKSQLCondition *sqlCondition))where
{
    return ^id(LKSQLCondition* sqlCond) {
        self.conditionGroup = sqlCond;
        return self;
    };
}

- (LKSQLCommand *(^)(id orderBy))orderBy
{
    return ^id(id orderBy) {
        if ([orderBy isKindOfClass:[NSArray class]]) {
            self.orderByList = orderBy;
        } else if ([orderBy isKindOfClass:[NSString class]]) {
            self.orderByList = @[orderBy];
        }
        return self;
    };
}

- (LKSQLCommand *(^)(id groupBy))groupBy
{
    return ^id(id groupBy) {
        if ([groupBy isKindOfClass:[NSArray class]]) {
            self.groupByList = groupBy;
        } else if ([groupBy isKindOfClass:[NSString class]]) {
            self.groupByList = @[groupBy];
        }
        return self;
    };
}

- (LKSQLCommand *(^)(NSInteger offset))offset
{
    return ^id(NSInteger offset) {
        self.mOffset = offset;
        return self;
    };
}

- (LKSQLCommand *(^)(NSInteger limit))limit
{
    return ^id(NSInteger limit) {
        self.mLimit = limit;
        return self;
    };
}

- ( NSString *)toString { /* @abstract */ return nil;}
- (id (^)())exec { /* @abstract */ return nil;}
- (id (^)(LKDBHelper *))execIn { /* @abstract */ return nil;}

@end
