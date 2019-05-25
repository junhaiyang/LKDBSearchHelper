//
//  FMDatabase+Debug.m
//  iOS-Demo
//
//  Created by wving5 on 2019/5/18.
//  Copyright © 2019年 Mars. All rights reserved.
//

#import "FMDatabase+Debug.h"
#import <objc/runtime.h>

#if ENABLE_FMDB_SQL_TRACE_EXEC == 1
@interface NSString (SQLQueryDebugging)
- (NSString *)stringBySubstitutingParameters:(NSArray *)params forInstancesOfPlaceholder:(NSString *)placeholder;
@end

@implementation NSString (SQLQueryDebugging)

- (NSString *)stringBySubstitutingParameters:(NSArray *)params forInstancesOfPlaceholder:(NSString *)placeholder
{
    NSString *composedQuery = self;
    NSRange substitutionRange = [composedQuery rangeOfString:placeholder];
    NSInteger parameterIndex = 0;
    while(substitutionRange.length != 0)
    {
        NSString *currentParam = [[self safe_objectAtIndex:parameterIndex forArray:params] description];
        composedQuery = [composedQuery stringByReplacingCharactersInRange:substitutionRange withString:currentParam];
        ++parameterIndex;
        NSInteger lastSubstitutionIndex = substitutionRange.location + [currentParam length];
        NSRange searchRange = NSMakeRange(lastSubstitutionIndex, [composedQuery length] - lastSubstitutionIndex);
        substitutionRange = [composedQuery rangeOfString:placeholder options:0 range:searchRange];
    }
    
    return composedQuery;
}

- (id)safe_objectAtIndex:(NSUInteger)index forArray:(NSArray *)array {
    if (array.count >= index + 1) {
        return [array objectAtIndex:index];
    } else {
        return @"[null_safe]";
    }
}
@end

@interface FMDatabase (SQLQueryDebugging)

// copy definition
- (FMResultSet * _Nullable)executeQuery:(NSString *)sql withArgumentsInArray:(NSArray * _Nullable)arrayArgs orDictionary:(NSDictionary * _Nullable)dictionaryArgs orVAList:(va_list)args;
- (BOOL)executeUpdate:(NSString *)sql error:(NSError * _Nullable *)outErr withArgumentsInArray:(NSArray * _Nullable)arrayArgs orDictionary:(NSDictionary * _Nullable)dictionaryArgs orVAList:(va_list)args;

@end

@implementation FMDatabase (SQLQueryDebugging)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class class = [self class];

        [self replaceInstanceImplOfSelector:@selector(executeQuery:withArgumentsInArray:orDictionary:orVAList:)
                            onClass:class
                   swizzledSelector:@selector(dbg_executeQuery:withArgumentsInArray:orDictionary:orVAList:)];
        
        [self replaceInstanceImplOfSelector:@selector(executeUpdate:error:withArgumentsInArray:orDictionary:orVAList:)
                            onClass:class
                   swizzledSelector:@selector(dbg_executeUpdate:error:withArgumentsInArray:orDictionary:orVAList:)];
    });
    
}

+ (void)replaceInstanceImplOfSelector:(SEL)originalSelector onClass:(Class)class swizzledSelector:(SEL)swizzledSelector
{
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (success) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

- (NSArray *)arrayFromVAList:(va_list)args count:(NSUInteger)count
{
    NSMutableArray *tmplist = @[].mutableCopy;
    if (args) {
        va_list vl_count;
        va_copy(vl_count,args);
        int idx = 0;
        id obj;
        while (idx < count) {
            obj = va_arg(vl_count, id);
            [tmplist addObject:obj];
            idx++;
        }
        va_end(vl_count);
    }
    return [tmplist copy];
}

- (void)printSql:(NSString *)sql params:(NSArray *)params prefixed:(NSString *)prefix {
    
    NSString *completeSQL = [sql stringBySubstitutingParameters:params forInstancesOfPlaceholder:@"?"];
//    printf("\n\n##[%s] --> '%s'\n\n", prefix.UTF8String, completeSQL.UTF8String);
    NSLog(@"\n\n##[%@] --> '%@'\n\n.", prefix,completeSQL);
}

// ignore dictionaryArgs for simple
- (FMResultSet *)dbg_executeQuery:(NSString *)sql withArgumentsInArray:(NSArray *)arrayArgs orDictionary:(NSDictionary *)dictionaryArgs orVAList:(va_list)args
{
    NSArray *params = arrayArgs;
    if (!params) {
        // count '?' for reading args
        int queryCount = (int)[sql componentsSeparatedByString:@"?"].count - 1;
        params = [self arrayFromVAList:args count:queryCount];
    }
    [self printSql:sql params:params prefixed:@"SQL Query"];
    
    return [self dbg_executeQuery:sql withArgumentsInArray:arrayArgs orDictionary:dictionaryArgs orVAList:args];
}

- (BOOL)dbg_executeUpdate:(NSString *)sql error:(NSError *__autoreleasing  _Nullable *)outErr withArgumentsInArray:(NSArray *)arrayArgs orDictionary:(NSDictionary *)dictionaryArgs orVAList:(va_list)args
{
    NSArray *params = arrayArgs;
    if (!params) {
        int queryCount = (int)[sql componentsSeparatedByString:@"?"].count - 1;
        params = [self arrayFromVAList:args count:queryCount];
    }
    [self printSql:sql params:params prefixed:@"SQL Update"];
    
    return [self dbg_executeUpdate:sql error:outErr withArgumentsInArray:arrayArgs orDictionary:dictionaryArgs orVAList:args];
}


@end
#endif
