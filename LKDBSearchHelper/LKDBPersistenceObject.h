 

#import <Foundation/Foundation.h>

@interface LKDBPersistenceObject : NSObject

@property NSInteger rowid; //数据库的主键，不用赋值，自增类型

+ (NSArray *)transients;  //忽略的字段
 

+ (id)loadByRowid:(NSInteger)_rowid;

- (id)reload; 

+ (NSArray *)listAll;

+ (int)count;

- (int)saveToDB;

- (int)updateToDB;

- (void)deleteToDB;
+ (void)dropToDB;

@end
