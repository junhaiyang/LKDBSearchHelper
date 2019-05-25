

#import <Foundation/Foundation.h>
#import "LKDBStringBuilder.h"

/* Single Condition Builder */

@interface LKSQLCondition : NSObject
@property (nonatomic, copy) NSString * connector;

+ (LKSQLCondition *)condition:(NSString *)name operation:(NSString *)operation value:(NSString *)value;

+ (LKSQLCondition *)condition:(NSString *)name inStrValues:(NSArray <NSString *> *)value; // e.g. ('1', '2' ,'3')
+ (LKSQLCondition *)condition:(NSString *)name inNumValues:(NSArray <NSNumber *> *)value; // e.g. (1, 2, 3)

- (BOOL)hasConnector;

- (NSString *)toString;

@end
