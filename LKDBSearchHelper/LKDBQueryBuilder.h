 

#import <Foundation/Foundation.h>

@interface LKDBQueryBuilder : NSObject


-(LKDBQueryBuilder * _Nonnull)append:(NSString * _Nonnull)object;
-(LKDBQueryBuilder * _Nonnull)appendSpace;
-(LKDBQueryBuilder * _Nonnull)appendSpaceSeparated:(NSString * _Nonnull)object;
-(LKDBQueryBuilder * _Nonnull)appendParenthesisEnclosed:(NSString * _Nonnull)object;

-(LKDBQueryBuilder * _Nonnull)appendOptional:(NSString * _Nonnull)object;

-(NSString * _Nonnull)join:(NSString * _Nonnull)delimiter tokens:(NSArray * _Nonnull)tokens;


-(LKDBQueryBuilder * _Nonnull)appendArray:(NSArray * _Nonnull)objects;

-(LKDBQueryBuilder * _Nonnull)appendQualifier:(NSString * _Nonnull)name value:(NSString * _Nonnull)value;

-(LKDBQueryBuilder * _Nonnull)appendNotEmpty:(NSString * _Nonnull)object;

-(NSString * _Nonnull)toString;
-(NSString * _Nonnull)getQuery;

@end
