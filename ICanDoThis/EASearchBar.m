//
//  EASearchBar.m
//  AshineDoctor
//
//  Created by Lipeng on 15-7-25.
//  Copyright (c) 2015年 esuizhen. All rights reserved.
//

#import "EASearchBar.h"


const static CGFloat cancel_width = 42;

@interface EASearchBar()<UITextFieldDelegate>{
    //文本输入的偏移量
    CGFloat dx;
    BOOL isDragging;
    BOOL isDecelerating;
}
@property(nonatomic, strong) NSTimer *timer;
@property(nonatomic, weak) UITableView *tableView;
@property(nonatomic) UIView *backgroundView;
@end

@implementation EASearchBar

- (void)dealloc
{
    self.start_block = nil;
    self.cancel_block = nil;
    self.invoke_block = nil;
    self.focus_block = nil;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = hf_color(238,239,242,1);
        CGSize size = frame.size;
        _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0,0, size.width+cancel_width, size.height)];
        [self addSubview:_backgroundView];
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectInset(self.bounds, 7.f, 7.f)];
        btn.backgroundColor =  hf_color(255,255,255,1);
        btn.layer.cornerRadius = 3;
        [btn addTarget:self action:@selector(onSearch:) forControlEvents:UIControlEventTouchUpInside];
        btn.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [_backgroundView addSubview:btn];
        //
        _textField = [self makeTextField:CGRectInset(self.bounds, 7.f, 7.f)];
        [self setTextFiled:_textField :@"搜索" :NSTextAlignmentLeft :hf_font(16) :hf_color(51,51,51,1)
                                :UIKeyboardTypeDefault :UIReturnKeySearch];
        _textField.enabled = NO;
        _textField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _textField.delegate = self;
        [_backgroundView addSubview:_textField];
        
        
        
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,CGViewGetHeight(_textField), CGViewGetHeight(_textField))];
        iv.image = [UIImage imageNamed:@"btn_search_gray"];
        iv.contentMode = UIViewContentModeCenter;
        _textField.leftViewMode = UITextFieldViewModeAlways;
        _textField.leftView = iv;
        
        btn = [[UIButton alloc] initWithFrame:CGRectMake(size.width,0,cancel_width,size.height)];
        [self setButton:btn :@"取消" :hf_font(16) :hf_color(46,169,226,1) :UIControlStateNormal];
        [btn addTarget:self action:@selector(onCancel:) forControlEvents:UIControlEventTouchUpInside];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        btn.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        [_backgroundView addSubview:btn];
        
        [self drawLineAsLayer:CGRectMake(0,-(1.f/[UIScreen mainScreen].scale),size.width, (1.f/[UIScreen mainScreen].scale))
                              color:hf_color(219,219,219,1)];
        
        //计算输入框的位置
        CGFloat width = CGViewGetWidth(_textField.leftView) + [_textField.placeholder eaSizeWithFont:_textField.font].width;
        dx = (size.width-width)/2;
        _textField.transform = CGAffineTransformMakeTranslation(dx, 0);
    }
    return self;
}

- (void)imDie
{
    _timer = nil;
    [_tableView removeObserver:self forKeyPath:@"contentOffset"];
}
//点击搜索
- (void)onSearch:(UIButton *)button
{
    self.clipsToBounds = NO;
    _textField.placeholder = @"请输入患者、诊断或手机号";
    _start_block();
}
//取消
- (void)onCancel:(UIButton *)button
{
    self.clipsToBounds = YES;
    _textField.placeholder = @"搜索";
    _cancel_block();
}
//开始
- (void)invoke
{
    _textField.enabled = YES;
    _textField.transform = CGAffineTransformIdentity;
    CGRect frame = _backgroundView.frame;
    frame.size.width = CGViewGetWidth(self);
    _backgroundView.frame = frame;
    [_textField becomeFirstResponder];
}
//取消
- (void)sleep
{
    _textField.enabled = NO;
    _textField.transform = CGAffineTransformMakeTranslation(dx, 0);
    _textField.text = nil;
    _textField.placeholder = @"搜索";    
    CGRect frame = _backgroundView.frame;
    frame.size.width = CGViewGetWidth(self) + cancel_width;
    _backgroundView.frame = frame;
    [_textField resignFirstResponder];
}

//隐藏键盘
- (void)hideKeyboard
{
    [_textField resignFirstResponder];
}

- (void)changeText:(NSString *)text
{
    _textField.text = text;
}

- (void)attachWithTableView:(UITableView *)tableView
{
    [tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:NULL];
    _tableView = tableView;
    _timer = [NSTimer scheduledTimerWithTimeInterval:.1f
                                              target:self
                                            selector:@selector(onTimer:)
                                            userInfo:nil
                                             repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)hideWithAnimated:(BOOL)animated
{
    CGFloat height = CGRectGetHeight(self.bounds);
    CGAffineTransform trans = self.transform;
    if (ceil(trans.ty) > -height){
        if (animated){
            while (ceil(trans.ty) > -height) {
                [UIView animateWithDuration:.1 animations:^{
                    _tableView.contentOffset = CGPointMake(0, 1);
                }];
                trans = self.transform;
            }
        } else {
            CGFloat dy = height - ceil(fabs(trans.ty));
            self.transform = CGAffineTransformMakeTranslation(0, -height);
            CGRect frame = _tableView.frame;
            frame.origin.y -= dy;
            frame.size.height += dy;
            _tableView.frame = frame;
        }
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    UITableView *tableView = (UITableView *)object;
    CGFloat oy = tableView.contentOffset.y;
    CGAffineTransform trans = self.transform;
    if (ceilf(oy) > 0 && ceilf(trans.ty) > -CGRectGetHeight(self.bounds)){
        [tableView removeObserver:self forKeyPath:@"contentOffset"];
        tableView.contentOffset = CGPointZero;
        [tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:NULL];
        CGFloat y = ceilf(CGRectGetMinY(tableView.frame) - oy);
        if (y < 0){
            y = 0;
        }
        oy = ceilf(CGRectGetMinY(tableView.frame) - y);
        self.transform = CGAffineTransformMakeTranslation(0, -oy+ceilf(trans.ty));
        CGRect frame = tableView.frame;
        frame.origin.y = y;
        frame.size.height = CGRectGetHeight(tableView.frame) + oy;
        tableView.frame = frame;
    } else if (ceilf(oy) < 0 && ceilf(trans.ty) < 0){
        [tableView removeObserver:self forKeyPath:@"contentOffset"];
        tableView.contentOffset = CGPointZero;
        [tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:NULL];
        oy = -oy;
        CGFloat y = ceilf(CGRectGetMinY(tableView.frame) + oy);
        if (y > CGRectGetHeight(self.bounds)){
            y = CGRectGetHeight(self.bounds);
        }
        oy = y - ceilf(CGRectGetMinY(tableView.frame));
        self.transform = CGAffineTransformMakeTranslation(0, oy+ceilf(trans.ty));
        CGRect frame = tableView.frame;
        frame.origin.y = y;
        frame.size.height = CGRectGetHeight(tableView.frame) - oy;
        tableView.frame = frame;
    }
}

- (void)onTimer:(NSTimer *)timer
{
    if ((!_tableView.isDragging && isDragging && !_tableView.isDecelerating) || (!_tableView.isDecelerating && isDecelerating)){
        CGFloat height = CGRectGetHeight(self.bounds);
        CGAffineTransform trans = self.transform;
        //需要调整
        if (ceilf(trans.ty) < 0 && ceilf(trans.ty) > -height/2){
            while (ceilf(trans.ty) < 0) {
                [UIView animateWithDuration:.1 animations:^{
                    _tableView.contentOffset = CGPointMake(0, -1);
                }];

                trans = self.transform;
            }
        } else if (ceilf(trans.ty) <= -height/2 && ceilf(trans.ty) > -height){
            while (ceilf(trans.ty) > -height) {
                [UIView animateWithDuration:.1 animations:^{
                    _tableView.contentOffset = CGPointMake(0, 1);
                }];
                trans = self.transform;
            }
        }
    }
    isDragging = _tableView.isDragging;
    isDecelerating = _tableView.isDecelerating;
}

#pragma mark
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    _focus_block();
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.text.length > 0){
        _invoke_block(textField.text);
        [_textField resignFirstResponder];
    }
    return YES;
}

+ (CGFloat)height
{
    return 44.f;
}





- (void)setButton:(UIButton *)button
                 :(NSString *)title
                 :(UIFont *)font
                 :(UIColor *)titleColor
                 :(UIControlState)state
{
    button.titleLabel.font = font;
    [button setTitle:title forState:state];
    [button setTitleColor:titleColor forState:state];
}


- (UITextField *)makeTextField:(CGRect)frame
{
    UITextField *tf = [[UITextField alloc] initWithFrame:frame];
    tf.backgroundColor = [UIColor clearColor];
    tf.clearButtonMode = UITextFieldViewModeWhileEditing;
    tf.leftViewMode    = UITextFieldViewModeAlways;
    return tf;
}

- (void)setTextFiled:(UITextField *)textField
                    :(NSString *)placeHolder
                    :(NSTextAlignment)align
                    :(UIFont *)font
                    :(UIColor *)color
                    :(UIKeyboardType)keyboardType
                    :(UIReturnKeyType)returnkeyType
{
    textField.textAlignment = align;
    textField.font = font;
    textField.textColor = color;
    textField.placeholder = placeHolder;
    textField.keyboardType = keyboardType;
    textField.returnKeyType = returnkeyType;
}

- (CALayer *)drawLineAsLayer:(CGRect)frame color:(UIColor *)color
{
    CALayer *layer = [CALayer layer];
    layer.frame = frame;
    layer.backgroundColor = color.CGColor;
    [self.layer addSublayer:layer];
    return layer;
}


@end
