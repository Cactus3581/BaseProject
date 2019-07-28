//
//  BPScrollLazyLoadViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/6/17.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPScrollLazyLoadViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIView+WebCache.h"

@interface GLImageCell : UITableViewCell
@property (weak, nonatomic) UIImageView *photoView;
@end

@implementation GLImageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    UIImageView *photoView = [[UIImageView alloc] init];
    _photoView = photoView;
    [self.contentView addSubview:photoView];
    [_photoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

@end

@interface BPScrollLazyLoadViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) UITableView *tableView;
@property (copy, nonatomic) NSArray *data;
@property (strong, nonatomic) NSValue *targetRect;
@end

@implementation BPScrollLazyLoadViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.rightBarButtonTitle = @"reFresh";
    [self fetchDataFromServer];
}

- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView = tableView;
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[GLImageCell class] forCellReuseIdentifier:@"ImageCell"];
    }
    return _tableView;
}

- (void)rightBarButtonItemClickAction:(id)sender {
    [self fetchDataFromServer];
}

- (void)fetchDataFromServer {
    static NSString *apiURL = @"http://image.baidu.com/search/acjson?tn=resultjson_com&ipn=rj&ie=utf-8&oe=utf-8&word=cat&queryWord=dog";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFHTTPResponseSerializer *serializer = [AFHTTPResponseSerializer serializer];
    [serializer.acceptableContentTypes setByAddingObject:@"text/html"];
    manager.responseSerializer = serializer;
    [manager GET:apiURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        BPLog(@"Request succeeded");
        NSString *responseString = [[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding] stringByReplacingOccurrencesOfString:@"\\'" withString:@"'"];
        NSData *data = [responseString dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error;
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        if ([responseDictionary isKindOfClass:[NSDictionary class]]) {
            NSArray *originalData = responseDictionary[@"data"];
            NSMutableArray *data = [NSMutableArray array];
            for (NSDictionary *item in originalData) {
                if ([item isKindOfClass:[NSDictionary class]] && [BPValidateString(item[@"hoverURL"]) length] > 0) {
                    [data addObject:item];
                }
            }
            self.data = data;
        } else {
            self.data = nil;
        }
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        BPLog(@"Request falied");
    }];
}

- (NSDictionary *)objectForRow:(NSInteger)row {
    if (row < self.data.count) {
        return self.data[row];
    }
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"ImageCell";
    GLImageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    [self setupCell:cell withIndexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *obj = [self objectForRow:indexPath.row];
    NSInteger width = [obj[@"width"] integerValue] ;
    NSInteger height = [obj[@"height"] integerValue];
    if (obj && width > 0 && height > 0) {
        return tableView.frame.size.width / (float)width * (float)height;
    }
    return 44.0;
}

- (void)setupCell:(GLImageCell *)cell withIndexPath:(NSIndexPath *)indexPath {
    static NSString *referer = @"http://image.baidu.com/i?tn=baiduimage&ipn=r&ct=201326592&cl=2&lm=-1&st=-1&fm=index&fr=&sf=1&fmq=&pv=&ic=0&nc=1&z=&se=1&showtab=0&fb=0&width=&height=&face=0&istype=2&ie=utf-8&word=cat&oq=cat&rsp=-1";
    SDWebImageDownloader *downloader = [[SDWebImageManager sharedManager] imageDownloader];
    [downloader setValue:referer forHTTPHeaderField:@"Referer"];
    
    NSDictionary *obj = [self objectForRow:indexPath.row];
    NSURL *targetURL = [NSURL URLWithString:BPValidateString(obj[@"hoverURL"])];
    //    BPLog(@"%@ %@", self.tableView.dragging ? @"dragging":@"", self.tableView.decelerating ? @"decelerating":@"");
    if (![[cell.photoView sd_imageURL] isEqual:targetURL]) {
        cell.photoView.alpha = 0.0;
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        CGRect cellFrame = [self.tableView rectForRowAtIndexPath:indexPath];
        BOOL shouldLoadImage = YES;
        if (self.targetRect && !CGRectIntersectsRect([self.targetRect CGRectValue], cellFrame)) {
            SDImageCache *cache = [manager imageCache];
            NSString *key = [manager cacheKeyForURL:targetURL];
            if (![cache imageFromMemoryCacheForKey:key]) {
                shouldLoadImage = NO;
            }
        }
        if (shouldLoadImage) {
            [cell.photoView sd_setImageWithURL:targetURL placeholderImage:nil options:SDWebImageHandleCookies completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (!error && [imageURL isEqual:targetURL]) {
                    // fade in animation
                    [UIView animateWithDuration:0.25 animations:^{
                        cell.photoView.alpha = 1.0;
                    }];
                    // or flip animation
                    //                    [UIView transitionWithView:cell duration:0.5 options:UIViewAnimationOptionCurveEaseInOut|UIViewAnimationOptionTransitionFlipFromBottom animations:^{
                    //                        cell.photoView.alpha = 1.0;
                    //                    } completion:^(BOOL finished) {
                    //                    }];
                }
            }];
        }
    }
}

- (void)loadImageForVisibleCells {
    NSArray *cells = [self.tableView visibleCells];
    for (GLImageCell *cell in cells) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        [self setupCell:cell withIndexPath:indexPath];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.targetRect = nil;
    [self loadImageForVisibleCells];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    CGRect targetRect = CGRectMake(targetContentOffset->x, targetContentOffset->y, scrollView.frame.size.width, scrollView.frame.size.height);
    self.targetRect = [NSValue valueWithCGRect:targetRect];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.targetRect = nil;
    [self loadImageForVisibleCells];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
