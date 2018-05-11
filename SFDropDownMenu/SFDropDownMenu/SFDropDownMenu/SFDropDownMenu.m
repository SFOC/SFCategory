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

/// 缓存注册了的view
@property (nonatomic, strong) NSMutableDictionary *cacheRegisterViewMDic;

/// 缓存对应位置的的view
@property (nonatomic, strong) NSMutableArray *cacheIndexPositionView;
@end

@implementation SFDropDownMenu

- (instancetype)init
{
    self = [super init];
    if (self) {
       
        [self initialize];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initialize];
    }
    return self;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    [self initialize];
    
}
#pragma mark -------------------------------------set方法--------------------------
- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    if (CGRectIsEmpty(self.frame) || CGRectIsNull(self.frame)) {
        
        /// 只记录首次设置的frame
        self.rect = frame;
    }
    
}

#pragma mark ------------------------------懒加载--------------------------------------
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
        
        for (UIView *view in weakSelf.cacheIndexPositionView) {
            
            view.hidden = YES;
        }
        
        
        if ([weakSelf.delegate respondsToSelector:@selector(sf_dropDownMenu:didSelectIndex:)]) {
            
            [weakSelf.delegate sf_dropDownMenu:weakSelf didSelectIndex:index];
        }
        
        
        if ([weakSelf.dataSource respondsToSelector:@selector(sf_dropDownMenuShowView:index:)]) {
            
            /// 点击item的时候返回要展示的view类型
            UIView *view = [weakSelf.dataSource sf_dropDownMenuShowView:weakSelf index:index];
            view.hidden = NO;
            if (![weakSelf.subviews containsObject:view]) {
                
                [weakSelf addSubview:view];
            }
        }
        
        if ([weakSelf.delegate respondsToSelector:@selector(sf_dropDownMenu:rectReturnIndex:)]) {
            
            CGRect rect = [weakSelf.delegate sf_dropDownMenu:weakSelf rectReturnIndex:index];
            UIView *view = weakSelf.cacheIndexPositionView[index];
            view.frame = rect;
        }
        
        weakSelf.frame = weakSelf.rect;
        [UIView animateWithDuration:0.3 animations:^{
           
            weakSelf.frame = CGRectMake(weakSelf.frame.origin.x, weakSelf.frame.origin.y, weakSelf.frame.size.width, 500);
        }];
    };
    
    return _topView;
}

- (NSMutableDictionary *)cacheRegisterViewMDic {
    
    if (!_cacheRegisterViewMDic) {
        
        _cacheRegisterViewMDic = [NSMutableDictionary new];
    }
    
    return _cacheRegisterViewMDic;
}


- (NSMutableArray *)cacheIndexPositionView {
    if (!_cacheIndexPositionView) {
        
        _cacheIndexPositionView = [NSMutableArray new];
    }
    
    return _cacheIndexPositionView;
}
#pragma mark -------------------------------------私有方法---------------------------------
/// 创建UI
- (void) createUI {
    
    /// 添加顶部菜单view到baseView上
    [self addSubview:self.topView];
}

#pragma mark ----------------------------------初始化变量-----------------------------------
- (void) initialize {
    
    if (CGRectIsNull(self.frame) || CGRectIsEmpty(self.frame)) {
        
        self.rect = CGRectMake(0, 0, SF_DDM_Width, 50);
    }else {
        
        self.rect = self.frame;
    }
}

#pragma mark ------------------------------------外部调用方法--------------------------------
- (void)registerClass:(Class)cellClass forViewReuseIdentifier:(NSString *)identifier {

    /// 缓存view
    UIView *view = [[SFDDMBottomSingleOrMultiSelectView alloc] init];
//    UIView *view = [NSClassFromString(@"SFDDMBottomSingleOrMultiSelectView") new];
    view.frame = CGRectMake(0, 55, [UIScreen mainScreen].bounds.size.width, 200);
    [view setNeedsDisplay];
    [self.cacheRegisterViewMDic setValue:view forKey:identifier];
}

- (void)registerNib:(UINib *)nib forViewReuseIdentifier:(NSString *)identifier {
   
    
}

- (nullable __kindof UIView *)dequeueReusableViewWithIdentifier:(NSString *)identifier index:(NSInteger)index {
    
    UIView *view = self.cacheRegisterViewMDic[identifier];
    return view;
}

- (void)reloadRefreshSFDropDownMenu {
#pragma mark ---dataSource设置响应----
    if (self.dataSource) {
        
        /// 接受返回个数
        if ([_dataSource respondsToSelector:@selector(titleNumInSf_dropDownMenu:)]) {
            
            self.numOfMenu = [_dataSource titleNumInSf_dropDownMenu:self];
        }
        
        
        /// 接收title数组
        if ([_dataSource respondsToSelector:@selector(sf_dropDownMenu:)]) {
            
            self.titleMArr = [_dataSource sf_dropDownMenu:self];
        }
        
        
        /// 接收需要展示的view并缓存起来
        if ([_dataSource respondsToSelector:@selector(sf_dropDownMenuShowView:index:)]) {
            
            [self.cacheIndexPositionView removeAllObjects];
            // 这个时候将所有view缓存起来
            for (int i = 0; i < self.numOfMenu; i++) {
                
                /// 此时如果还没有注册所以获可能获取不到
                UIView *view = [_dataSource sf_dropDownMenuShowView:self index:i];
                if (view) {
                    
                    [self.cacheIndexPositionView addObject:view];
                }else {
                    
                    [self.cacheIndexPositionView addObject:[UIView new]];
                }
            }
        }
    }
    
    
#pragma mark ---delegate设置响应----
    if (self.delegate) {
        
        if ([_delegate respondsToSelector:@selector(sf_dropDownMenu:rectReturnIndex:)]) {
            
           
            
        }
    }
}

#pragma mark ------------------------------系统方法----------------------------------------
- (void)drawRect:(CGRect)rect {

    [self reloadRefreshSFDropDownMenu];
    [self createUI];
}
@end
