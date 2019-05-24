 

#import "LKDBStringBuilder.h"

@interface LKDBStringBuilder(){
    NSMutableString * _string;
}
@end

@implementation LKDBStringBuilder
- (instancetype)init
{
    if (self = [super init]) {
        _string = [NSMutableString string];
    }
    return self;
}

- (LKDBStringBuilder * )append:(NSString * )object{
    [_string appendString:object];
    return self;
}

- (LKDBStringBuilder * )appendSpace{
    [_string appendString:@" "];
    return self;
}

- (NSString * )toString{
    return _string;
}

@end
