

#import "LKDBSQLConstant.h"

NSString* const LKDB_OP_Eq    = @"=";
NSString* const LKDB_OP_Neq   = @"<>";
NSString* const LKDB_OP_Lt    = @"<";
NSString* const LKDB_OP_Gt    = @">";
NSString* const LKDB_OP_Lte   = @"<=";
NSString* const LKDB_OP_Gte   = @">=";

#if SQL_KEYWORD_UPPERCASE == 1
NSString* const LKDB_OP_IsNot = @"IS NOT";
NSString* const LKDB_OP_LIKE  = @"LIKE";
NSString* const LKDB_OP_IN    = @"IN";
NSString* const LKDB_OP_AND   = @"AND";
NSString* const LKDB_OP_OR    = @"OR";
#else
NSString* const LKDB_OP_IsNot = @"is not";
NSString* const LKDB_OP_LIKE  = @"like";
NSString* const LKDB_OP_IN    = @"in";
NSString* const LKDB_OP_AND   = @"and";
NSString* const LKDB_OP_OR    = @"or";
#endif

inline NSArray * _LKSQLArrayFromValist(id _Nullable firstObj,... ) {
    if (!firstObj) {
        return nil;
    }
    NSMutableArray *list = [[NSMutableArray alloc] initWithObjects:firstObj, nil];
    va_list args;
    va_start(args, firstObj);
    
    id obj;
    while((obj = va_arg(args, id)) != nil) {
        [list addObject:obj];
    }
    va_end(args);
    return [list copy];
}

/**
 *  Given a scalar or struct value, wraps it in NSValue
 *  Based on EXPObjectify: https://github.com/specta/expecta
 */
inline id _LKSQLBoxValue(const char *type, ...) {
    va_list v;
    va_start(v, type);
    id obj = nil;
    if (strcmp(type, @encode(id)) == 0) {
        id actual = va_arg(v, id);
        obj = actual;
    } else if (strcmp(type, @encode(double)) == 0) {
        double actual = (double)va_arg(v, double);
        obj = [NSNumber numberWithDouble:actual];
    } else if (strcmp(type, @encode(float)) == 0) {
        float actual = (float)va_arg(v, double);
        obj = [NSNumber numberWithFloat:actual];
    } else if (strcmp(type, @encode(int)) == 0) {
        int actual = (int)va_arg(v, int);
        obj = [NSNumber numberWithInt:actual];
    } else if (strcmp(type, @encode(long)) == 0) {
        long actual = (long)va_arg(v, long);
        obj = [NSNumber numberWithLong:actual];
    } else if (strcmp(type, @encode(long long)) == 0) {
        long long actual = (long long)va_arg(v, long long);
        obj = [NSNumber numberWithLongLong:actual];
    } else if (strcmp(type, @encode(short)) == 0) {
        short actual = (short)va_arg(v, int);
        obj = [NSNumber numberWithShort:actual];
    } else if (strcmp(type, @encode(char)) == 0) {
        char actual = (char)va_arg(v, int);
        obj = [NSNumber numberWithChar:actual];
    } else if (strcmp(type, @encode(bool)) == 0) {
        bool actual = (bool)va_arg(v, int);
        obj = [NSNumber numberWithBool:actual];
    } else if (strcmp(type, @encode(unsigned char)) == 0) {
        unsigned char actual = (unsigned char)va_arg(v, unsigned int);
        obj = [NSNumber numberWithUnsignedChar:actual];
    } else if (strcmp(type, @encode(unsigned int)) == 0) {
        unsigned int actual = (unsigned int)va_arg(v, unsigned int);
        obj = [NSNumber numberWithUnsignedInt:actual];
    } else if (strcmp(type, @encode(unsigned long)) == 0) {
        unsigned long actual = (unsigned long)va_arg(v, unsigned long);
        obj = [NSNumber numberWithUnsignedLong:actual];
    } else if (strcmp(type, @encode(unsigned long long)) == 0) {
        unsigned long long actual = (unsigned long long)va_arg(v, unsigned long long);
        obj = [NSNumber numberWithUnsignedLongLong:actual];
    } else if (strcmp(type, @encode(unsigned short)) == 0) {
        unsigned short actual = (unsigned short)va_arg(v, unsigned int);
        obj = [NSNumber numberWithUnsignedShort:actual];
    }
    va_end(v);
    return obj;
}

