 

#import <Foundation/Foundation.h>
#import "LKDBSelect.h"

@interface LKDBSQLite : NSObject

//事务管理
+ (void)executeForTransaction:(BOOL (^)(void))block;
 
+(LKDBSelect *)select;

+(int)update:(LKDBPersistenceObject *)object;

+(int)insert:(LKDBPersistenceObject *)object;

+(void)delete:(LKDBPersistenceObject *)object;

+(void)dropTable:(Class)clazz;
 
 
@end
