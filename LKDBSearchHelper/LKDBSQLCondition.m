 
#import "LKDBSQLCondition.h"
#import "LKDBQueryBuilder.h"


NSString* _Nonnull const LKDB_OPERATION_Equal = @"=";
NSString* _Nonnull const LKDB_OPERATION_NotEqual=@"<>";
NSString* _Nonnull const LKDB_OPERATION_IsNot=@"IS NOT";
NSString* _Nonnull const LKDB_OPERATION_LIKE=@"LIKE";
NSString* _Nonnull const LKDB_OPERATION_IN=@"IN";

NSString* _Nonnull const LKDB_OPERATION_LessThan=@"<";
NSString* _Nonnull const LKDB_OPERATION_GreaterThan=@">";

NSString* _Nonnull const LKDB_OPERATION_LessAndEqualThan=@"<=";
NSString* _Nonnull const LKDB_OPERATION_GreaterAndEqualThan=@">=";

@interface LKDBSQLCondition(){
    
    NSString *  _Nonnull separatorStr;
    
}

@property (nonatomic,strong) NSString *  _Nonnull name;
@property (nonatomic,strong) NSString *  _Nonnull operation;
@property (nonatomic,strong) NSString *  _Nonnull value;

@end

@implementation LKDBSQLCondition
@synthesize name;
@synthesize operation;
@synthesize value;
+(LKDBSQLCondition * _Nonnull )condition:(NSString * _Nonnull )name operation:(NSString * _Nonnull )operation value:(NSString * _Nonnull )value{
    if(name.length==0||operation.length==0||value.length==0)
        return nil;
    LKDBSQLCondition *_Nonnull condation = [LKDBSQLCondition new];
    condation.name = name;
    condation.operation = operation;
    condation.value = value;
    return condation;
}

+(LKDBSQLCondition * _Nonnull )condition:(NSString * _Nonnull )name inString:(NSArray * _Nonnull )value{
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
+(LKDBSQLCondition * _Nonnull )condition:(NSString * _Nonnull )name inInt:(NSArray * _Nonnull )value{
    
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


+(LKDBSQLCondition * _Nonnull )condition:(NSString * _Nonnull )name operation:(NSString * _Nonnull )operation valueString:(NSString * _Nonnull )value{
    return [LKDBSQLCondition condition:name operation:operation value:[NSString stringWithFormat:@"\'%@\'",value]];
}
+(LKDBSQLCondition * _Nonnull )condition:(NSString * _Nonnull )name operation:(NSString * _Nonnull )operation valueInt:(int64_t)value{
    return [LKDBSQLCondition condition:name operation:operation value:[NSString stringWithFormat:@"%lld",value]];
}
+(LKDBSQLCondition * _Nonnull )condition:(NSString * _Nonnull )name operation:(NSString * _Nonnull )operation valueFloat:(float)value{
    return [LKDBSQLCondition condition:name operation:operation value:[NSString stringWithFormat:@"%f",value]];
}

 

-(void)appendConditionToQuery:(LKDBQueryBuilder * _Nonnull )queryBuilder{
    [[[[queryBuilder append:name] append:operation] append:value] appendSpace];

}

-(LKDBSQLCondition * _Nonnull )separator:(NSString * _Nonnull )separator{
    separatorStr =separator;
    return self;
}
-(BOOL)hasSeparator{
    return separatorStr.length>0;
}
-(NSString * _Nonnull )separator{
    return separatorStr;
}

@end


LKDBSQLCondition*  _Nonnull LKDB_Equal_String(NSString * _Nonnull name,NSString * _Nonnull value){
    return [LKDBSQLCondition condition:name operation:LKDB_OPERATION_Equal valueString:value];
}

LKDBSQLCondition*  _Nonnull LKDB_Equal_Int(NSString * _Nonnull name,int64_t value){
    return [LKDBSQLCondition condition:name operation:LKDB_OPERATION_Equal valueInt:value];
}

LKDBSQLCondition*  _Nonnull LKDB_Equal_Float(NSString * _Nonnull name,float value){
    return [LKDBSQLCondition condition:name operation:LKDB_OPERATION_Equal valueFloat:value];
}




LKDBSQLCondition*_Nonnull LKDB_NotEqual_String(NSString *_Nonnull name,NSString * _Nonnull value){
    return [LKDBSQLCondition condition:name operation:LKDB_OPERATION_NotEqual valueString:value];
}

LKDBSQLCondition*_Nonnull LKDB_NotEqual_Int(NSString * _Nonnull name,int64_t value){
    return [LKDBSQLCondition condition:name operation:LKDB_OPERATION_NotEqual valueInt:value];
}

LKDBSQLCondition*_Nonnull LKDB_NotEqual_Float(NSString * _Nonnull name,float value){
    return [LKDBSQLCondition condition:name operation:LKDB_OPERATION_NotEqual valueFloat:value];
}



//字符串不等于

LKDBSQLCondition*_Nonnull LKDB_IsNot_String(NSString * _Nonnull name,NSString * _Nonnull value){
    return [LKDBSQLCondition condition:name operation:LKDB_OPERATION_IsNot valueString:value];
}
LKDBSQLCondition*_Nonnull LKDB_LIKE_String(NSString * _Nonnull name,NSString *value){
    return [LKDBSQLCondition condition:name operation:LKDB_OPERATION_LIKE valueString:value];
}


LKDBSQLCondition*_Nonnull LKDB_LessThan_String(NSString * _Nonnull name,NSString * _Nonnull value){
    return [LKDBSQLCondition condition:name operation:LKDB_OPERATION_LessThan valueString:value];
}
LKDBSQLCondition*_Nonnull LKDB_LessThan_Int(NSString * _Nonnull name,int64_t value){
    return [LKDBSQLCondition condition:name operation:LKDB_OPERATION_LessThan valueInt:value];
}
LKDBSQLCondition*_Nonnull LKDB_LessThan_Float(NSString * _Nonnull name,float value){
    return [LKDBSQLCondition condition:name operation:LKDB_OPERATION_LessThan valueFloat:value];
}


LKDBSQLCondition*_Nonnull LKDB_GreaterThan_String(NSString * _Nonnull name,NSString * _Nonnull value){
    return [LKDBSQLCondition condition:name operation:LKDB_OPERATION_GreaterThan valueString:value];
}
LKDBSQLCondition*_Nonnull LKDB_GreaterThan_Int(NSString * _Nonnull name,int64_t value){
    return [LKDBSQLCondition condition:name operation:LKDB_OPERATION_GreaterThan valueInt:value];
}
LKDBSQLCondition*_Nonnull LKDB_GreaterThan_Float(NSString * _Nonnull name,float value){
    return [LKDBSQLCondition condition:name operation:LKDB_OPERATION_GreaterThan valueFloat:value];
}

LKDBSQLCondition*_Nonnull LKDB_LessAndEqualThan_String(NSString * _Nonnull name,NSString * _Nonnull value){
    return [LKDBSQLCondition condition:name operation:LKDB_OPERATION_LessAndEqualThan valueString:value];
}
LKDBSQLCondition*_Nonnull LKDB_LessAndEqualThan_Int(NSString * _Nonnull name,int64_t value){
    return [LKDBSQLCondition condition:name operation:LKDB_OPERATION_LessAndEqualThan valueInt:value];
}
LKDBSQLCondition*_Nonnull LKDB_LessAndEqualThan_Float(NSString * _Nonnull name,float value){
    return [LKDBSQLCondition condition:name operation:LKDB_OPERATION_LessAndEqualThan valueFloat:value];
}


LKDBSQLCondition*_Nonnull LKDB_GreaterAndEqualThan_String(NSString * _Nonnull name,NSString * _Nonnull value){
    return [LKDBSQLCondition condition:name operation:LKDB_OPERATION_GreaterAndEqualThan valueString:value];
}
LKDBSQLCondition*_Nonnull LKDB_GreaterAndEqualThan_Int(NSString * _Nonnull name,int64_t value){
    return [LKDBSQLCondition condition:name operation:LKDB_OPERATION_GreaterAndEqualThan valueInt:value];
}
LKDBSQLCondition*_Nonnull LKDB_GreaterAndEqualThan_Float(NSString * _Nonnull name,float value){
    return [LKDBSQLCondition condition:name operation:LKDB_OPERATION_GreaterAndEqualThan valueFloat:value];
}

LKDBSQLCondition*_Nonnull LKDB_IN_String(NSString * _Nonnull name,NSArray<NSString *> * _Nonnull value){
    return [LKDBSQLCondition condition:name  inString:value];
}
LKDBSQLCondition*_Nonnull LKDB_IN_Int(NSString * _Nonnull name,NSArray<NSString *> * _Nonnull value){
    return [LKDBSQLCondition condition:name inInt:value];
}


LKDBSQLCondition*_Nonnull LKDB_Condition(NSString * _Nonnull name,NSString * _Nonnull operation,NSString * _Nonnull value){
    return [LKDBSQLCondition condition:name operation:operation value:value];
}

