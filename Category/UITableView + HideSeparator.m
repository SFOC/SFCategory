//
//  UITableView + HideSeparator.m
//  OA
//
//  Created by mac on 16/7/25.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "UITableView + HideSeparator.h"
#import <objc/runtime.h>


@implementation UITableView(HideSeparator)

+(void)hideSeparotorLine{
    method_exchangeImplementations(class_getInstanceMethod([UITableView class], @selector(layoutSubviews)), class_getInstanceMethod([UITableView class], @selector(hackedlayoutSubviews)));

}
-(void)hackedlayoutSubviews{
    [self hackedlayoutSubviews];
    BOOL (^needHide)(UIView * ) = ^(UIView * subView){
        BOOL hide =  ([NSStringFromClass(subView.class) hasSuffix:@"SeparatorView"] && !subView.hidden);
        return hide;
    };
    
    if( self.style == UITableViewStyleGrouped){
        for(NSInteger i =0;i<self.numberOfSections;i++){
            NSInteger rows = [self numberOfRowsInSection:i];
            for(NSInteger j =0;j<rows;j++){
                
                NSIndexPath * indexPath =[NSIndexPath indexPathForRow:j inSection:i];
                UITableViewCell * cell = [self cellForRowAtIndexPath:indexPath];
                
                if (rows>1) {
                    for (UIView *subview in cell.subviews) {
                        if (needHide(subview)) {
                            
                            if(j==0 && subview.frame.origin.y ==0){
                          
                                subview.hidden = YES;
                            }
                            if(j==rows-1 &&  CGRectGetMaxY(subview.frame) == CGRectGetHeight(cell.frame) ){
                              
                                subview.hidden = YES;
                            }
                        }
                    }
                }
                else{
                    for (UIView *subview in cell.subviews) {
                        if (needHide(subview)) {
                            
                            subview.hidden = YES;
                        }
                    }
                }
            }
            
        }
        
    }
    
}

@end
