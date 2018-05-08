//
//  SFDropDownMenu.m
//  SFDropDownMenu
//  类似买房类软件的点击下拉选择菜单
//  Created by fly on 2018/5/6.
//  Copyright © 2018年 石峰(fly). All rights reserved.
//

#import "SFDropDownMenu.h"
#import "SFDropDownMenuTopView.h"
#import "SFDropDownMenuBottomMultistageView.h"
#import "SFDropDownMenuMaro.h"
#import "SFDDMBottomSingleOrMultiSelectView.h"

@interface SFDropDownMenu ()

/// 菜单数量
@property (nonatomic, assign) NSInteger numOfMenu;

@property (nonatomic, strong) NSMutableArray *titleMArr;

/// 顶部view
@property (nonatomic, strong) SFDropDownMenuTopView *topView;

/// 记录首次设置的位置大小
@property (nonatomic, assign) CGRect rect;

/// 要展示的view的type类型
@property (nonatomic, assign) SF_DDMB_ShowViewType showViewType;

/// 多表联动view
@property (nonatomic, strong) SFDropDownMenuBottomMultistageView *linkageView;

/// 单行view
@property (nonatomic, strong) SFDDMBottomSingleOrMultiSelectView *singleRowView;

@end

@implementation SFDropDownMenu

- (instancetype)init
{
    self = [super init];
    if (self) {
       
        [self initialize];
        [self createUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initialize];
        [self createUI];
    }
    return self;
}
#pragma mark ---set方法---
- (void)setDataSource:(id<SFDropDownMenuDataSource>)dataSource  {
    
    _dataSource = dataSource;
    if ([_dataSource respondsToSelector:@selector(titleNumInSf_dropDownMenu:)]) {
    
        self.numOfMenu = [_dataSource titleNumInSf_dropDownMenu:self];
    }
    
    if ([_dataSource respondsToSelector:@selector(sf_dropDownMenu:)]) {
    
        self.titleMArr = [_dataSource sf_dropDownMenu:self];
    }
    
    
    /// 添加顶部菜单view到baseView上
    [self addSubview:self.topView];
}

- (void)setDelegate:(id<SFDropDownMenuDelegate>)delegate {
    _delegate = delegate;
    
    
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    if (CGRectIsEmpty(self.frame) || CGRectIsNull(self.frame)) {
        
        /// 只记录首次设置的frame
        self.rect = frame;
    }
    
}

#pragma mark ---懒加载---
- (SFDropDownMenuTopView *)topView {
    
    if (!_topView) {
        
        if (_numOfMenu > _titleMArr.count) {
            
            for (int i = 0; i < _numOfMenu - _titleMArr.count + 1; i++) {
                
                [_titleMArr addObject:@""];
            }
            _topView = [SFDropDownMenuTopView initWithFrame:CGRectMake(0, 0, self.frame.size.width, 50) titleArr:_titleMArr];

        }else {
            
            _topView = [SFDropDownMenuTopView initWithFrame:CGRectMake(0, 0, self.frame.size.width, 50) titleArr:_titleMArr];
        }
        
    }
    
    __weak typeof(self) weakSelf = self;
    /// 按钮的点击方法
    _topView.clickAction = ^(NSInteger index) {
        
        if ([weakSelf.delegate respondsToSelector:@selector(sf_dropDownMenu:didSelectIndex:)]) {
            
            [weakSelf.delegate sf_dropDownMenu:weakSelf didSelectIndex:index];
        }
        
        if ([weakSelf.dataSource respondsToSelector:@selector(sf_dropDownMenu:index:)]) {
            
            /// 点击item的时候返回要展示的view类型
            weakSelf.showViewType = [weakSelf.dataSource sf_dropDownMenu:weakSelf index:index];
        }

        
        switch (weakSelf.showViewType) { /// 点击了item需要展示的view
            case SF_DDMB_ShowViewLinkageType: /// 多表联动型
            {
                for (UIView *view in weakSelf.subviews) {
                    
                    if (![view isMemberOfClass:[SFDropDownMenuTopView class]]) {
                        
                        view.hidden = YES;
                    }
                }
                
                weakSelf.linkageView.hidden = NO;
                if (![weakSelf.subviews containsObject:weakSelf.linkageView]) {
                    
                    [weakSelf addSubview:weakSelf.linkageView];
                }
                
                CGFloat with = 0.0;
                if (weakSelf.numOfMenu > self.titleMArr.count) {
                    
                    with = (CGFloat)weakSelf.frame.size.width/(CGFloat)weakSelf.numOfMenu;
                }else {
                    
                    with = (CGFloat)weakSelf.frame.size.width/(CGFloat)weakSelf.titleMArr.count;
                }
                weakSelf.linkageView.arrowSpaceX_YLength = with * index + with/2;
                
            }
                break;
            case SF_DDMB_ShowViewSingleRowType: /// 单列多选或单选
            {
                for (UIView *view in weakSelf.subviews) {
                    
                    if (![view isMemberOfClass:[SFDropDownMenuTopView class]]) {
                        
                        view.hidden = YES;
                    }
                }
                
                weakSelf.singleRowView.hidden = NO;
                if (![weakSelf.subviews containsObject:weakSelf.singleRowView]) {
                    
                    [weakSelf addSubview:weakSelf.singleRowView];
                }
                
                CGFloat with = 0.0;
                if (weakSelf.numOfMenu > self.titleMArr.count) {
                    
                    with = (CGFloat)weakSelf.frame.size.width/(CGFloat)weakSelf.numOfMenu;
                }else {
                    
                    with = (CGFloat)weakSelf.frame.size.width/(CGFloat)weakSelf.titleMArr.count;
                }
                
                weakSelf.singleRowView.arrowSpaceX_YLength = with*index + with/2.0;
            }
                break;
                
            default:
                break;
        }
        
        
        
        weakSelf.frame = weakSelf.rect;
        [UIView animateWithDuration:0.3 animations:^{
           
            weakSelf.frame = CGRectMake(weakSelf.frame.origin.x, weakSelf.frame.origin.y, weakSelf.frame.size.width, 500);
        }];
    };
    
    return _topView;
}

- (SFDropDownMenuBottomMultistageView *)linkageView {
    
    if (!_linkageView) {
        
        _linkageView = [[SFDropDownMenuBottomMultistageView alloc] initWithFrame:CGRectMake(0, 50 + 5, SF_DDM_Width, 200)];
        _linkageView.borderArrowDirect = sf_borderArrowDirectTop;
        _linkageView.arrowSpaceX_YLength = 20;
        _linkageView.radian = 0;
        _linkageView.borderColor = [UIColor whiteColor];
    }
    return _linkageView;
}

- (SFDDMBottomSingleOrMultiSelectView *)singleRowView {
    
    if (!_singleRowView) {
        
        _singleRowView = [[SFDDMBottomSingleOrMultiSelectView alloc] initWithFrame:CGRectMake(0, 50 + 5, SF_DDM_Width, 200)];
        _singleRowView.borderArrowDirect = sf_borderArrowDirectTop;
        _singleRowView.arrowSpaceX_YLength = 20;
        _singleRowView.radian = 0;
        _singleRowView.borderColor = [UIColor blueColor];
        _singleRowView.backgroundColor = [UIColor orangeColor];
    }
    
    return _singleRowView;
}

#pragma mark ---私有方法---
/// 创建UI
- (void) createUI {
    
//    SFDropDownMenuTopView *
}

#pragma mark ---初始化变量---
- (void) initialize {
    
    if (CGRectIsNull(self.frame) || CGRectIsEmpty(self.frame)) {
        
        self.rect = CGRectMake(0, 0, SF_DDM_Width, 50);
    }else {
        
        self.rect = self.frame;
    }
}



@end
