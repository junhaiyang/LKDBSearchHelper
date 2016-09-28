 

#import <Foundation/Foundation.h>
#import "LKDBPersistenceObject.h"

@interface LKDBTransaction : NSObject

-(LKDBTransaction * _Nonnull )updateAll:(NSArray<LKDBPersistenceObject *> * _Nonnull )datas;
-(LKDBTransaction * _Nonnull )insertAll:(NSArray<LKDBPersistenceObject *> * _Nonnull )datas;
-(LKDBTransaction * _Nonnull )deleteAll:(NSArray<LKDBPersistenceObject *> * _Nonnull )datas;
 
-(LKDBTransaction * _Nonnull )update:(LKDBPersistenceObject * _Nonnull )object;
-(LKDBTransaction * _Nonnull )insert:(LKDBPersistenceObject * _Nonnull )object;
-(LKDBTransaction * _Nonnull )delete:(LKDBPersistenceObject * _Nonnull )object;

-(BOOL)execute;

-(void)executeForTransaction:(BOOL (^_Nullable)(void))block;

@end
