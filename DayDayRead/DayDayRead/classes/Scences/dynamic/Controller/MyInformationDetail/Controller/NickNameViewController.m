//
//  NickNameViewController.m
//  项目
//
//  Created by lanou3g on 16/6/28.
//  Copyright © 2016年 张明杰. All rights reserved.
//

#import "NickNameViewController.h"
#import <Masonry.h>

@interface NickNameViewController ()
@property (nonatomic,strong)UITextField *nicknameTextfield;

@end

@implementation NickNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    // Do any additional setup after loading the view.
    self.title = @"昵称修改";
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
}
- (void)initView{
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(leftACtion:)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(rightACtion:)];
    
    self.nicknameTextfield = [[UITextField alloc] init];
    self.nicknameTextfield.borderStyle =  UITextBorderStyleRoundedRect;
    self.nicknameTextfield.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.nicknameTextfield];
    [self.nicknameTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width);
        make.height.mas_equalTo (40);
        
    }];
}

- (void)leftACtion:(UIBarButtonItem *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)rightACtion:(UIBarButtonItem *)sender {
    self.block(_nicknameTextfield.text);
    [self dismissViewControllerAnimated:YES completion:nil];
    
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
