 

#import <Foundation/Foundation.h>

@interface LKDBPersistenceObject : NSObject

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
