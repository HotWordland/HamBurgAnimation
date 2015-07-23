//
//  HamburgAniView.h
//  LearnQuartCode
//
//  Created by Ronaldinho on 15/7/22.
//  Copyright (c) 2015年 HotWordLand. All rights reserved.
//

#import <UIKit/UIKit.h>
IB_DESIGNABLE

@interface HamburgAniView : UIView

- (void)addAnimationToMoreAnimation;
- (void)addAnimationToMoreAnimationCompletionBlock:(void (^)(BOOL finished))completionBlock;
- (void)removeAnimationsForAnimationId:(NSString *)identifier;
- (void)addAnimationToCancleAnimation;
- (void)addAnimationToCancleAnimationCompletionBlock:(void (^)(BOOL finished))completionBlock;

@end
