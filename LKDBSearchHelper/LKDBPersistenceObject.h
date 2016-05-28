 

#import <Foundation/Foundation.h>
#import "LKDBHelper.h"

@interface LKDBPersistenceObject : NSObject

+ (NSArray *)transients;  //忽略的字段
 

+ (id)loadByRowid:(NSInteger)_rowid;

- (id)reload;

- (NSArray *)execQuery:(NSString *)sql;

+ (NSArray *)listAll;

+ (int)count;

- (int)save;

- (int)update;

- (void)delete;
+ (void)drop;

@end
