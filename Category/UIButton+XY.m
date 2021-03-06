//
//  __  __          ____           _          _
//  \ \/ / /\_/\   /___ \  _   _  (_)   ___  | | __
//   \  /  \_ _/  //  / / | | | | | |  / __| | |/ /
//   /  \   / \  / \_/ /  | |_| | | | | (__  |   <
//  /_/\_\  \_/  \___,_\   \__,_| |_|  \___| |_|\_\
//
//  Copyright (C) Heaven.
//
//	https://github.com/uxyheaven/XYQuick
//
//	Permission is hereby granted, free of charge, to any person obtaining a
//copy
//	of this software and associated documentation files (the "Software"), to
//deal
//	in the Software without restriction, including without limitation the
//rights
//	to use, copy, modify, merge, publish, distribute, sublicense, and/or
//sell
//	copies of the Software, and to permit persons to whom the Software is
//	furnished to do so, subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included
//in
//	all copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
//OR
//	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
//THE
//	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//FROM,
//	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
//IN
//	THE SOFTWARE.
//

#import "UIButton+XY.h"
#import <objc/runtime.h>
static const char * UIControl_acceptEventInterval = "UIControl_acceptEventInterval";
static const char * UIControl_acceptedEventTime = "UIControl_acceptedEventTime";
@implementation UIButton (XYExtension)
+ (void)load {
    

    Method originalMethod = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    Method newMethod = class_getInstanceMethod(self, @selector(__uxy_sendAction:to:forEvent:));
    
    BOOL methodAdded = class_addMethod([self class], @selector(sendAction:to:forEvent:),
                                       method_getImplementation(newMethod),
                                       method_getTypeEncoding(newMethod));
    if (methodAdded) {
        class_replaceMethod([self class],  @selector(__uxy_sendAction:to:forEvent:),
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, newMethod);
    }
}



- (NSTimeInterval)uxy_acceptEventInterval
{
    return [objc_getAssociatedObject(self, UIControl_acceptEventInterval)
            doubleValue];
}

- (void)setUxy_acceptEventInterval:(NSTimeInterval)uxy_acceptEventInterval
{
    objc_setAssociatedObject(self, UIControl_acceptEventInterval,
                             @(uxy_acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (NSTimeInterval)uxy_acceptedEventTime
{
    return [objc_getAssociatedObject(self, UIControl_acceptedEventTime)
            doubleValue];
}

- (void)setUxy_acceptedEventTime:(NSTimeInterval)uxy_acceptedEventTime
{
    objc_setAssociatedObject(self, UIControl_acceptedEventTime,
                             @(uxy_acceptedEventTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)__uxy_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    
    if([self isKindOfClass:[UIButton class]]){
        if (NSDate.date.timeIntervalSince1970 - self.uxy_acceptedEventTime <
            self.uxy_acceptEventInterval){
            return;
        }
        if (self.uxy_acceptEventInterval > 0){
            self.uxy_acceptedEventTime = NSDate.date.timeIntervalSince1970;
        }
    }
    [self __uxy_sendAction:action to:target forEvent:event];
   
}

@end
