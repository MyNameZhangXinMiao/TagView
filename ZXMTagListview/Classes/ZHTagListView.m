//
//  ZHTagListView.m
//
//  Created by 李志华 on 2017/02/18.
//  Copyright © 2017年 leezhihua. All rights reserved.
//

#import "ZHTagListView.h"
@implementation ZHTagListConfiguration
+ (ZHTagListConfiguration *)defaultConfiguration {
    ZHTagListConfiguration *configuration = [[ZHTagListConfiguration alloc] init];
    configuration.tagHeight = 30;
    configuration.tagTextMargin = 10;
    configuration.tagTextFont = [UIFont systemFontOfSize:15];
    configuration.tagTextColor = [UIColor grayColor];
    configuration.limitWordNumber = 8;
    configuration.tagMaxWidth = 0;
    configuration.tagListViewInset = UIEdgeInsetsZero;
    configuration.tagHorizontalSpace = 10.0;
    configuration.tagVerticalSpace = 10.0;
    return configuration;
}
@end


@interface ZHTagListView ()
@property (nonatomic, strong) ZHTagListConfiguration *configuration;
@property (nonatomic, strong) NSMutableArray *tagBtnArray;
@property (nonatomic, copy) NSArray *tags;

@end


@implementation ZHTagListView

- (instancetype)initWithFrame:(CGRect)frame configuration:(ZHTagListConfiguration *)configuration tagTexts:(NSArray *)tagTexts {
    self = [super initWithFrame:frame];
    if (self) {
        self.configuration = configuration;
        self.tagBtnArray = [NSMutableArray array];
        self.tags = tagTexts;
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
    
    for (int i = 0; i < self.tags.count; i++) {
        UIButton *tagBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //设置按钮的样式
        tagBtn.layer.borderColor = [UIColor grayColor].CGColor;
        tagBtn.layer.borderWidth = 0.5;
        tagBtn.layer.cornerRadius = 2.5;
        [tagBtn setTitleColor:self.configuration.tagTextColor forState:UIControlStateNormal];
        tagBtn.titleLabel.font = self.configuration.tagTextFont;
        tagBtn.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
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
            tagBtnX = self.configuration.tagListViewInset.left;
            tagBtnY += tagBtnH + self.configuration.tagVerticalSpace;
        }
        //frame
        tagBtn.frame = CGRectMake(tagBtnX, tagBtnY, tagBtnW, tagBtnH);
        tagBtnX += tagBtnW + self.configuration.tagHorizontalSpace;
        
        [self addSubview:tagBtn];
        [self.tagBtnArray addObject:tagBtn];
        if (i == self.tags.count - 1) {
            CGRect rect = self.frame;
            rect.size.height = CGRectGetMaxY(tagBtn.frame) + self.configuration.tagListViewInset.bottom;
            self.frame = rect;
        }
    }
}


-(void)tagBtnClick:(UIButton *)btn {
    if (self.tagClickHandler) {
        self.tagClickHandler(self, btn.titleLabel.text, btn.tag-1000);
    }
}

- (NSArray<NSString *> *)tagTexts {
    return self.tags;
}

- (NSArray<UIButton *> *)tagButtonList {
    return self.tagBtnArray;
}

@end
