 
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
    if(name.length==0||operation.length==0||value.length==0)
        return nil;
    LKDBSQLCondition *condation = [LKDBSQLCondition new];
    condation.name = name;
    condation.operation = operation;
    condation.value = value;
    return condation;
}

+(LKDBSQLCondition *)condition:(NSString *)name inString:(NSArray *)value{
    NSMutableString *string =[NSMutableString new];
    [string appendString:@" ("];
    for (int i = 0; i<value.count; i++) {
        NSString *_v = [NSString stringWithFormat:@"\'%@\'",[value objectAtIndex:i]];
        [string appendString:_v];
        if(i!=(value.count-1)){
            [string appendString:@","];
        }
    }
    [string appendString:@") "];
    
    return [LKDBSQLCondition condition:name operation:LKDB_OPERATION_IN value:string];
    
}
+(LKDBSQLCondition *)condition:(NSString *)name inInt:(NSArray *)value{
    
    NSMutableString *string =[NSMutableString new];
    [string appendString:@" ("];
    for (int i = 0; i<value.count; i++) {
        NSString *_v = [NSString stringWithFormat:@"%lld",[[value objectAtIndex:i] longLongValue]];
        [string appendString:_v];
        if(i!=(value.count-1)){
            [string appendString:@","];
        }
    }
    [string appendString:@") "];
    
    return [LKDBSQLCondition condition:name operation:LKDB_OPERATION_IN value:string];
    
}


+(LKDBSQLCondition *)condition:(NSString *)name operation:(NSString *)operation valueString:(NSString *)value{ 
    return [LKDBSQLCondition condition:name operation:operation value:[NSString stringWithFormat:@"\'%@\'",value]];
}
+(LKDBSQLCondition *)condition:(NSString *)name operation:(NSString *)operation valueInt:(int64_t)value{
    return [LKDBSQLCondition condition:name operation:operation value:[NSString stringWithFormat:@"%lld",value]];
}
+(LKDBSQLCondition *)condition:(NSString *)name operation:(NSString *)operation valueFloat:(float)value{
    return [LKDBSQLCondition condition:name operation:operation value:[NSString stringWithFormat:@"%f",value]];
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
