//
//  NSMutableAttributedString+EA.h
//  AshineDoctor
//
//  Created by Lipeng on 15-8-3.
//  Copyright (c) 2015年 esuizhen. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface NSMutableAttributedString(EA)
//行间距
- (void)setLineSpacing:(CGFloat)height;
//设置对其方式
- (void)setAlignment:(NSTextAlignment)alignment;
@end
