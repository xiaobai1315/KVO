//
//  ViewController.m
//  xiaobai
//
//  Created by Jermy on 2018/7/26.
//  Copyright © 2018年 Jermy. All rights reserved.
//

#import "ViewController.h"
#import <objc/message.h>
#import <malloc/malloc.h>
#import "HJClass.h"
#import "NSObject+HJObserver.h"
#import "Person.h"

@interface ViewController ()
@property (nonatomic, strong) Person *p;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    Person *p = [[Person alloc] init];
    p.age = 12;
    p.height = 13;
    [p HJAddObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
    
//    [p addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];

    self.p = p;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.p.age = 20;
    self.p.name = @"ssssfff";
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"age"]) {
        NSLog(@"%@", [change valueForKey:NSKeyValueChangeNewKey]);
        NSLog(@"%@", [change valueForKey:NSKeyValueChangeOldKey]);
    }
}

-(void)dealloc
{
    [self.p removeObserver:self forKeyPath:@"age"];
}


@end
