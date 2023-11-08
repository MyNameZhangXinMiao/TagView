//
//  ZHTagListView.h
//
//  Created by 李志华 on 2017/02/18.
//  Copyright © 2017年 leezhihua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHTagListConfiguration : NSObject
+ (ZHTagListConfiguration *)defaultConfiguration;

///标签高度，默认30
@property (nonatomic, assign) CGFloat tagHeight;
///文字左右边距，确定标签宽度，默认10
@property (nonatomic, assign) CGFloat tagTextMargin;
///标签文字字体，默认size=15
@property (nonatomic, strong) UIFont *tagTextFont;
///标签文字颜色，默认grayColor
@property (nonatomic, strong) UIColor *tagTextColor;
///标签文字字数限制，默认八个字
@property (nonatomic, assign) CGFloat limitWordNumber;
///标签最大宽度，默认0，此属性大于0时limitWordNumber失效
@property (nonatomic, assign) CGFloat tagMaxWidth;
///标签左右间距，默认10
@property (nonatomic, assign) CGFloat tagHorizontalSpace;
///标签上下间距，默认10
@property (nonatomic, assign) CGFloat tagVerticalSpace;
    ///标签视图四周边距，默认:UIEdgeInsetsZero
    @property (nonatomic, assign) UIEdgeInsets tagListViewInset;
@end


@interface ZHTagListView : UIView
///frame高度根据内容和边距确定
- (instancetype)initWithFrame:(CGRect)frame configuration:(ZHTagListConfiguration *)configuration tagTexts:(NSArray *)tagTexts;

@property (nonatomic, readonly, copy) NSArray<NSString *> *tagTexts;
@property (nonatomic, readonly, copy) NSArray<UIButton *> *tagButtonList;

@property (nonatomic, copy) void (^tagClickHandler)(ZHTagListView *tagListView, NSString *tagText, NSUInteger index);
@end
