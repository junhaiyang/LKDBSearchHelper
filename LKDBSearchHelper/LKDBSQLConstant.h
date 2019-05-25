

#ifndef LKDBSQLConstant_h
#define LKDBSQLConstant_h

#define _SQLSelect(_arg_)   LKSQLSelect.clause.from(_arg_.class)
#define _SQLDelete(_arg_)   LKSQLDelete.clause.from(_arg_.class)
#define _SQLWhere           LKSQLCompositeCondition.clause

// workaround: LKDB requiring lowercase raw SQL
#define SQL_KEYWORD_UPPERCASE 1

#if SQL_KEYWORD_UPPERCASE == 1

#define LKSQL_SELECT   @"SELECT"
#define LKSQL_NULL     @"NULL"
#define LKSQL_DELETE   @"DELETE"
#define LKSQL_WHERE    @"WHERE"
#define LKSQL_FROM     @"FROM"
#define LKSQL_COUNT    @"COUNT"
#define LKSQL_GROUP_BY @"GROUP BY"
#define LKSQL_ORDER_BY @"ORDER BY"
#define LKSQL_LIMIT    @"LIMIT"
#define LKSQL_OFFSET   @"OFFSET"

#else

#define LKSQL_SELECT   @"select"
#define LKSQL_NULL     @"null"
#define LKSQL_DELETE   @"delete"
#define LKSQL_WHERE    @"where"
#define LKSQL_FROM     @"from"
#define LKSQL_COUNT    @"count"
#define LKSQL_GROUP_BY @"group by"
#define LKSQL_ORDER_BY @"order by"
#define LKSQL_LIMIT    @"limit"
#define LKSQL_OFFSET   @"offset"

#endif

extern NSString* const LKDB_OP_Eq;
extern NSString* const LKDB_OP_Neq;
extern NSString* const LKDB_OP_Lt;
extern NSString* const LKDB_OP_Gt;
extern NSString* const LKDB_OP_Lte;
extern NSString* const LKDB_OP_Gte;
extern NSString* const LKDB_OP_IsNot;
extern NSString* const LKDB_OP_LIKE;
extern NSString* const LKDB_OP_IN;

extern NSString* const LKDB_OP_AND;
extern NSString* const LKDB_OP_OR;



/*
 * ------------------------------------------------------------
 *                     Use with caution
 * ------------------------------------------------------------
 */

// if you really hate brakets ( may cause problem for Xcode auto-indent
#define _MatchAll(...)           matchAll(_LKSQLArrayFromValist(__VA_ARGS__, 0))
#define _MatchAny(...)           matchAny(_LKSQLArrayFromValist(__VA_ARGS__, 0))
#define _OrderBy(...)            orderBy(_LKSQLArrayFromValist(__VA_ARGS__, 0))
#define _GroupBy(...)            groupBy(_LKSQLArrayFromValist(__VA_ARGS__, 0))

// AND just for fun,
// crazy macro magic for using Xcode auto-complete ( wont work if any table mapping
#define _autocomplete(_prop_)          (((void)(NO && ((void)(@selector(_prop_)), NO)), @#_prop_))
// convenience auto-boxing macros
#define LKSQLBoxValue(value)           _LKSQLBoxValue(@encode(__typeof__((value))), (value))

#define _Eq(_prop_, _val_)             eq(_autocomplete(_prop_), LKSQLBoxValue(_val_))
#define _Neq(_prop_, _val_)            neq(_autocomplete(_prop_), LKSQLBoxValue(_val_))
#define _Lt(_prop_, _val_)             lt(_autocomplete(_prop_), LKSQLBoxValue(_val_))
#define _Lte(_prop_, _val_)            lte(_autocomplete(_prop_), LKSQLBoxValue(_val_))
#define _Gt(_prop_, _val_)             gt(_autocomplete(_prop_), LKSQLBoxValue(_val_))
#define _Gte(_prop_, _val_)            gte(_autocomplete(_prop_), LKSQLBoxValue(_val_))
#define _Like(_prop_, _val_)           like(_autocomplete(_prop_), LKSQLBoxValue(_val_))
#define _IsNot(_prop_, _val_)          isNot(_autocomplete(_prop_), LKSQLBoxValue(_val_))
#define _InStrs(_prop_, _val_)         inStrs(_autocomplete(_prop_), LKSQLBoxValue(_val_))
#define _InNums(_prop_, _val_)         inNums(_autocomplete(_prop_), LKSQLBoxValue(_val_))


extern inline NSArray * _LKSQLArrayFromValist(id _Nullable first, ...);
extern inline id _LKSQLBoxValue(const char *type, ...);


#endif /* LKDBSQLConstant_h */
