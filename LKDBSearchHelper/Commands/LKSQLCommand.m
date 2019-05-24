//
//  LKSQLCommand.m
//  iOS-Demo
//
//  Copyright © 2019年 Mars. All rights reserved.
//

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

- (LKSQLCommand *(^)(NSArray *orderByList))orderBy
{
    return ^id(NSArray *orderByList) {
        self.orderByList = orderByList;
        return self;
    };
}

- (LKSQLCommand *(^)(NSArray *groupByList))groupBy
{
    return ^id(NSArray *groupByList) {
        self.groupByList = groupByList;
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
