 

#import "LKSQLCondition.h"

NSString* const LKDB_OP_Eq    = @"=";
NSString* const LKDB_OP_Neq   = @"<>";
NSString* const LKDB_OP_Lt    = @"<";
NSString* const LKDB_OP_Gt    = @">";
NSString* const LKDB_OP_Lte   = @"<=";
NSString* const LKDB_OP_Gte   = @">=";
NSString* const LKDB_OP_IsNot = @"IS NOT";
NSString* const LKDB_OP_LIKE  = @"LIKE";
NSString* const LKDB_OP_IN    = @"IN";

NSString* const LKDB_OP_AND   = @"AND";
NSString* const LKDB_OP_OR    = @"OR";


@interface LKSQLCondition()
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * operation;
@property (nonatomic, copy) NSString * value;
@end

@implementation LKSQLCondition

+ (LKSQLCondition *)condition:(NSString *)name operation:(NSString *)operation value:(NSString *)value{
    NSAssert(name.length != 0 && operation.length != 0, @"INVALID LKSQLCondition: colunm & operation MUST be set");
    
    LKSQLCondition * condition = [LKSQLCondition new];
    condition.name = name;
    condition.operation = operation;
    condition.value = value;
    return condition;
}

+ (LKSQLCondition *)condition:(NSString *)name inStrValues:(NSArray <NSString *> *)values{
    // treat @[], nil as VALID param
    NSMutableString *valStr = [NSMutableString string];
    // leading & traling space
    [valStr appendString:@"('"];
    [valStr appendString: [values componentsJoinedByString:@"','"] ?:@""];
    [valStr appendString:@"')"];
    
    return [LKSQLCondition condition:name operation:LKDB_OP_IN value:valStr];
}

+ (LKSQLCondition *)condition:(NSString *)name inNumValues:(NSArray <NSNumber *> *)values{
    // treat @[], nil as VALID param
    NSMutableString *valStr = [NSMutableString string];
    // leading & traling space
    [valStr appendString:@"("];
    [valStr appendString: [values componentsJoinedByString:@","] ?:@""];
    [valStr appendString:@")"];
    
    return [LKSQLCondition condition:name operation:LKDB_OP_IN value:valStr];
}

- (NSString *)toString {
    // interal space padding is necessary for some operator: 'IN' 'LIKE' 'IS NOT'
    return [NSString stringWithFormat:@"%@ %@ %@", _name, _operation, _value?:@"null"];
}

- (BOOL)hasConnector{
    return _connector.length > 0;
}

@end

