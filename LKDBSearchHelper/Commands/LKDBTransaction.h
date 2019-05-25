 

#import <Foundation/Foundation.h>

@class LKDBHelper;

/* DB Transcation wrapper */

typedef NS_ENUM(NSUInteger, LKDBSQLAction) {
    LKDBSQLActionInsert = 0,
    LKDBSQLActionUpdate = 1,
    LKDBSQLActionDelete = 2,
};

@protocol LKDBTransactionData <NSObject>
@property (nonatomic,assign) LKDBSQLAction action;
@end

@interface LKDBTransaction : NSObject
+ (instancetype)newTransaction;

- (void)batchUpdate:(NSArray <LKDBTransactionData> *)dataArr;
- (void)batchInsert:(NSArray <LKDBTransactionData> *)dataArr;
- (void)batchDelete:(NSArray <LKDBTransactionData> *)dataArr;
- (void)update:(id <LKDBTransactionData>)object;
- (void)insert:(id <LKDBTransactionData>)object;
- (void)delete:(id <LKDBTransactionData>)object;

- (void)executeToDB:(LKDBHelper *)dbHelper;

@end
