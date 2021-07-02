//
//  ViewController.m
//  FMDBNote
//
//  Created by mayan on 2021/7/2.
//

#import "ViewController.h"
#import "FMDBManager.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) NSArray <Person *>*dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    [[FMDBManager shareInstance] getPersonArray:^(NSArray<Person *> * _Nonnull personArray) {
        self.dataArray = personArray;
        [self.tableView reloadData];
    }];
}

- (IBAction)add:(UIBarButtonItem *)sender {
    int id = (int)self.dataArray.count + 1;
    Person *p = [[Person alloc] initWithId:id
                                      name:[NSString stringWithFormat:@"人员 %d", id]
                                     phone:[NSString stringWithFormat:@"%d%d%d%d%d", id, id, id, id, id]];
    [[FMDBManager shareInstance] addPerson:p andProgressBlock:^(NSArray<Person *> * _Nonnull personArray) {
        self.dataArray = personArray;
        [self.tableView reloadData];
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    cell.textLabel.text = self.dataArray[indexPath.row].name;
    return cell;
}


#pragma mark - Lazy Load

- (NSArray<Person *> *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSArray array];
    }
    return _dataArray;
}


@end
