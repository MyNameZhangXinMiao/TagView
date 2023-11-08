//
//  TlTagListView.m
//  TlProject
//
//  Created by Tl on 2023/11/8.
//

#import "TlTagListView.h"

@implementation TlTagListConfiguration

+ (TlTagListConfiguration *)defaultConfiguration {
    TlTagListConfiguration *configuration = [[TlTagListConfiguration alloc] init];
    configuration.tagHeight = 21;
    configuration.tagTextMargin = 8;
    configuration.tagTextFont = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    configuration.tagTextColor = [UIColor grayColor];
    configuration.tagBackgroudColor = UIColor.clearColor;
    configuration.cornerRadius = 21/2;
    configuration.limitWordNumber = 8;
    configuration.tagMaxWidth = 0;
    configuration.tagListViewInset = UIEdgeInsetsZero;
    configuration.tagHorizontalSpace = 8.0;
    configuration.tagVerticalSpace = 8.0;
    return configuration;
}

@end

@interface TlTagListView ()
@property (nonatomic, strong) TlTagListConfiguration *configuration;
@property (nonatomic, strong) NSMutableArray *tagBtnArray;
@property (nonatomic, copy) NSArray *tags;

@property (nonatomic, assign) BOOL isUnfold;

@property (nonatomic, strong) UIButton *expandButton;

@end

@implementation TlTagListView

- (instancetype)initWithFrame:(CGRect)frame configuration:(TlTagListConfiguration *)configuration tagTexts:(NSArray *)tagTexts tagChangeHeight:(TlTagListChangeHeight)changeHeight{
    self = [super initWithFrame:frame];
    if (self) {
        self.configuration = configuration;
        self.tagBtnArray = [NSMutableArray array];
        self.tags = tagTexts;
        self.changeHeight = changeHeight;
        [self setupTagListView];
    }
    return self;
}


-(void)setupTagListView {
    while (self.subviews.count) {
        [self.subviews.lastObject removeFromSuperview];
    }
    [self.tagBtnArray removeAllObjects];
    
    CGFloat kWidth = self.frame.size.width - self.configuration.tagListViewInset.left - self.configuration.tagListViewInset.right;
    
    CGFloat tagBtnX = self.configuration.tagListViewInset.left;
    CGFloat tagBtnY = self.configuration.tagListViewInset.top;
    CGFloat tagBtnH = self.configuration.tagHeight;
    
    int totalLine = 1;
    
    for (int i = 0; i < self.tags.count; i++) {
        UIButton *tagBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //设置按钮的样式
        tagBtn.layer.borderColor = [UIColor grayColor].CGColor;
        tagBtn.layer.borderWidth = 0;
        tagBtn.layer.cornerRadius = self.configuration.cornerRadius;
        [tagBtn setTitleColor:self.configuration.tagTextColor forState:UIControlStateNormal];
        tagBtn.titleLabel.font = self.configuration.tagTextFont;
        tagBtn.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        tagBtn.backgroundColor = self.configuration.tagBackgroudColor;
        NSString *tag = self.tags[i];
        if (self.configuration.tagMaxWidth <= 0) {
            if (tag.length > self.configuration.limitWordNumber) {
                tag = [NSString stringWithFormat:@"%@%@", [tag substringToIndex:self.configuration.limitWordNumber], @"..."];
            }
            [tagBtn setTitle:tag forState:UIControlStateNormal];
        } else {
            [tagBtn setTitle:tag forState:UIControlStateNormal];
        }
        tagBtn.tag = 1000+i;
        [tagBtn addTarget:self action:@selector(tagBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //计算文字大小
        CGFloat tagBtnW = [tag boundingRectWithSize:CGSizeMake(MAXFLOAT, tagBtnH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:tagBtn.titleLabel.font} context:nil].size.width;
        tagBtnW += self.configuration.tagTextMargin*2;
        if (self.configuration.tagMaxWidth > 0 && tagBtnW > self.configuration.tagMaxWidth) {
            tagBtnW = self.configuration.tagMaxWidth;
        }
        //判断按钮是否超过屏幕的宽
        if ((tagBtnX + tagBtnW) > kWidth) {
            /// 当前在第二行添加 并且 是未展开状态
            if (totalLine == 2 && !self.isUnfold) {
                self.expandButton.frame = CGRectMake(tagBtnX, tagBtnY, 35, tagBtnH);
                [self addSubview:self.expandButton];
                
                CGRect rect = self.frame;
                rect.size.height = CGRectGetMaxY(self.expandButton.frame) + self.configuration.tagListViewInset.bottom;
                self.frame = rect;
                if (self.changeHeight) {
                    self.changeHeight(rect.size.height);
                }
                
                break;
            }
            
            tagBtnX = self.configuration.tagListViewInset.left;
            tagBtnY += tagBtnH + self.configuration.tagVerticalSpace;
            
            totalLine++;
        }
        //frame
        tagBtn.frame = CGRectMake(tagBtnX, tagBtnY, tagBtnW, tagBtnH);
        tagBtnX += tagBtnW + self.configuration.tagHorizontalSpace;
        
        [self addSubview:tagBtn];
        [self.tagBtnArray addObject:tagBtn];
        if (i == self.tags.count - 1) {
            /// 当前 是展开状态
            if (self.isUnfold) {
                
                self.expandButton.frame = CGRectMake(tagBtnX, tagBtnY, 35, tagBtnH);
                [self addSubview:self.expandButton];
                
                CGRect rect = self.frame;
                rect.size.height = CGRectGetMaxY(self.expandButton.frame) + self.configuration.tagListViewInset.bottom;
                self.frame = rect;
                
                if (self.changeHeight) {
                    self.changeHeight(rect.size.height);
                }
            }else{
                CGRect rect = self.frame;
                rect.size.height = CGRectGetMaxY(tagBtn.frame) + self.configuration.tagListViewInset.bottom;
                self.frame = rect;
                
                if (self.changeHeight) {
                    self.changeHeight(rect.size.height);
                }
            }
        }
    }
}


-(void)tagBtnClick:(UIButton *)btn {
    if (self.tagClickHandler) {
        self.tagClickHandler(self, btn.titleLabel.text, btn.tag-1000);
    }
}
- (void)clickExpandAction:(UIButton *)btn{
    btn.selected = !btn.isSelected;
    self.isUnfold = !self.isUnfold;
    
    ///
    [self setupTagListView];
}

/** 用于更新*/
- (void)upDateArray:(NSArray *)tagArray{
    self.tags = tagArray;
    
    self.isUnfold = NO;
    self.expandButton.selected = NO;
    [self setupTagListView];
}

- (NSArray<NSString *> *)tagTexts {
    return self.tags;
}

- (NSArray<UIButton *> *)tagButtonList {
    return self.tagBtnArray;
}

#pragma mark  - 懒加载
- (UIButton *)expandButton{
    if (!_expandButton) {
        _expandButton = [UIButton buttonWithType:UIButtonTypeCustom];
        //设置按钮的样式
        [_expandButton setImage:[UIImage imageNamed:@"1.0_Home_Search_History_Bottom"] forState:(UIControlStateNormal)];
        [_expandButton setImage:[UIImage imageNamed:@"1.0_Home_Search_History_Top"] forState:(UIControlStateSelected)];
        _expandButton.backgroundColor = self.configuration.tagBackgroudColor;
        _expandButton.layer.cornerRadius = self.configuration.cornerRadius;
        [_expandButton addTarget:self action:@selector(clickExpandAction:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _expandButton;
}

@end
