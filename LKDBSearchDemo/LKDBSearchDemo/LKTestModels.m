//
//  LKTestModels.m
//  LKDBHelper
//
//  Created by upin on 13-7-12.
//  Copyright (c) 2013年 ljh. All rights reserved.
//

#import "LKTestModels.h"

@implementation LKTest
// @override
+(LKDBHelper *)getUsingLKDBHelper
{
    static LKDBHelper* db;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        db = [[LKDBHelper alloc]init];
    });
    return db;
}

+(void)initialize
{
    //remove unwant property
    [self removePropertyWithColumnName:@"error"];
    
    //enable the column binding property name
    [self setTableColumnName:@"MyAge" bindingPropertyName:@"age"];
    [self setTableColumnName:@"MyDate" bindingPropertyName:@"date"];
}

+(void)columnAttributeWithProperty:(LKDBProperty *)property
{
    if([property.sqlColumnName isEqualToString:@"MyAge"])
    {
        property.defaultValue = @"15";
    }
    else if([property.propertyName isEqualToString:@"date"])
    {
        // if you use unique,this property will also become the primary key
//        property.isUnique = YES;
        property.checkValue = @"MyDate > '2000-01-01 00:00:00'";
        property.length = 30;
    }
}

+(NSString *)getTableName
{
    return @"LKTestTable";
}
@end
