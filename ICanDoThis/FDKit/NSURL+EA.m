//
//  NSURL+EA.m
//  AshineDoctor
//
//  Created by Lipeng on 15-8-20.
//  Copyright (c) 2015年 esuizhen. All rights reserved.
//

#import "NSURL+EA.h"

@implementation NSURL(EA)
- (NSURL *)thumbURL
{
    NSMutableString *url = [NSMutableString stringWithString:self.absoluteString];
    NSArray *a = [url componentsSeparatedByString:@"."];
    if (a.count > 0) {
        [url appendFormat:@"_200.%@", a[a.count-1]];
    }
    return [NSURL URLWithString:url];
}
@end
