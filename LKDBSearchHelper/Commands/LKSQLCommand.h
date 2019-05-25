

#import <Foundation/Foundation.h>

@class LKSQLCondition, LKDBHelper;

/* CRUD Base Class */

@interface LKSQLCommand : NSObject

+ (instancetype)clause;
- (LKSQLCommand *(^)(Class tblClass))from;
- (LKSQLCommand *(^)(LKSQLCondition *sqlCondition))where;
- (LKSQLCommand *(^)(id orderBy))orderBy; // `NSString` or `NSArray<NSString *>`
- (LKSQLCommand *(^)(id groupBy))groupBy; // `NSString` or `NSArray<NSString *>`
- (LKSQLCommand *(^)(NSInteger limit))limit;
- (LKSQLCommand *(^)(NSInteger offset))offset;

/* SQL translate */
- ( NSString *)toString; // @abstract

/* LKDB wrapper */
- (id (^)())exec; // @abstract
- (id (^)(LKDBHelper *))execIn; // @abstract



/* accessor for Subclasses */
@property (nonatomic, readonly, assign) NSInteger mLimit;
@property (nonatomic, readonly, assign) NSInteger mOffset;
@property (nonatomic, readonly, assign) BOOL countOnly;
@property (nonatomic, readonly, strong) Class tblClass;
@property (nonatomic, readonly, strong) LKSQLCondition* conditionGroup;
@property (nonatomic, readonly, copy)   NSArray* orderByList;
@property (nonatomic, readonly, copy)   NSArray* groupByList;

@end
