//
//  TlTagListView.h
//  TlProject
//
//  Created by Tl on 2023/11/8.
//

#import <UIKit/UIKit.h>

@interface TlTagListConfiguration : NSObject
+ (TlTagListConfiguration *_Nullable)defaultConfiguration;

///标签高度，默认21
@property (nonatomic, assign) CGFloat tagHeight;
///文字左右边距，确定标签宽度，默认8
@property (nonatomic, assign) CGFloat tagTextMargin;
///标签文字字体，默认 fontName=PingFangSC-Regular，size=12
@property (nonatomic, strong) UIFont * _Nullable tagTextFont;
///标签文字颜色，默认grayColor
@property (nonatomic, strong) UIColor * _Nullable tagTextColor;
///标签背景颜色，默认无
@property (nonatomic, strong) UIColor * _Nullable tagBackgroudColor;
///标签圆角，默认21/2
@property (nonatomic, assign) CGFloat cornerRadius;
///标签文字字数限制，默认八个字
@property (nonatomic, assign) CGFloat limitWordNumber;
///标签最大宽度，默认0，此属性大于0时limitWordNumber失效
@property (nonatomic, assign) CGFloat tagMaxWidth;
///标签左右间距，默认8
@property (nonatomic, assign) CGFloat tagHorizontalSpace;
///标签上下间距，默认8
@property (nonatomic, assign) CGFloat tagVerticalSpace;
///标签视图四周边距，默认:UIEdgeInsetsZero
@property (nonatomic, assign) UIEdgeInsets tagListViewInset;

@end

NS_ASSUME_NONNULL_BEGIN

typedef void(^TlTagListChangeHeight)(CGFloat height);

@interface TlTagListView : UIView

///frame高度根据内容和边距确定
- (instancetype)initWithFrame:(CGRect)frame configuration:(TlTagListConfiguration *)configuration tagTexts:(NSArray *)tagTexts tagChangeHeight:(TlTagListChangeHeight)changeHeight;

@property (nonatomic, readonly, copy) NSArray<NSString *> *tagTexts;
@property (nonatomic, readonly, copy) NSArray<UIButton *> *tagButtonList;

@property (nonatomic, copy) TlTagListChangeHeight changeHeight;

@property (nonatomic, copy) void (^tagClickHandler)(TlTagListView *tagListView, NSString *tagText, NSUInteger index);

/** 用于更新*/
- (void)upDateArray:(NSArray *)tagArray;

@end

NS_ASSUME_NONNULL_END
