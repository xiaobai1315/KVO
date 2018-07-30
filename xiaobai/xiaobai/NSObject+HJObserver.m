//
//  NSObject+HJObserver.m
//  xiaobai
//
//  Created by Jermy on 2018/7/27.
//  Copyright © 2018年 Jermy. All rights reserved.
//

#import "NSObject+HJObserver.h"
#import <objc/message.h>
static id obj;
#import "Person.h"

@implementation NSObject (HJObserver)

- (void)HJAddObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context
{
    //保存被监听的对象，也就是对象p
    objc_setAssociatedObject(self, "observered", self, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    //保存监听者对象,为了回调监听者对象的监听方法
    objc_setAssociatedObject(self, "observer", observer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    //创建继承自[self class]的子类
    Class newCls = objc_allocateClassPair([self class], "NSKVONotifying_Person", 0);
    
    //添加set方法
    class_addMethod(newCls, @selector(setName:), (IMP)setName, "v@:@");
    class_addMethod(newCls, @selector(setAge:), (IMP)setAge, "v@:i");
    
    //注册类
    objc_registerClassPair(newCls);
    
    //修改当前对象的isa指针指向新生成的类
    object_setClass(self, newCls);
    
    //C++ 代码中不能使用self,
    obj = self;
}

void setAge(id self, SEL selector,  int age) {
    
    id observer = objc_getAssociatedObject(obj, "observer");
    id observered = objc_getAssociatedObject(obj, "observered");
    
    //    observered保存的是被监听的对象，这里可以转成具体对象类型，拿到对象之前的值
    Person *p = (Person *)observered;
    int oldAge = p.age;
    NSDictionary *change = @{NSKeyValueChangeNewKey : @(age),
                             NSKeyValueChangeOldKey : @(oldAge)
                             };
    
    //回调监听者对象的observeValueForKeyPath方法
    ((void (*)(id, SEL, NSString *, id, NSDictionary *, void *))objc_msgSend)(observer, @selector(observeValueForKeyPath:ofObject:change:context:), @"age", observered, change, nil);
}

void setName(id self, SEL selector, NSString *name) {
    
    id observer = objc_getAssociatedObject(obj, "observer");
    id observered = objc_getAssociatedObject(obj, "observered");
    
    Person *p = (Person *)observered;
    NSString *oldName = p.name;
    
    NSDictionary *change = @{NSKeyValueChangeNewKey : name,
                             NSKeyValueChangeOldKey : oldName
                             };
    
    //回调监听者对象的observeValueForKeyPath方法
    ((void (*)(id, SEL, NSString *, id, NSDictionary *, void *))objc_msgSend)(observer, @selector(observeValueForKeyPath:ofObject:change:context:), @"name", observered, change, nil);
}

@end
