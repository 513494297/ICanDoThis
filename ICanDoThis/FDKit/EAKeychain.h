//
//  EAKeychain.h
//  AshineDoctor
//
//  Created by Lipeng on 15/9/4.
//  Copyright (c) 2015年 esuizhen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EAKeychain : NSObject
//
- (id)load:(NSString *)service;
//
- (void)save:(NSString *)service data:(id)data;
//
- (void)delete:(NSString *)service;
@end
