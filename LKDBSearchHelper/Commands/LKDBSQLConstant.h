

#ifndef LKDBSQLConstant_h
#define LKDBSQLConstant_h

// workaround: LKDB requiring lowercase raw SQL 
#define SQL_KEYWORD_UPPERCASE 0


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



#endif /* LKDBSQLConstant_h */
