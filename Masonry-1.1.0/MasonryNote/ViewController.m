//
//  ViewController.m
//  MasonryNote
//
//  Created by mayan on 2021/7/2.
//

#import "ViewController.h"
#import <Masonry.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *customView = [[UIView alloc] init];
    customView.backgroundColor = UIColor.orangeColor;
    [self.view addSubview:customView];
    
    [customView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 200));
        make.center.mas_equalTo(self.view);
    }];
}


@end
