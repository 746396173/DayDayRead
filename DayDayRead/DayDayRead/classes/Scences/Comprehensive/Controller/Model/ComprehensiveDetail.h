//
//  ComprehensiveDetail.h
//  DayDayRead
//
//  Created by lanou3g on 16/6/30.
//  Copyright © 2016年 王志准. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ComprehensiveDetail : NSObject

@property (nonatomic, strong)NSString *_id;

@property (nonatomic, strong)NSDictionary *author;
@property (nonatomic, strong)NSDictionary *replyTo;
@property (nonatomic, strong)NSString *floor;

@property (nonatomic, strong)NSString *created;
@property (nonatomic, strong)NSString *content;



@end
