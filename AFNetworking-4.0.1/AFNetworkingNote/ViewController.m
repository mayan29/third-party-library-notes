//
//  ViewController.m
//  AFNetworkingNote
//
//  Created by mayan on 2021/7/2.
//

#import "ViewController.h"
#import <AFNetworking.h>

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) NSArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    NSString *url = @"https://movie.douban.com/j/search_subjects";
    NSDictionary *params = @{
        @"type": @"tv",
        @"tag": @"热门",
        @"page_limit": @50,
        @"page_start": @0
    };
    
    [[AFHTTPSessionManager manager] GET:url
                             parameters:params
                                headers:nil
                               progress:nil
                                success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求成功: %@", responseObject);
        self.dataArray = responseObject[@"subjects"];
        [self.tableView reloadData];
    }
                                failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败: %@", error);
    }];
}


#pragma mark - UITableViewDelegate and UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = self.dataArray[indexPath.row][@"title"];
    return cell;
}


#pragma mark - Lazy Load

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSArray array];
    }
    return _dataArray;
}


@end
