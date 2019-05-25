

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
