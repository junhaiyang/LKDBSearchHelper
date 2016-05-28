

#import "LKDBSQLite.h"
#import "LKDBHelper.h"

@implementation LKDBSQLite


+(LKDBSelect *)select{
    return [[LKDBSelect alloc] initWithHelper:[LKDBHelper getUsingLKDBHelper]];
}
+ (void)executeForTransaction:(BOOL (^)(void))block{
    [[LKDBHelper getUsingLKDBHelper] executeForTransaction:^BOOL(LKDBHelper *helper) {
        return block();
    }]; 
}

+(int)update:(LKDBPersistenceObject *)object{
    return [LKDBSQLite update:object helper:[LKDBHelper getUsingLKDBHelper]];
}

+(int)insert:(LKDBPersistenceObject *)object{
    return [LKDBSQLite insert:object helper:[LKDBHelper getUsingLKDBHelper]];
}

+(void)delete:(LKDBPersistenceObject *)object{
    [LKDBSQLite delete:object helper:[LKDBHelper getUsingLKDBHelper]];
}

+(void)dropTable:(Class)clazz{
    [LKDBSQLite dropTable:clazz helper:[LKDBHelper getUsingLKDBHelper]];
}

+(LKDBSelect *)select:(LKDBHelper *)helper{
    return [[LKDBSelect alloc] initWithHelper:helper];
}

+(int)update:(LKDBPersistenceObject *)object helper:(LKDBHelper *)helper{
    [helper updateToDB:object where:@{@"rowid":[NSNumber numberWithInteger:object.rowid]}];
    return (int)object.rowid;
}

+(int)insert:(LKDBPersistenceObject *)object helper:(LKDBHelper *)helper{
    [helper  insertToDB:object];
    return (int)object.rowid;
}

+(void)delete:(LKDBPersistenceObject *)object helper:(LKDBHelper *)helper{
    [helper  deleteToDB:object];
}

+(void)dropTable:(Class)clazz helper:(LKDBHelper *)helper{
    [helper dropTableWithClass:clazz];
}

@end
