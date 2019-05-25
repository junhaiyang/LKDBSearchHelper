 

#import <Foundation/Foundation.h>

/* String builder */

@interface LKDBStringBuilder : NSObject

- (LKDBStringBuilder *)append:(NSString *)object;
- (LKDBStringBuilder *)appendSpace;

- (NSString *)toString;

@end
