 

#import "LKDBPersistenceObject.h"
#import <objc/runtime.h>
#import "LKDBSQLite.h"

@implementation LKDBPersistenceObject

+(void)load{
#if DEBUG
    NSArray *validateError = [[self class] validateFields:[self class]];;
    if (validateError != nil) {
        NSException *e = [[NSException alloc] initWithName:@"class define error!" reason:[validateError componentsJoinedByString:@"\n"] userInfo:nil];
        @throw e;
    }
#endif
}
+(void)initialize
{
    //remove unwant property
    for (NSString *property in [[self class] transients]) {
        [self removePropertyWithColumnName:property];
    }
    
}

+ (NSDictionary *)fields:(Class)class
{
    // Recurse up the classes, but stop at NSObject. Each class only reports its own properties, not those inherited from its superclass
    NSMutableDictionary *theProps;
    
    if ([class superclass] != [NSObject class])
        theProps = (NSMutableDictionary *)[[self class] fields:[class superclass]];
    else
        theProps = [NSMutableDictionary dictionary];
    
    unsigned int outCount;
    
    objc_property_t *propList = class_copyPropertyList(class, &outCount);
    
    // Loop through properties and add declarations for the create
    for (int i=0; i < outCount; i++)
    {
        objc_property_t oneProp = propList[i];
        
        NSString *propName = [NSString stringWithUTF8String:property_getName(oneProp)];
        NSString *attrs = [NSString stringWithUTF8String:property_getAttributes(oneProp)];
        
        
        // Read only attributes are assumed to be derived or calculated
        if ([attrs rangeOfString:@",R,"].location == NSNotFound)
        {
            NSArray *attrParts = [attrs componentsSeparatedByString:@","];
            if (attrParts != nil)
            {
                if ([attrParts count] > 0)
                {
                    NSString *propType = [[attrParts objectAtIndex:0] substringFromIndex:1];
                    [theProps setObject:propType forKey:propName];
                }
            }
        }
    }
    
    free(propList);
    
    return theProps;
}
+ (NSMutableArray *)validateFields:(Class)class
{
    // Recurse up the classes, but stop at NSObject. Each class only reports its own properties, not those inherited from its superclass
    
    objc_property_t *propList;
    
    NSMutableArray *error=[[NSMutableArray alloc] init];
    [error addObject:[[NSMutableString alloc] initWithString:@"\n===============================对象定义错误========================================="]];
    [error addObject:[@"对象:" stringByAppendingString:[NSString stringWithUTF8String:class_getName(class)]]];
    
    @try {
        NSMutableDictionary *theProps;
        if ([class superclass] != [NSObject class])
            theProps = (NSMutableDictionary *)[[self class] fields:[class superclass]];
        else
            theProps = [NSMutableDictionary dictionary];
        
        unsigned int outCount;
        
        propList = class_copyPropertyList(class, &outCount);
        
        
        // Loop through properties and add declarations for the create
        for (int i=0; i < outCount; i++)
        {
            objc_property_t oneProp = propList[i];
            
            NSString *propName = [NSString stringWithUTF8String:property_getName(oneProp)];
            NSString *attrs = [NSString stringWithUTF8String:property_getAttributes(oneProp)];
            
            // Read only attributes are assumed to be derived or calculated
            if ([attrs rangeOfString:@",R,"].location == NSNotFound)
            {
                
                if ([attrs rangeOfString:@"@"].location != NSNotFound){
                    if ([attrs rangeOfString:@"&"].location == NSNotFound){
                        NSMutableString *string=[[NSMutableString alloc] init];
                        [string appendString:@"参数 ["];
                        [string appendString:propName];
                        [string appendString:@"]: 类型错误 ,需要使用 strong 而不是 assgin"];
                        [error addObject:string];
                    }
                }else{
                    if ([attrs rangeOfString:@"&"].location != NSNotFound){
                        NSMutableString *string=[[NSMutableString alloc] init];
                        [string appendString:@"参数 ["];
                        [string appendString:propName];
                        [string appendString:@"]: 类型错误 ,需要使用 assgin 而不是 strong"];
                        [error addObject:string];
                    }
                    
                }
                
                
            }
        }
        
    }
    @catch (NSException *exception) {
        [error addObject:[[exception callStackSymbols] componentsJoinedByString:@"\n"]];
    }@finally {
        if(propList)
            free(propList);
    }
    [error addObject:[[NSMutableString alloc] initWithString:@"\n========================================================================"]];
    if(error.count>3)
        return error;
    else {
        return nil;
    }
}


+ (NSMutableArray *)validate:(LKDBPersistenceObject *)object
{
    
    LKModelInfos* infos = [[object class] getModelInfos];
    
    NSMutableArray *error=[[NSMutableArray alloc] init];
    [error addObject:[[NSMutableString alloc] initWithString:@"\n===============================数据与对象不匹配========================================="]];
    [error addObject:[[@"表名:" stringByAppendingString:[[object class] getTableName]] stringByAppendingString:@"\n\n"]];
    
    @try {
        for(int i=0;i<infos.count;i++){
            LKDBProperty *property =[infos objectWithIndex:i];
            
            NSString *propType = property.propertyType;
            NSString *propertyName = property.propertyName;
            
            id value = [object valueForKey:propertyName];
            
            
            if([value isKindOfClass:[NSNull class]]||value==nil)
                continue;
            
            if([propType isEqualToString:@"NSString"])
            {
                if([value isKindOfClass:[NSString class]])
                    continue;
            }else if([propType isEqualToString:@"NSData"])
            {
                if([value isKindOfClass:[NSData class]])
                    continue;
            }else if([propType isEqualToString:@"NSDate"])
            {
                if([value isKindOfClass:[NSDate class]])
                    continue;
            }else if([propType isEqualToString:@"NSNumber"])
            {
                if([value isKindOfClass:[NSNumber class]])
                    continue;
            }else
            {
                continue;
            }
            
            NSString *valueClassName=[NSString stringWithUTF8String:class_getName([value class])];
            
            NSMutableString *string=[[NSMutableString alloc] init];
            [string appendString:@"错误参数 ["];
            [string appendString:propertyName];
            [string appendString:@"]: 对象中错误的数据类型 "];
            [string appendString:@"["];
            [string appendString:valueClassName];
            [string appendString:@"], 实际需要的数据类型为实现或继承 "];
            [string appendString:@"["];
            [string appendString:propType];
            [string appendString:@"] Class的对象!"];
            [error addObject:string];
            
            
        }
    }
    @catch (NSException *exception) {
        [error addObject:[[exception callStackSymbols] componentsJoinedByString:@"\n"]];
    }
    [error addObject:[[NSMutableString alloc] initWithString:@"\n========================================================================"]];
    if(error.count>3)
        return error;
    else {
        return nil;
    }
}
+ (NSArray *)transients{
    return nil;
}

+ (id)loadByRowid:(NSInteger)_rowid{
    return [[[[LKDBSQLite select] from:[self class]] where:LKDB_Equal_Int(@"rowid", _rowid)] querySingle];
}

- (id)reload{
    return [[[[LKDBSQLite select] from:[self class]] where:LKDB_Equal_Int(@"rowid", self.rowid)] querySingle];
}

+ (NSArray *)listAll{
    return [[[LKDBSQLite select] from:[self class]] queryList];
}

+ (int)count{
    return  [[[LKDBSQLite select] from:[self class]] queryCount];
}

- (int)save{
    return  [LKDBSQLite insert:self];
}

- (int)update{
    return  [LKDBSQLite update:self];
}

- (void)delete{
    [LKDBSQLite delete:self];
}
- (void)drop{
    [LKDBSQLite dropTable:[self class]];
}
@end
