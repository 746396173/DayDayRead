//
//  DynamicHotDetailViewController.m
//  项目
//
//  Created by lanou3g on 16/6/29.
//  Copyright © 2016年 张明杰. All rights reserved.
//

#import "DynamicHotDetailViewController.h"
#import "DynamicCell.h"
#import <UIImageView+WebCache.h>


@interface DynamicHotDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *nickNameView;

@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeight;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@end

@implementation DynamicHotDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"动态";
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
    NSString *imageStr = [_dynamicHot.user objectForKey:@"avatar"];

        NSString *urlStr= @"http://statics.zhuishushenqi.com/";
        NSString *imageViewStr = [NSString stringWithFormat:@"%@%@",urlStr,imageStr];
    [self.nickNameView sd_setImageWithURL:[NSURL URLWithString:imageViewStr]];
//        NSLog(@"%@",imageViewStr);
   

        NSString *nickname = [_dynamicHot.user objectForKey:@"nickname"];
        NSString *lv = [_dynamicHot.user objectForKey:@"lv"];
        self.nickNameLabel.text = [NSString stringWithFormat:@"%@%@%@",nickname,@" Lv.",lv];

        NSString *title = [_dynamicHot.tweet objectForKey:@"title"];
        self.titleLabel.text = title;
 
        NSString *content = [_dynamicHot.tweet  objectForKey:@"content"];
        self.contentLabel.text = content;
        
        NSString *timeStr = [_dynamicHot.tweet  objectForKey:@"created"];
        
        
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