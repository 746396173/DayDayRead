//
//  DynamicColumnDetailViewController.m
//  项目
//
//  Created by lanou3g on 16/6/29.
//  Copyright © 2016年 张明杰. All rights reserved.
//

#import "DynamicColumnDetailViewController.h"
#import "DynamicCell.h"
#import <UIImageView+WebCache.h>

@interface DynamicColumnDetailViewController ()


@property (weak, nonatomic) IBOutlet UIImageView *nickNameImageView;
@property (weak, nonatomic) IBOutlet UILabel *NickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeght;


@end

@implementation DynamicColumnDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"综合讨论区";
    [self initLayout];
    [self initView];
}
- (void)initView{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemClicked)];

}
- (void)leftBarButtonItemClicked {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)initLayout {
    
    
    NSString *imageStr = [_dynamic.from objectForKey:@"avatar"];
    NSString *urlStr= @"http://statics.zhuishushenqi.com/";
    NSString *imageViewStr = [NSString stringWithFormat:@"%@%@",urlStr,imageStr];
    
    [self.nickNameImageView sd_setImageWithURL:[NSURL URLWithString:imageViewStr]];
    NSString *nickname = [_dynamic.from objectForKey:@"nickname"];
    NSString *lv = [_dynamic.from objectForKey:@"lv"];
    self.NickNameLabel.text = [NSString stringWithFormat:@"%@%@%@",nickname,@" Lv.",lv];
    //        NSDictionary *tweet = [NSDictionary dictionary];
    NSString *title = [_dynamic.refTweet objectForKey:@"title"];
    self.titleLabel.text = title;
    NSString *content = [_dynamic.refTweet objectForKey:@"content"];
    self.contentLabel.text = content;
    //
    NSString *timeStr = [_dynamic.refTweet  objectForKey:@"created"];
    
    
    NSString *timeStr1 = [timeStr substringToIndex:10];
    self.timeLabel.text =timeStr1;

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end