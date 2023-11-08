//
//  ViewController.m
//  ZXMTagListview
//
//  Created by Tl on 2023/11/8.
//

#import "ViewController.h"
#import "ZHTagListView.h"

#import "TlTagListView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"ZH标签排序";
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSMutableArray *list = [NSMutableArray arrayWithObjects:
                            @"Java",
                            @"JavaScript",
                            @"C",
                            @"C#",
                            @"C++",
                            @".NET",
                            @"Python",
                            @"PHP",
                            @"HTML5",
                            @"Swift",
                            @"Object-C",nil];
    
    ZHTagListView *listV = [[ZHTagListView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 0) configuration:[ZHTagListConfiguration defaultConfiguration] tagTexts:list];
    listV.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:listV];
    [listV setTagClickHandler:^(ZHTagListView *tagListView, NSString *tagText, NSUInteger index) {
        [self jump:tagText];
    }];
    
    /// 展开/ 收起
    NSMutableArray *_dataSource = @[@"宝马",
                                    @"3系",
                                    @"思域",
                                    @"本田雅阁",
                                    @"尼桑",
                                    @"雪佛兰",
                                    @"朗动",
                                    @"高尔夫",
                                    @"沃尔沃",
                                    @"兰博基尼",
                                    @"法拉利",
                                    @"宝马",
                                    @"3系",
                                    @"思域",
                                    @"本田雅阁",
                                    @"尼桑",
                                    @"雪佛兰",
                                    @"朗动",
                                    @"高尔夫",
                                    @"沃尔沃",
                                    @"兰博基尼",
                                    @"法拉利",].mutableCopy;
    
    TlTagListConfiguration *config = [TlTagListConfiguration defaultConfiguration];
    
    TlTagListView *tagList = [[TlTagListView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 0) configuration:config tagTexts:_dataSource tagChangeHeight:^(CGFloat height) {
        
    }];
    tagList.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:tagList];
    [tagList.tagButtonList enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == 6) {
            [obj setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            *stop = YES;
        }
    }];
    [tagList setTagClickHandler:^(TlTagListView *tagListView, NSString *tagText, NSUInteger index) {
        [self jump:tagText];
    }];
}

-(void)jump:(NSString *)text {
    //跳转界面
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
