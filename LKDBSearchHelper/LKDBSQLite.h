 

#import <Foundation/Foundation.h>
#import "LKDBSelect.h"

@interface LKDBSQLite : NSObject

//事务管理
+ (void)executeForTransaction:(BOOL (^)(LKDBHelper* helper))block;
 
+(LKDBSelect *)select;

+(int)update:(LKDBPersistenceObject *)object;

+(int)insert:(LKDBPersistenceObject *)object;

+(void)delete:(LKDBPersistenceObject *)object;

+(void)dropTable:(Class)clazz;


+(LKDBSelect *)select:(LKDBHelper *)helper;

+(int)update:(LKDBPersistenceObject *)object helper:(LKDBHelper *)helper;

+(int)insert:(LKDBPersistenceObject *)object helper:(LKDBHelper *)helper;

+(void)delete:(LKDBPersistenceObject *)object helper:(LKDBHelper *)helper;

+(void)dropTable:(Class)clazz helper:(LKDBHelper *)helper;
 
@end
