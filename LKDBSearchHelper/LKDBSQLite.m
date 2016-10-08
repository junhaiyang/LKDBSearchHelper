

#import "LKDBSQLite.h"
#import "LKDBHelper.h"
#import "LKDBTransaction.h"

@interface LKDBPersistenceObject()

+ (void)openFieldValidate;

@end

@implementation LKDBSQLite

//开启数据类型校验，默认关闭
static BOOL openFieldValidate_Flag = false;
+ (void)openFieldValidate{
    [LKDBPersistenceObject  openFieldValidate];
}

+(LKDBSelect * _Nonnull )select{
    return [[LKDBSelect alloc] init:nil];
}
+(LKDBSelect * _Nonnull )select:(NSArray * _Nullable)propNames{ 
    return [[LKDBSelect alloc] init:propNames];
}
+(LKDBDelete * _Nonnull )delete{
    return [[LKDBDelete alloc] init];
}

+(LKDBTransaction * _Nonnull )transaction{
    return [[LKDBTransaction alloc] init];
}
+ (void)executeForTransaction:(BOOL (^_Nullable)(void))block{
    [[LKDBTransaction new] executeForTransaction:block];
     
}

+(int)update:(LKDBPersistenceObject * _Nonnull )object{
    return [LKDBSQLite update:object helper:[LKDBHelper getUsingLKDBHelper]];
}

+(int)insert:(LKDBPersistenceObject * _Nonnull )object{
    return [LKDBSQLite insert:object helper:[LKDBHelper getUsingLKDBHelper]];
}

+(void)delete:(LKDBPersistenceObject * _Nonnull )object{
    [LKDBSQLite delete:object helper:[LKDBHelper getUsingLKDBHelper]];
}

+(void)dropTable:(Class _Nonnull)clazz{
    [LKDBSQLite dropTable:clazz helper:[LKDBHelper getUsingLKDBHelper]];
}
 

+(int)update:(LKDBPersistenceObject * _Nonnull )object helper:(LKDBHelper * _Nonnull )helper{
    [helper updateToDB:object where:@{@"rowid":[NSNumber numberWithInteger:object.rowid]}];
    return (int)object.rowid;
}

+(int)insert:(LKDBPersistenceObject * _Nonnull )object helper:(LKDBHelper * _Nonnull )helper{
    [helper  insertToDB:object];
    return (int)object.rowid;
}

+(void)delete:(LKDBPersistenceObject * _Nonnull )object helper:(LKDBHelper * _Nonnull )helper{
    [helper  deleteToDB:object];
}

+(void)dropTable:(Class _Nonnull)clazz helper:(LKDBHelper * _Nonnull )helper{
    [helper dropTableWithClass:clazz];
}

@end
