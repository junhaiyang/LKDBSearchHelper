//
//  LKDBQueryBuilder.h
//  wkt_app_ios
//
//  Created by junhai on 16/5/28.
//  Copyright © 2016年 junhai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LKDBQueryBuilder : NSObject


-(LKDBQueryBuilder *)append:(NSString *)object;
-(LKDBQueryBuilder *)appendSpace;
-(LKDBQueryBuilder *)appendSpaceSeparated:(NSString *)object;
-(LKDBQueryBuilder *)appendParenthesisEnclosed:(NSString *)object;

-(LKDBQueryBuilder *)appendOptional:(NSString *)object;

-(NSString *)join:(NSString *)delimiter tokens:(NSArray *)tokens;


-(LKDBQueryBuilder *)appendArray:(NSArray *)objects;

-(LKDBQueryBuilder *)appendQualifier:(NSString *)name value:(NSString *)value;

-(LKDBQueryBuilder *)appendNotEmpty:(NSString *)object;

-(NSString *)toString;
-(NSString *)getQuery;

@end
