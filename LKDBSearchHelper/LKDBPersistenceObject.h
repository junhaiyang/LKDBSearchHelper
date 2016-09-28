 

#import <Foundation/Foundation.h>

@interface LKDBPersistenceObject : NSObject

@property NSInteger rowid; //数据库的主键，不用赋值，自增类型

+ (NSArray * _Nonnull)transients;  //忽略的字段
 

+ (id _Nonnull)loadByRowid:(NSInteger)_rowid;

- (id _Nonnull)reload; 

+ (NSArray * _Nonnull)listAll;

+ (int)count;

- (int)saveToDB;

- (int)updateToDB;

- (void)deleteToDB;
+ (void)dropToDB;
 
//+ (NSArray * _Nonnull)execQuery:(NSString * _Nonnull)sql;
//
//+ (NSArray * _Nonnull)execQuery:(Class _Nonnull)clazz sql:(NSString * _Nonnull)sql;
//
//+ (BOOL)execSQL:(NSString * _Nonnull)sql;
//
//- (NSArray * _Nonnull)execQuery:(NSString * _Nonnull)sql;
//
//- (NSArray * _Nonnull)execQuery:(Class _Nonnull)clazz sql:(NSString * _Nonnull)sql;
//
//- (BOOL)execSQL:(NSString * _Nonnull)sql;

@end
