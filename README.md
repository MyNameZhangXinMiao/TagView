# 仿京东、淘宝展开/收起标签,支持自定义且自动适应宽高. 高度自定义.标签试图

## 使用方法：
``` 
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
```

```
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
```


## 具体的属性使用Demo里有介绍。
