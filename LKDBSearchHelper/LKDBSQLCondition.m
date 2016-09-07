 
#import "LKDBSQLCondition.h"
#import "LKDBQueryBuilder.h"


NSString* const LKDB_OPERATION_Equal = @"=";
NSString* const LKDB_OPERATION_NotEqual=@"<>";
NSString* const LKDB_OPERATION_IsNot=@"IS NOT";
NSString* const LKDB_OPERATION_LIKE=@"LIKE";
NSString* const LKDB_OPERATION_IN=@"IN";

NSString* const LKDB_OPERATION_LessThan=@"<";
NSString* const LKDB_OPERATION_GreaterThan=@">";

NSString* const LKDB_OPERATION_LessAndEqualThan=@"<=";
NSString* const LKDB_OPERATION_GreaterAndEqualThan=@">=";

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


LKDBSQLCondition* LKDB_Equal_String(NSString *name,NSString *value){
    return [LKDBSQLCondition condition:name operation:LKDB_OPERATION_Equal valueString:value];
}

LKDBSQLCondition* LKDB_Equal_Int(NSString *name,int64_t value){
    return [LKDBSQLCondition condition:name operation:LKDB_OPERATION_Equal valueInt:value];
}

LKDBSQLCondition* LKDB_Equal_Float(NSString *name,float value){
    return [LKDBSQLCondition condition:name operation:LKDB_OPERATION_Equal valueFloat:value];
}




LKDBSQLCondition* LKDB_NotEqual_String(NSString *name,NSString *value){
    return [LKDBSQLCondition condition:name operation:LKDB_OPERATION_NotEqual valueString:value];
}

LKDBSQLCondition* LKDB_NotEqual_Int(NSString *name,int64_t value){
    return [LKDBSQLCondition condition:name operation:LKDB_OPERATION_NotEqual valueInt:value];
}

LKDBSQLCondition* LKDB_NotEqual_Float(NSString *name,float value){
    return [LKDBSQLCondition condition:name operation:LKDB_OPERATION_NotEqual valueFloat:value];
}



//字符串不等于

LKDBSQLCondition* LKDB_IsNot_String(NSString *name,NSString *value){
    return [LKDBSQLCondition condition:name operation:LKDB_OPERATION_IsNot valueString:value];
}
LKDBSQLCondition* LKDB_LIKE_String(NSString *name,NSString *value){
    return [LKDBSQLCondition condition:name operation:LKDB_OPERATION_LIKE valueString:value];
}


LKDBSQLCondition* LKDB_LessThan_String(NSString *name,NSString *value){
    return [LKDBSQLCondition condition:name operation:LKDB_OPERATION_LessThan valueString:value];
}
LKDBSQLCondition* LKDB_LessThan_Int(NSString *name,int64_t value){
    return [LKDBSQLCondition condition:name operation:LKDB_OPERATION_LessThan valueInt:value];
}
LKDBSQLCondition* LKDB_LessThan_Float(NSString *name,float value){
    return [LKDBSQLCondition condition:name operation:LKDB_OPERATION_LessThan valueFloat:value];
}


LKDBSQLCondition* LKDB_GreaterThan_String(NSString *name,NSString *value){
    return [LKDBSQLCondition condition:name operation:LKDB_OPERATION_GreaterThan valueString:value];
}
LKDBSQLCondition* LKDB_GreaterThan_Int(NSString *name,int64_t value){
    return [LKDBSQLCondition condition:name operation:LKDB_OPERATION_GreaterThan valueInt:value];
}
LKDBSQLCondition* LKDB_GreaterThan_Float(NSString *name,float value){
    return [LKDBSQLCondition condition:name operation:LKDB_OPERATION_GreaterThan valueFloat:value];
}

LKDBSQLCondition* LKDB_LessAndEqualThan_String(NSString *name,NSString *value){
    return [LKDBSQLCondition condition:name operation:LKDB_OPERATION_LessAndEqualThan valueString:value];
}
LKDBSQLCondition* LKDB_LessAndEqualThan_Int(NSString *name,int64_t value){
    return [LKDBSQLCondition condition:name operation:LKDB_OPERATION_LessAndEqualThan valueInt:value];
}
LKDBSQLCondition* LKDB_LessAndEqualThan_Float(NSString *name,float value){
    return [LKDBSQLCondition condition:name operation:LKDB_OPERATION_LessAndEqualThan valueFloat:value];
}


LKDBSQLCondition* LKDB_GreaterAndEqualThan_String(NSString *name,NSString *value){
    return [LKDBSQLCondition condition:name operation:LKDB_OPERATION_GreaterAndEqualThan valueString:value];
}
LKDBSQLCondition* LKDB_GreaterAndEqualThan_Int(NSString *name,int64_t value){
    return [LKDBSQLCondition condition:name operation:LKDB_OPERATION_GreaterAndEqualThan valueInt:value];
}
LKDBSQLCondition* LKDB_GreaterAndEqualThan_Float(NSString *name,float value){
    return [LKDBSQLCondition condition:name operation:LKDB_OPERATION_GreaterAndEqualThan valueFloat:value];
}

LKDBSQLCondition* LKDB_IN_String(NSString *name,NSArray<NSString *> *value){
    return [LKDBSQLCondition condition:name  inString:value];
}
LKDBSQLCondition* LKDB_IN_Int(NSString *name,NSArray<NSString *> *value){
    return [LKDBSQLCondition condition:name inInt:value];
}


LKDBSQLCondition* LKDB_Condition(NSString *name,NSString *operation,NSString *value){
    return [LKDBSQLCondition condition:name operation:operation value:value];
}

