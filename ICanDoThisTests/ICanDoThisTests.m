//
//  ICanDoThisTests.m
//  ICanDoThisTests
//
//  Created by THF on 16/8/16.
//  Copyright © 2016年 thf. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TestModel.h"
@interface ICanDoThisTests : XCTestCase

@end

@implementation ICanDoThisTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.

        TestModel * model = [[TestModel alloc] init];
        NSInteger num = [model randomLessThanTen];
        XCTAssert(num<10,@"num should less than 10");
    
}

-(void)testModelFunc_randomLessThanTen{
    TestModel * model = [[TestModel alloc] init];
    NSInteger num = [model randomLessThanTen];
    XCTAssert(num<10,@"num should less than 10");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
