//
//  BeforeReadViewController.m
//  DayDayRead
//
//  Created by 王志准 on 16/6/30.
//  Copyright © 2016年 王志准. All rights reserved.
//

#import "BeforeReadViewController.h"
#import "bookDetail.h"
#import "NetWorkRequestManager.h"
#import <UIImageView+WebCache.h>
#import "Tool.h"
#import "DB_COLOR.h"
#import "ReadingViewController.h"
#import "BookReadManager.h"
#import "UserFileHandle.h"
#import "LoginViewController.h"
@interface BeforeReadViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *authorWidth;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leiLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentLabelHeight;
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *runButton;
@property (weak, nonatomic) IBOutlet UILabel *runNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *keepNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *updateNumLabel;
@property (weak, nonatomic) IBOutlet UIView *leiView;
@property (weak, nonatomic) IBOutlet UILabel *jiangeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (nonatomic,strong)bookDetail *detail;

@end

#define kIsHadUserLogin ([UserFileHandle selectUserInfo].isLogin)
#define kIsHadCollected ([[BookReadManager shareBookReadManager] isFavorateBookWithID:_detail._id])

@implementation BeforeReadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"书籍详情";
    // Do any additional setup after loading the view from its nib.
    self.title = @"书籍详情";
    //请求数据
    [self loadData];
    
}

//追加更新

- (IBAction)didRunUpdate:(UIButton *)sender {
    
    // 判断是否登录
    if (kIsHadUserLogin == YES) {
        // 判断是否收藏过
        if (kIsHadCollected == YES) {
            // 如果已经收藏过, 取消收藏
            [[BookReadManager shareBookReadManager] deleteBook:_detail];
            [sender setTitle:@"+ 追更新" forState:UIControlStateNormal];
            sender.backgroundColor = [UIColor redColor];
        } else {
            // 如果没有收藏过, 收藏
            [[BookReadManager shareBookReadManager] insertNewBook:_detail];
            sender.backgroundColor = [UIColor grayColor];
            [sender setTitle:@"- 追更新" forState:UIControlStateNormal];
        }
    } else {
        // 如果没有登录, 点击弹出登录界面
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        // 登录界面
        loginVC.block = ^(User *user) {
            
        };
        [self.navigationController pushViewController:loginVC animated:YES];
    }
}


- (void)loadData{
    NSString *str = [NSString stringWithFormat:@"http://api.zhuishushenqi.com/book/%@/",__id];
    __weak typeof (self)weakSelf = self;
    [NetWorkRequestManager requestType:GET urlString:str prama:nil success:^(id data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        _detail = [bookDetail new];
        [_detail setValuesForKeysWithDictionary:dic];
        dispatch_async(dispatch_get_main_queue(), ^{
            //刷新UI
            [weakSelf updateUI];
        });
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
//刷新UI
- (void)updateUI {
    if (_detail.cover.length > 7) {
        [_myImageView sd_setImageWithURL:[NSURL URLWithString:[_detail.cover substringFromIndex:7]]];
    }
    _titleLabel.text = _detail.title;

    _authorWidth.constant = [Tool textWidthWithText:_detail.author font:[UIFont systemFontOfSize:13]];
    _authorLabel.text = _detail.author;

    _numLabel.frame = CGRectMake(CGRectGetMinX(_authorLabel.frame)+_authorWidth.constant, _authorLabel.frame.origin.y, 150, 15);
    _numLabel.text = [NSString stringWithFormat:@" | %@ | %d万字",_detail.minorCate,[_detail.wordCount intValue]/10000];
    if ([_detail.minorCate isEqualToString:@""]) {
        _numLabel.text = [NSString stringWithFormat:@" | %@ | %d万字",_detail.majorCate,[_detail.wordCount intValue]/10000];
    }else if([_detail.majorCate isEqualToString:@""]){
        _numLabel.text = [NSString stringWithFormat:@" | %@ | %d万字",_detail.cat,[_detail.wordCount intValue]/10000];
    }
    if (!_detail.isSerial) {
        _timeLabel.text = @"已完结";
    }else{
        NSDate *date = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YYYY/MM/dd HH:mm:ss"];
        NSString *string = [formatter stringFromDate:date];
        NSString *cumonth = [string substringWithRange:NSMakeRange(5, 2)];
        NSString *cuday = [string substringWithRange:NSMakeRange(8, 2)];
        NSString *cuhour = [string substringWithRange:NSMakeRange(11, 2)];
        NSString *month = [_detail.updated substringWithRange:NSMakeRange(5, 2)];
        NSString *day = [_detail.updated substringWithRange:NSMakeRange(8, 2)];
        NSString *hour = [_detail.updated substringWithRange:NSMakeRange(11, 2)];
        if (cumonth.intValue > month.intValue) {
            if (cuday.intValue > day.intValue) {
                _timeLabel.text = [NSString stringWithFormat:@"%d天前更新",cuday.intValue-day.intValue];
            }else if(cuhour.intValue > hour.intValue){
                _timeLabel.text = [NSString stringWithFormat:@"%d小时前更新",cuhour.intValue-hour.intValue];
            }
        }
    }
    _runNumLabel.text = [NSString stringWithFormat:@"%@",_detail.latelyFollower];
    if (!_detail.retentionRatio) {
        _keepNumLabel.text = @"0%";
    }else{
        _keepNumLabel.text = [NSString stringWithFormat:@"%@%%",_detail.retentionRatio];
    }
    if (_detail.serializeWordCount.intValue == -1) {
        _updateNumLabel.text = @"暂无统计";
    }else{
        _updateNumLabel.text = [NSString stringWithFormat:@"%@",_detail.serializeWordCount];
    }
    int hang = 1;
    
    for (int i = 0; i< _detail.tags.count; i++) {
        CGFloat width = 0.0;
        
        for (int j=0; j<i; j++) {
            width += ([Tool textWidthWithText:_detail.tags[j] font:[UIFont systemFontOfSize:17]]+10);
        }
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(width, 30*(hang-1), [Tool textWidthWithText:_detail.tags[i] font:[UIFont systemFontOfSize:17]], 20)];
        if (CGRectGetMaxX(label.frame)>CGRectGetMaxX(self.leiView.frame)) {
            hang ++;
            
            label.frame = CGRectMake(0, 30*(hang-1), [Tool textWidthWithText:_detail.tags[i] font:[UIFont systemFontOfSize:17]], 20);
        }
        label.backgroundColor = DB_RANDOM_COLOR;
        label.text = _detail.tags[i];
        [self.leiView addSubview:label];
    }

    self.leiLabel.constant = 30*hang;
    CGFloat www = self.jiangeLabel.frame.size.width;
    CGRect framejian = CGRectMake(20, CGRectGetMaxY(self.leiView.frame)+10, www, 1);
    self.jiangeLabel.frame = framejian;
    
    CGFloat conHeight = [Tool textHeightWithText:_detail.longIntro font:[UIFont systemFontOfSize:17]];
    self.contentLabelHeight.constant = conHeight;
    self.contentLabel.text = _detail.longIntro;
    self.contentViewHeight.constant = self.leiView.frame.origin.y+self.leiLabel.constant+35+conHeight;
}
//开始阅读
- (IBAction)didBegainRead:(id)sender {
    ReadingViewController *readVC = [[ReadingViewController alloc] init];
    readVC._id = self._id;
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:readVC];
    [self presentViewController:nav animated:YES completion:nil];
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
