 

#import "LKDBPersistenceObject.h"
#import <objc/runtime.h>
#import "LKDBSQLite.h"
#import "LKDBHelper.h"

@interface LKDBHelper(LKDBHelperQuery)

-(NSMutableArray *  _Nonnull )executeQuery:(NSString *  _Nonnull )sql toClass:(Class)modelClass;


-(NSMutableArray *  _Nonnull )executeQuery:(NSString *  _Nonnull )sql;
 

@end
@interface LKDBPersistenceObject()

+ (void)openFieldValidate;

@end
@implementation LKDBPersistenceObject

static BOOL openFieldValidate_Flag = false; 
+ (void)openFieldValidate{
    openFieldValidate_Flag =  true;
}
+(void)initialize
{
#if DEBUG
    if(openFieldValidate_Flag){
        NSArray *  _Nonnull validateError = [[self class] validateFields:[self class]];
        if (validateError != nil) {
            NSException *  _Nonnull e = [[NSException alloc] initWithName:@"class define error!" reason:[validateError componentsJoinedByString:@"\n"] userInfo:nil];
            @throw e;
        }
    }
#endif
    //remove unwant property
    for (NSString *property in [[self class] transients]) {
        [self removePropertyWithColumnName:property];
    }
    
}

+ (NSDictionary *  _Nonnull )fields:(Class)class
{
    // Recurse up the classes, but stop at NSObject. Each class only reports its own properties, not those inherited from its superclass
    NSMutableDictionary *  _Nonnull theProps;
    
    if ([class superclass] != [NSObject class])
        theProps = (NSMutableDictionary *  _Nonnull )[[self class] fields:[class superclass]];
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
+ (NSMutableArray *  _Nonnull )validateFields:(Class)class
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
//                attrs	__NSCFString *	@"T@\"NSString\",N,C,Vname"	0x00007fe32bb0ec80 
//                attrs	__NSCFString *	@"T@\"NSNumber\",N,&,Vname"	0x00007f8682f1d3a0
//                attrs	__NSCFString *	@"Tq,V_rowid"	0x00007fb5a9e0dc90
//                attrs	__NSCFString *	@"Ti,N,V_name"	0x00007fb5a9f06fa0
//                attrs	__NSCFString *	@"T@\"TestObj\",&,N,V_name"	0x00007fd5ba509680
                
                if ([attrs rangeOfString:@"\\@"].location != NSNotFound){
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


+ (NSMutableArray *  _Nonnull )validate:(LKDBPersistenceObject *  _Nonnull )object
{
    
    LKModelInfos*   _Nonnull infos = [[object class] getModelInfos];
    
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
+ (NSArray *  _Nonnull )transients{
    return nil;
}

+ (id _Nonnull)loadByRowid:(NSInteger)_rowid{
    return [[[[LKDBSQLite select:nil] from:[self class]] Where:LKDB_Equal_Int(@"rowid", _rowid)] querySingle];
}

- (id _Nonnull)reload{
    return [[[[LKDBSQLite select:nil] from:[self class]] Where:LKDB_Equal_Int(@"rowid", self.rowid)] querySingle];
}

+ (NSArray *   _Nonnull )listAll{
    return [[[LKDBSQLite select:nil] from:[self class]] queryList];
}

+ (int)count{
    return  [[[LKDBSQLite select:nil] from:[self class]] queryCount];
}

- (int)saveToDB{
    return  [LKDBSQLite insert:self];
}

- (int)updateToDB{
    return  [LKDBSQLite update:self];
}

- (void)deleteToDB{
    [LKDBSQLite delete:self];
}
+ (void)dropToDB{
    [LKDBSQLite dropTable:[self class]];
}
//+ (NSArray *  _Nonnull )execQuery:(NSString *  _Nonnull )sql{
//    return [[LKDBHelper getUsingLKDBHelper]  executeQuery:sql];
//}
//
//+ (NSArray *  _Nonnull )execQuery:(Class _Nonnull)clazz sql:(NSString *  _Nonnull )sql{
//    
//    return [[LKDBHelper getUsingLKDBHelper]  executeQuery:sql toClass:clazz];
//}
//+ (BOOL)execSQL:(NSString *  _Nonnull )sql{
//    return [[LKDBHelper getUsingLKDBHelper]  executeSQL:sql arguments:nil];
//}
//- (NSArray *  _Nonnull )execQuery:(NSString * _Nonnull)sql{
//    return [[LKDBHelper getUsingLKDBHelper]  executeQuery:sql];
//}
//
//- (NSArray *  _Nonnull )execQuery:(Class _Nonnull)clazz sql:(NSString *  _Nonnull )sql{
//    
//    return [[LKDBHelper getUsingLKDBHelper]  executeQuery:sql toClass:clazz];
//}
//- (BOOL)execSQL:(NSString *  _Nonnull )sql{
//    return [[LKDBHelper getUsingLKDBHelper]  executeSQL:sql arguments:nil];
//}
@end
