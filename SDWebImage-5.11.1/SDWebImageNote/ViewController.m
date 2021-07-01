//
//  ViewController.m
//  SDWebImageNote
//
//  Created by mayan on 2021/7/1.
//

#import "ViewController.h"
#import <SDWebImage.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"%@", NSHomeDirectory());
        
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.bounds.size.width - 232) * 0.5, 100, 232, 322)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:@"https://dadi-prod-public.oss-cn-beijing.aliyuncs.com/cmc-background/2020-09-03/43ac78ee3fb747ebb3331fc890b92021/da8024493c8142c0949f8b72d43934c0351577.jpg"]];
    [self.view addSubview:imageView];
}


@end
