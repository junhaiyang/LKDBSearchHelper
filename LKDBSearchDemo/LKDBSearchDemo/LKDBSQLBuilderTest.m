//
//  LKDBSQLBuilderTest.m
//  iOS-Demo
//
//  Copyright © 2019年 Mars. All rights reserved.
//

#import "LKDBSQLBuilderTest.h"
#import <LKDBSearchHelper/LKSQLBuilder.h>
#import <UIKit/UIKit.h>
#import "LKTestModels.h"


@implementation LKDBSQLBuilderTest
#if ENALBE_LKDBSQLBuilderTest == 1

#define DEBUGLOG(fmt, ...) NSLog(fmt "\n...", ##__VA_ARGS__)

+ (void)load
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(test) name:UIApplicationDidFinishLaunchingNotification object:nil];
}

+ (void)test {
    LKSQLCompositeCondition *cond;
    
    DEBUGLOG(@"### RUNNING TEST <%@>\n=================", self);
    
    //MARK: TEST single condition
    DEBUGLOG(@"#TEST single condition");
    // empty
    cond = LKSQLCompositeCondition.clause;
    NSAssert(cond.toString.length == 0, @"EMPTY clause SHOULD print ''");
    // eq
    cond = LKSQLCompositeCondition.clause.where.eq(@"colA", @0.1);
    DEBUGLOG(@"%@", cond.toString);
    // neq
    cond = LKSQLCompositeCondition.clause.where.neq(@"colA", @"0.01");
    DEBUGLOG(@"%@", cond.toString);
    // lt
    cond = LKSQLCompositeCondition.clause.where.lt(@"colA", @0.001);
    DEBUGLOG(@"%@", cond.toString);
    // lte
    cond = LKSQLCompositeCondition.clause.where.lte(@"colA", @"0.0001");
    DEBUGLOG(@"%@", cond.toString);
    // gt
    cond = LKSQLCompositeCondition.clause.where.gt(@"colA", @(0.0000001)); // REMARK: here NSNumber's auto-Scientific-notation is OK for SQLite's syntax
    DEBUGLOG(@"%@", cond.toString);
    // gte
    cond = LKSQLCompositeCondition.clause.where.gte(@"colA", @"0.000000000001");
    DEBUGLOG(@"%@", cond.toString);
    // like
    cond = LKSQLCompositeCondition.clause.where.like(@"colA", @"0.000000000001");
    DEBUGLOG(@"%@", cond.toString);
    // isNot
    cond = LKSQLCompositeCondition.clause.where.isNot(@"colA", @"0.000000000001");
    DEBUGLOG(@"%@", cond.toString);
    // inStr
    cond = LKSQLCompositeCondition.clause.where.inStrs(@"colA", @[@"str1", @"str2", @"str3"]);
    DEBUGLOG(@"%@", cond.toString);
    // inNum
    cond = LKSQLCompositeCondition.clause.where.inNums(@"colA", @[@1, @2, @3]);
    DEBUGLOG(@"%@", cond.toString);
    
    // nullable case
    // eq
    cond = LKSQLCompositeCondition.clause.where.eq(@"colA", nil);
    DEBUGLOG(@"%@", cond.toString);
    // inStr
    cond = LKSQLCompositeCondition.clause.where.inStrs(@"colA", @[]);
    DEBUGLOG(@"%@", cond.toString);
    cond = LKSQLCompositeCondition.clause.where.inStrs(@"colA", nil);
    DEBUGLOG(@"%@", cond.toString);
    // inNum
    cond = LKSQLCompositeCondition.clause.where.inNums(@"colA", @[]);
    DEBUGLOG(@"%@", cond.toString);
    cond = LKSQLCompositeCondition.clause.where.inNums(@"colA", nil);
    DEBUGLOG(@"%@", cond.toString);
    
    
    //MARK: TEST condition group
    // AND, OR
    DEBUGLOG(@"#TEST AND, OR");
    cond = _SQLWhere
    .eq(@"colA", nil)
    .neq(@"colB", nil)
    .lt(@"colC", nil)
    .and.lte(@"colD", nil)
    .gt(@"colE", nil)
    .gte(@"colF", nil)
    .like(@"colG", nil)
    .isNot(@"colH", nil)
    .inStrs(@"colI", nil)
    .inNums(@"colJ", nil)
    .or.eq(@"colA", nil)
    .or.neq(@"colB", nil)
    .or.lt(@"colC", nil)
    .and.lte(@"colD", nil)
    .or.gt(@"colE", nil)
    .or.gte(@"colF", nil)
    .or.like(@"colG", nil)
    .or.isNot(@"colH", nil)
    .or.inStrs(@"colI", nil)
    .or.inNums(@"colJ", nil)
    ;
    DEBUGLOG(@"%@", cond.toString);
    
    // matchAll
    DEBUGLOG(@"#TEST matchAll");
    cond = _SQLWhere.eq(@"colA", nil).matchAll(
        @[
          _SQLWhere.eq(@"colA", nil).neq(@"colAA", nil),
          _SQLWhere.eq(@"colB", nil).neq(@"colBA", nil),
          _SQLWhere.eq(@"colC", nil).neq(@"colCA", nil),
          ]
    )
    .and.lte(@"colD", nil)
    .or.eq(@"colA", nil)
    .and.lte(@"colC", nil)
    ;
    DEBUGLOG(@"%@", cond.toString);
    
    // matchAny
    DEBUGLOG(@"#TEST matchAny");
    cond = _SQLWhere.eq(@"colA", nil).matchAny(
        @[
          _SQLWhere.eq(@"colA", nil).neq(@"colAA", nil),
          _SQLWhere.eq(@"colB", nil).neq(@"colBA", nil),
          _SQLWhere.eq(@"colC", nil).neq(@"colCA", nil),
          ]
    )
    .and.lte(@"colD", nil)
    .or.eq(@"colA", nil)
    .and.lte(@"colC", nil)
    ;
    DEBUGLOG(@"%@", cond.toString);
    
    // nested condition
    DEBUGLOG(@"#TEST nested condition");
    cond = _SQLWhere.eq(@"colA", nil).and.expr(
        _SQLWhere.eq(@"colAA", nil).or.neq(@"colAB", nil).and.expr(
            _SQLWhere.eq(@"colAAA", nil).or.neq(@"colAAB", nil)
            // ...endless nested conditon
        )
    )
    .and.lte(@"colD", nil)
    .or.eq(@"colA", nil)
    .and.lte(@"colC", nil)
    ;
    DEBUGLOG(@"%@", cond.toString);
    
    
    //MARK: TEST SQL commands
    LKSQLSelect *select = (id)_SQLSelect.from(LKTest.class).where(
        _SQLWhere.eq(@"MyAge", @"16")
    ).orderBy(nil).groupBy(nil).limit(0).offset(0);
    DEBUGLOG(@"## %@", select.toString);
    
    
    _SQLSelect.from(LKTest.class).where(
                                        _SQLWhere.eq(@"MyAge", @"16")
                                        ).orderBy(nil).groupBy(nil).limit(0).offset(0).exec();
    
    LKSQLDelete *delete = (id)_SQLDelete.from(LKTest.class).where(
        _SQLWhere.eq(@"MyAge", @"16")
    );
    DEBUGLOG(@"## %@", delete.toString);
    
    // insert mock data
    [self.mockData saveToDB];
    [self.mockData saveToDB];
    [self.mockData saveToDB];
    [self.mockData saveToDB];
    [self.mockData saveToDB];
    
    // execute select
    DEBUGLOG(@"DBPath: %@", [[LKTest getUsingLKDBHelper] valueForKey:@"dbPath"]);
    DEBUGLOG(@"## RUNNING %@", select.toString);
    NSArray *res = (id)select.exec();
    DEBUGLOG(@"## count: %ld", res.count);
    
    // execute delete
    DEBUGLOG(@"## RUNNING %@", delete.toString);
    delete.exec();
    DEBUGLOG(@"## count: %ld", [LKTest searchWithWhere:nil].count);
    
    
}



+ (LKTest *)mockData {
    LKTest* test = [LKTest new];
    test.name = @"zhan san";
    test.age = 16;
    test.url = [NSURL URLWithString:@"http://fake.url.com"];
    test.blah = @[@"1",@"2",@"3"];
    test.hoho = @{@"array":test.blah,@"normal":@123456,@"date":[NSDate date]};
    test.isGirl = YES;
    test.like   = 'I';
    test.date   = [NSDate date];
    test.color  = [UIColor orangeColor];
    test.score  = [[NSDate date] timeIntervalSince1970];
    test.data   = [@"hahaha" dataUsingEncoding:NSUTF8StringEncoding];

    return test;
}

#endif
@end





