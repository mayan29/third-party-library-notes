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
    
    NSString *url = @"https://up.enterdesk.com/edpic_source/4e/8d/d1/4e8dd1d5bdb42cb5e93eda3f458db3c5.jpg";
        
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.bounds.size.width - 192) * 0.5, 200, 192, 108)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:url]];
    [self.view addSubview:imageView];
}


@end
