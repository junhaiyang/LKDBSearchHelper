 

#import "LKDBQueryBuilder.h"

@interface LKDBQueryBuilder(){

    BOOL isChanged;
    
    NSMutableString *  _Nonnull query;
}

@end

@implementation LKDBQueryBuilder
- (instancetype)init
{
    self = [super init];
    if (self) {
        query = [NSMutableString new];
    }
    return self;
}

-(LKDBQueryBuilder *  _Nonnull )append:(NSString *  _Nonnull )object{
    [query appendString:object];
    return self;
}
-(LKDBQueryBuilder *  _Nonnull )appendSpace{
    [self append:@" "];
    return self;
}
-(LKDBQueryBuilder *  _Nonnull )appendSpaceSeparated:(NSString *  _Nonnull )object{
    [[self append:object] appendSpace];
    return self;
}
-(LKDBQueryBuilder *  _Nonnull )appendParenthesisEnclosed:(NSString *  _Nonnull )object{
    [[[self append:@"("] append:object] append:@")"];
    return self;
}

-(LKDBQueryBuilder *  _Nonnull )appendOptional:(NSString *  _Nonnull )object{
    if(object)
        [self append:object];
    return self;
}

-(NSString *  _Nonnull )join:(NSString *  _Nonnull )delimiter tokens:(NSArray *  _Nonnull )tokens{
    
    NSMutableString *sb =[NSMutableString new];
    BOOL firstTime = true;
    for (NSString *token in  tokens) {
        if (firstTime) {
            firstTime = false;
        } else {
            [sb appendString:delimiter];
        }
        [sb appendString:token];
    }
    return sb;
}


-(LKDBQueryBuilder *  _Nonnull )appendArray:(NSArray *  _Nonnull )objects{
    return [self append:[self join:@", " tokens:objects]];
}

-(LKDBQueryBuilder *  _Nonnull )appendQualifier:(NSString *  _Nonnull )name value:(NSString *  _Nonnull )value{
    if(value.length>0){
        if(name){
            [self append:name];
        }
        [self appendSpaceSeparated:value];
    }
    
    return self;
}

-(LKDBQueryBuilder *  _Nonnull )appendNotEmpty:(NSString *  _Nonnull )object{
    if(object.length>0)
        [self append:object];
    return self;
}

-(NSString *  _Nonnull )toString{
    return [self getQuery];
}
-(NSString *  _Nonnull )getQuery{
    return query;
}


@end
