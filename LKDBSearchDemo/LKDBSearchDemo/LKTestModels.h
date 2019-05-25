//
//  LKTestModels.h
//  LKDBHelper
//
//  Created by upin on 13-7-12.
//  Copyright (c) 2013年 ljh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LKDBHelper.h"

@interface LKTest : NSObject


@property (copy, nonatomic ) NSURL                            * url;
@property (copy,nonatomic  ) NSString                         * name;
@property (assign,nonatomic) NSUInteger                       age;
@property (assign,nonatomic) BOOL                             isGirl;
@property (assign,nonatomic) char                             like;
@property (copy,nonatomic  ) NSString                         * error;

@property (strong,nonatomic) NSArray                          * blah;
@property (strong,nonatomic) NSDictionary                     * hoho;

@property (strong,nonatomic) NSDate                           * date;
@property (strong,nonatomic) UIImage                          * img;
@property (strong,nonatomic) UIColor                          * color;
@property (assign,nonatomic) CGFloat                          score;
@property (strong,nonatomic) NSData                           * data;
@property (assign,nonatomic) CGRect                           frame;
@property (assign,nonatomic) CGRect                           size;
@property (assign,nonatomic) CGPoint                          point;
@property (assign,nonatomic) NSRange                          range;
@end
