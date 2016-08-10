//
//  ViewController.m
//  文本包含超链接或类按钮可点击跳转
//
//  Created by LIUYANG on 16/8/10.
//  Copyright © 2016年 LYG. All rights reserved.
//

#import "ViewController.h"
#import "DetailsViewController.h"
@interface ViewController () <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *linkTextView;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.linkTextView.delegate = self;
    self.linkTextView.editable = NO;
    self.linkTextView.dataDetectorTypes = UIDataDetectorTypeAll;
    self.linkTextView.font = [UIFont systemFontOfSize:15];
    // 超链接的文本颜色控制在Attributed的dictionary设置无效（默认蓝），可在tintColor设置超链接颜色
    self.linkTextView.tintColor = [UIColor orangeColor];
    
    
    NSString *str = @"请遵守《中华人民共和国宪法》，欢迎访问逆流瞅瞅的blog，\n查看详情";
    NSRange lawRange = [str rangeOfString:@"《中华人民共和国宪法》"];
    NSDictionary *attDic = @{NSFontAttributeName : [UIFont systemFontOfSize:18],
                             NSLinkAttributeName : @"http://www.baidu.com",
                             NSForegroundColorAttributeName : [UIColor redColor]};
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    
    [attrStr addAttributes:attDic range:lawRange];
    
    NSRange blogRange = [str rangeOfString:@"逆流瞅瞅的blog"];
    NSDictionary *blogAttDic = @{NSFontAttributeName : [UIFont systemFontOfSize:18],
                                 NSForegroundColorAttributeName : [UIColor blueColor],
                                 NSLinkAttributeName : @"http://blog.csdn.net/liuyang11908",
                                 NSUnderlineStyleAttributeName : @1};
    [attrStr addAttributes:blogAttDic range:blogRange];
    
    
    NSRange detailRange = [str rangeOfString:@"查看详情"];
    NSDictionary *detailAttDic = @{NSFontAttributeName : [UIFont systemFontOfSize:20],
                                 NSForegroundColorAttributeName : [UIColor cyanColor],
                                 NSLinkAttributeName : @"present://xxx",
                                 NSUnderlineStyleAttributeName : @1};
    [attrStr addAttributes:detailAttDic range:detailRange];

    self.linkTextView.attributedText = attrStr;

    
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    NSLog(@"-- %s--  URL = %@",__func__, URL);
    
    if ([[URL scheme] isEqualToString:@"present"]) {
        
        DetailsViewController *detailVC = [[DetailsViewController alloc] initWithNibName:@"DetailsViewController" bundle:nil];
        
        [self presentViewController:detailVC animated:YES completion:nil];
    }
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
