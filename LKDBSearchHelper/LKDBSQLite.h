 

#import <Foundation/Foundation.h>
#import "LKDBTransaction.h"
#import "LKDBSelect.h"
#import "LKDBDelete.h"

@interface LKDBSQLite : NSObject


//开启数据类型校验，默认关闭
+ (void)openFieldValidate;

//事务管理
+ (void)executeForTransaction:(BOOL (^ _Nullable)(void))block;

+(LKDBSelect * _Nonnull )select;

+(LKDBSelect * _Nonnull )select:(NSArray * _Nullable)propNames;

+(LKDBDelete * _Nonnull )delete;

+(LKDBTransaction * _Nonnull )transaction;

+(int)update:(LKDBPersistenceObject * _Nonnull )object;

+(int)insert:(LKDBPersistenceObject * _Nonnull )object;

+(void)delete:(LKDBPersistenceObject * _Nonnull )object;

+(void)dropTable:(Class _Nonnull)clazz;
 
 
@end
