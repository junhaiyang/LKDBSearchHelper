//
//  LKDBSQLCondition.m
//  wkt_app_ios
//
//  Created by junhai on 16/5/28.
//  Copyright © 2016年 junhai. All rights reserved.
//

#import "LKDBSQLCondition.h"
#import "LKDBQueryBuilder.h"

@interface LKDBSQLCondition(){
    
    NSString *separatorStr;
    
}

@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *operation;
@property (nonatomic,strong) NSString *value;

@end

@implementation LKDBSQLCondition
@synthesize name;
@synthesize operation;
@synthesize value;
+(LKDBSQLCondition *)condition:(NSString *)name operation:(NSString *)operation value:(NSString *)value{
    
    LKDBSQLCondition *condation = [LKDBSQLCondition new];
    condation.name = name;
    condation.operation = operation;
    condation.value = value;
    return condation;
}

+(LKDBSQLCondition *)condition:(NSString *)name inString:(NSArray *)value{
    NSMutableString *string =[NSMutableString new];
    [string appendString:@" ("];
    [string appendString:[value componentsJoinedByString:@","]];
    [string appendString:@") "];
    
    
    return [LKDBSQLCondition condition:name operation:LKDB_OPERATION_IN value:string];
    
} 


+(LKDBSQLCondition *)condition:(NSString *)name operation:(NSString *)operation valueString:(NSString *)value{
    
    return [LKDBSQLCondition condition:name operation:operation value:[NSString stringWithFormat:@"\'%@\'",value]];
}
+(LKDBSQLCondition *)condition:(NSString *)name operation:(NSString *)operation valueInt:(int)value{
    return [LKDBSQLCondition condition:name operation:operation value:[NSString stringWithFormat:@"%d",value]];
}
+(LKDBSQLCondition *)condition:(NSString *)name operation:(NSString *)operation valueFloat:(float)value{
    return [LKDBSQLCondition condition:name operation:operation value:[NSString stringWithFormat:@"%f",value]];
}
+(LKDBSQLCondition *)condition:(NSString *)name operation:(NSString *)operation valueDouble:(double)value{
    return [LKDBSQLCondition condition:name operation:operation value:[NSString stringWithFormat:@"%f",value]];
}
+(LKDBSQLCondition *)condition:(NSString *)name operation:(NSString *)operation valueLong:(long)value{
    return [LKDBSQLCondition condition:name operation:operation value:[NSString stringWithFormat:@"%ld",value]];
}
+(LKDBSQLCondition *)condition:(NSString *)name operation:(NSString *)operation valueLongLong:(long long)value{
    return [LKDBSQLCondition condition:name operation:operation value:[NSString stringWithFormat:@"%lld",value]];
}


+(LKDBSQLCondition *)condition:(NSString *)name equalString:(id)value{
    
    LKDBSQLCondition *condation = [LKDBSQLCondition new];
    condation.name = name;
    condation.operation = @"=";
    condation.value = [NSString stringWithFormat:@"\'%@\'",value];
    
    return condation;
}
+(LKDBSQLCondition *)condition:(NSString *)name equalInt:(int)value{
    
    return [LKDBSQLCondition condition:name equalString:[NSString stringWithFormat:@"%d",value]];
}

+(LKDBSQLCondition *)condition:(NSString *)name equalFloat:(float)value{
    return [LKDBSQLCondition condition:name equalString:[NSString stringWithFormat:@"%f",value]];
}
+(LKDBSQLCondition *)condition:(NSString *)name equalDouble:(double)value{
    return [LKDBSQLCondition condition:name equalString:[NSString stringWithFormat:@"%f",value]];
}
+(LKDBSQLCondition *)condition:(NSString *)name equalLong:(long)value{
    return [LKDBSQLCondition condition:name equalString:[NSString stringWithFormat:@"%ld",value]];
}
+(LKDBSQLCondition *)condition:(NSString *)name equalLongLong:(long long)value{
    return [LKDBSQLCondition condition:name equalString:[NSString stringWithFormat:@"%lld",value]];
}

-(void)appendConditionToQuery:(LKDBQueryBuilder *)queryBuilder{
    [[[[queryBuilder append:name] append:operation] append:value] appendSpace];

}

-(LKDBSQLCondition *)separator:(NSString *)separator{
    separatorStr =separator;
    return self;
}
-(BOOL)hasSeparator{
    return separatorStr.length>0;
}
-(NSString *)separator{
    return separatorStr;
}

@end
