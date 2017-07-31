//
//  UIAlertController+MZStyle.m
//  customAlert
//
//  Created by Michal Zaborowski on 16.01.2016.
//  Copyright © 2016 Michal Zaborowski. All rights reserved.
//

#import "UIAlertController+CheckView.h"
#import <objc/runtime.h>

static NSMutableSet<Class> *instanceOfClassesSet = nil;

@implementation UIAlertController (MZStyle)

+ (void)mz_swizzleInstanceSelector:(SEL)originalSelector
                   withNewSelector:(SEL)newSelector {
  Method originalMethod = class_getInstanceMethod(self, originalSelector);
  Method newMethod = class_getInstanceMethod(self, newSelector);

  BOOL methodAdded = class_addMethod([self class], originalSelector,
                                     method_getImplementation(newMethod),
                                     method_getTypeEncoding(newMethod));

  if (methodAdded) {
    class_replaceMethod([self class], newSelector,
                        method_getImplementation(originalMethod),
                        method_getTypeEncoding(originalMethod));
  } else {
    method_exchangeImplementations(originalMethod, newMethod);
  }
}

+ (void)mz_applyCustomStyleForAlertControllerClass:(Class)alertControllerClass {
  NSParameterAssert(alertControllerClass);
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    instanceOfClassesSet = [[NSMutableSet alloc] init];
  });
  if (instanceOfClassesSet.count <= 0) {

    [self mz_swizzleInstanceSelector:@selector(viewWillAppear:)
                     withNewSelector:@selector(mz_viewWillAppear:)];
  }
  [instanceOfClassesSet addObject:alertControllerClass];
}

- (id)init {
  if (self = [super init]) {
    self.selectedIndex = 1024;
  }
  return self;
}

- (void)mz_viewWillAppear:(BOOL)animated {
  [self mz_viewWillAppear:animated];

  if (self.selectedIndex != 1024 &&
      self.preferredStyle == UIAlertControllerStyleActionSheet) {
    [self setCheakViewSelectedWithIndex:self.selectedIndex];
  }
}

- (void)setCheakViewSelectedWithIndex:(NSUInteger)index {

  [self.presentationController.containerView
      enumerateAllSubviewsUsingBlock:^(__kindof UIView *subview) {
        if ([subview isKindOfClass:[UICollectionView class]]) {
          UICollectionView *collectionView = subview;
          if (index < collectionView.subviews.count) {
            for (NSInteger i = 0; i < collectionView.subviews.count; i++) {

              if (i == index) {
                UIView *v = collectionView.subviews[i];
                [v enumerateAllSubviewsUsingBlock:^(__kindof UIView *subview) {
                  if ([subview
                          isKindOfClass:NSClassFromString(
                                            @"_UIAlertControllerActionView")]) {
                    for (UIView *tempV in subview.subviews) {
                      if ([tempV isKindOfClass:[UIImageView class]] &&
                          tempV.hidden) {
                        tempV.hidden = NO;
                      }
                    }
                  }
                }];
                break;
              }
            }
          }
        }
      }];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {

  if (selectedIndex != 1024) {
    [UIAlertController
        mz_applyCustomStyleForAlertControllerClass:[UIAlertController class]];
  }
  objc_setAssociatedObject(self, @selector(selectedIndex), @(selectedIndex),
                           OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSUInteger)selectedIndex {
  return
      [objc_getAssociatedObject(self, @selector(selectedIndex)) integerValue];
}

@end

@implementation UIView (INSRecursiveSubviews)

- (void)enumerateAllSubviewsUsingBlock:
    (void (^)(__kindof UIView *subview))block {
  block(self);
  [self.subviews
      enumerateObjectsUsingBlock:^(__kindof UIView *_Nonnull obj,
                                   NSUInteger idx, BOOL *_Nonnull stop) {
        [obj enumerateAllSubviewsUsingBlock:block];
      }];
}

- (BOOL)isAnySuperviewUntilView:(UIView *)view isKindOfClass:(Class) class {
  UIView *superview = self.superview;
  do {
    if (superview == view) {
      return NO;
    }
    if ([superview isKindOfClass:class]) {
      return YES;
    }
    superview = superview.superview;
  } while (superview);

  return NO;
}

@end
