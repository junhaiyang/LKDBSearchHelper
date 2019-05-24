 

#import "LKDBTransaction.h"
#import <LKDBHelper.h>


@interface LKDBTransaction() {
    NSMutableArray *_actionDataArr;
}
@end

@implementation LKDBTransaction
+ (instancetype)newTransaction {
    return [self new];
}

- (instancetype)init
{
    if (self = [super init]) {
        _actionDataArr = [NSMutableArray array];
    }
    return self;
}

// MARK:- DB ops
- (void)batchUpdate:(NSArray <LKDBTransactionData> *)dataArr{
    [dataArr enumerateObjectsUsingBlock:^(id <LKDBTransactionData>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.action = LKDBSQLActionUpdate;
        [_actionDataArr addObject:obj];
    }];
}

- (void)batchInsert:(NSArray <LKDBTransactionData> *)dataArr{
    [dataArr enumerateObjectsUsingBlock:^(id <LKDBTransactionData>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.action = LKDBSQLActionInsert;
        [_actionDataArr addObject:obj];
    }];
}

- (void)batchDelete:(NSArray <LKDBTransactionData> *)dataArr{
    [dataArr enumerateObjectsUsingBlock:^(id <LKDBTransactionData>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.action = LKDBSQLActionDelete;
        [_actionDataArr addObject:obj];
    }];}

- (void)update:(id <LKDBTransactionData>)object{
    object.action = LKDBSQLActionUpdate;
    [_actionDataArr addObject:object];
}

- (void)insert:(id <LKDBTransactionData>)object{
    object.action = LKDBSQLActionInsert;
    [_actionDataArr addObject:object];
}

- (void)delete:(id <LKDBTransactionData>)object{
    object.action = LKDBSQLActionDelete;
    [_actionDataArr addObject:object];
}

// MARK:- excute
- (void)executeToDB:(LKDBHelper *)dbHelper{
    [dbHelper executeForTransaction:^BOOL(LKDBHelper *helper) {
        @try {
            for (NSObject <LKDBTransactionData> * object in _actionDataArr) {
                if(object.action == LKDBSQLActionInsert)
                    [object saveToDB];
                
                if(object.action == LKDBSQLActionUpdate)
                    [object updateToDB];
                
                if(object.action == LKDBSQLActionDelete)
                    [object deleteToDB];
            }
            return YES;
        } @catch (NSException *exception) {
             return NO;
        }
    }];
}

@end
