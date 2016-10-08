

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
+(LKDBSelect * _Nonnull )select:(NSString * _Nullable)propName,...{
    va_list args;
    va_start(args, propName);
    
    NSMutableArray *propNames = [NSMutableArray new];
    if (propName)
    {
        
        NSString * otherString;
        while (1)//在循环中遍历
        {
            //依次取得所有参数
            otherString = va_arg(args, NSString *);
            if(otherString == nil)//当最后一个参数为nil的时候跳出循环
                break;
            else{
                [propNames addObject:otherString];
            }
        }
    }
    va_end(args);
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
