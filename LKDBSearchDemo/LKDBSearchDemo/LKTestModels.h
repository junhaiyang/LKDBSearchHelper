//
//  LKTestModels.h
//  LKDBHelper
//
//  Created by upin on 13-7-12.
//  Copyright (c) 2013年 ljh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LKDBHelper.h"

@class LKTest;
@interface LKTestForeign : NSObject

@property (copy,nonatomic  ) NSString                         * address;
@property (assign,nonatomic) int                              postcode;
@property (assign,nonatomic) NSInteger                        addid;

@property (strong,nonatomic) LKTest                           * nestModel;

@end


@interface LKTest : NSObject

@property (strong,nonatomic) LKTestForeign                    * nestModel;

@property (copy, nonatomic ) NSURL                            * url;
@property (copy,nonatomic  ) NSString                         * name;
@property (assign,nonatomic) NSUInteger                       age;
@property (assign,nonatomic) BOOL                             isGirl;

@property (strong,nonatomic) LKTestForeign                    * address;
@property (strong,nonatomic) NSArray                          * blah;
@property (strong,nonatomic) NSDictionary                     * hoho;

@property (assign,nonatomic) char                             like;

#ifdef __IPHONE_OS_VERSION_MIN_REQUIRED
@property (strong,nonatomic) UIImage                          * img;
@property (strong,nonatomic) UIColor                          * color;
@property (assign,nonatomic) CGRect                           frame1;
#else
@property (strong,nonatomic) NSImage                          * img;
@property (strong,nonatomic) NSColor                          * color;
@property (assign,nonatomic) NSRect                           frame1;
#endif

@property (strong,nonatomic) NSDate                           * date;

@property (copy,nonatomic  ) NSString                         * error;


@property (assign,nonatomic) CGFloat                          score;
@property (strong,nonatomic) NSData                           * data;
@property (assign,nonatomic) CGRect                           frame;
@property (assign,nonatomic) CGRect                           size;
@property (assign,nonatomic) CGPoint                          point;
@property (assign,nonatomic) NSRange                          range;
@end


@interface NSObject(PrintSQL)
+(NSString*)getCreateTableSQL;
@end
