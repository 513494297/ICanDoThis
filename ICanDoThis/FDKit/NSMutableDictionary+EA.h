//
//  NSMutableDictionary+EA.h
//  AshineDoctor
//
//  Created by Lipeng on 15-8-14.
//  Copyright (c) 2015年 esuizhen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary(EA)
- (void)setEaValue:(NSString *)value forKey:(NSString *)key;
- (NSString *)jsonText;
@end
