 

#import "LKDBTransaction.h"
#import "LKDBHelper.h"


typedef enum {
    LKDBPersistenceObjectActionInsert = 0,
    LKDBPersistenceObjectActionUpdate   = 1,
    LKDBPersistenceObjectActionRemove = 2,
} LKDBPersistenceObjectAction;


@interface LKDBTransactionData : NSObject

@property (nonatomic,strong) LKDBPersistenceObject * _Nonnull object;

@property (nonatomic,assign) LKDBPersistenceObjectAction action;

+(LKDBTransactionData * _Nonnull )init:(LKDBPersistenceObject * _Nonnull )object action:(LKDBPersistenceObjectAction)action;

@end

@implementation LKDBTransactionData

+(LKDBTransactionData * _Nonnull )init:(LKDBPersistenceObject * _Nonnull )object action:(LKDBPersistenceObjectAction)action{
    LKDBTransactionData * _Nonnull data = [LKDBTransactionData new];
    data.object = object;
    data.action = action;
    return data;
}

@end


@interface LKDBTransaction(){
    
    NSMutableArray * _Nonnull actionDatas;

}

@end

@implementation LKDBTransaction
- (instancetype)init
{
    self = [super init];
    if (self) {
        actionDatas =[[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}
-(LKDBTransaction * _Nonnull )updateAll:(NSArray<LKDBPersistenceObject *> * _Nonnull )datas{
    for (LKDBPersistenceObject *object in datas) {
        
        LKDBTransactionData * _Nonnull data =[LKDBTransactionData init:object action:LKDBPersistenceObjectActionUpdate];
        
        [actionDatas addObject:data];
    }
    
    
    return self;
}
-(LKDBTransaction * _Nonnull )insertAll:(NSArray<LKDBPersistenceObject *> * _Nonnull )datas{
    for (LKDBPersistenceObject *object in datas) {
        
        LKDBTransactionData * _Nonnull data =[LKDBTransactionData init:object action:LKDBPersistenceObjectActionInsert];
        
        [actionDatas addObject:data];
    }
    return self;
}
-(LKDBTransaction * _Nonnull )deleteAll:(NSArray<LKDBPersistenceObject *> * _Nonnull )datas{
    for (LKDBPersistenceObject *object in datas) {
        
        LKDBTransactionData * _Nonnull data =[LKDBTransactionData init:object action:LKDBPersistenceObjectActionRemove];
        
        [actionDatas addObject:data];
    }
    return self;
}


-(LKDBTransaction * _Nonnull )update:(LKDBPersistenceObject * _Nonnull )object{
    
    
    LKDBTransactionData * _Nonnull data =[LKDBTransactionData init:object action:LKDBPersistenceObjectActionUpdate];
    
    [actionDatas addObject:data];
    return self;
}
-(LKDBTransaction * _Nonnull )insert:(LKDBPersistenceObject * _Nonnull )object{
    
    LKDBTransactionData * _Nonnull data =[LKDBTransactionData init:object action:LKDBPersistenceObjectActionInsert];
    
    [actionDatas addObject:data];
    return self;
}
-(LKDBTransaction * _Nonnull )delete:(LKDBPersistenceObject * _Nonnull )object{
    
    LKDBTransactionData * _Nonnull data =[LKDBTransactionData init:object action:LKDBPersistenceObjectActionRemove];
    
    [actionDatas addObject:data];
    return self;
}

-(BOOL)execute{
    [[LKDBHelper getUsingLKDBHelper] executeForTransaction:^BOOL(LKDBHelper *helper) {
        @try {
            for (LKDBTransactionData * _Nonnull object in actionDatas) {
                
                if(object.action==LKDBPersistenceObjectActionInsert)
                    [object.object saveToDB];
                
                if(object.action==LKDBPersistenceObjectActionUpdate)
                    [object.object updateToDB];
                
                if(object.action==LKDBPersistenceObjectActionRemove)
                    [object.object deleteToDB];
            }
             
            return true;
        } @catch (NSException *exception) {
             return false;
        }
    }];
}
- (void)executeForTransaction:(BOOL (^_Nullable)(void))block{
    [[LKDBHelper getUsingLKDBHelper] executeForTransaction:^BOOL(LKDBHelper *helper) {
        return block();
    }];
}


@end
