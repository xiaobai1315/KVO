//
//  NSObject+HJObserver.h
//  xiaobai
//
//  Created by Jermy on 2018/7/27.
//  Copyright © 2018年 Jermy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (HJObserver)
- (void)HJAddObserver:(NSObject *_Nullable)observer forKeyPath:(NSString *_Nullable)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context;

//-(void)HJObserveValueForKeyPath:(NSString *_Nullable)keyPath ofObject:(id _Nullable )object change:(NSDictionary<NSKeyValueChangeKey,id> *_Nullable)change context:(void *_Nullable)context;
@end
