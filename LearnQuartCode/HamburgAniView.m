//
//  HamburgAniView.m
//  LearnQuartCode
//
//  Created by Ronaldinho on 15/7/22.
//  Copyright (c) 2015年 HotWordLand. All rights reserved.
//

#import "HamburgAniView.h"
#import "QCMethod.h"

@interface HamburgAniView ()

@property (nonatomic, strong) NSMutableDictionary * layers;
@property (nonatomic, strong) NSMapTable * completionBlocks;
@property (nonatomic, assign) BOOL  updateLayerValueForCompletedAnimation;


@end

@implementation HamburgAniView

#pragma mark - Life Cycle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupProperties];
        [self setupLayers];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupProperties];
        [self setupLayers];
    }
    return self;
}



- (void)setupProperties{
    self.completionBlocks = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsOpaqueMemory valueOptions:NSPointerFunctionsStrongMemory];;
    self.layers = [NSMutableDictionary dictionary];
    
}

- (void)setupLayers{
    CAShapeLayer * oval = [CAShapeLayer layer];
    oval.frame = CGRectMake(79.16, 174.2, 143.59, 147.59);
    oval.path = [self ovalPath].CGPath;
    [self.layer addSublayer:oval];
    self.layers[@"oval"] = oval;
    
    CAShapeLayer * oval2 = [CAShapeLayer layer];
    oval2.frame = CGRectMake(112.5, 174.2, 102.97, 147.59);
    oval2.path = [self oval2Path].CGPath;
    [self.layer addSublayer:oval2];
    self.layers[@"oval2"] = oval2;
    
    CAShapeLayer * path = [CAShapeLayer layer];
    path.frame = CGRectMake(110.95, 247.57, 80, 0.87);
    path.path = [self pathPath].CGPath;
    [self.layer addSublayer:path];
    self.layers[@"path"] = path;
    
    CAShapeLayer * path2 = [CAShapeLayer layer];
    path2.frame = CGRectMake(110.95, 247.57, 80, 0.87);
    path2.path = [self path2Path].CGPath;
    [self.layer addSublayer:path2];
    self.layers[@"path2"] = path2;
    [self resetLayerPropertiesForLayerIdentifiers:nil];
}

- (void)resetLayerPropertiesForLayerIdentifiers:(NSArray *)layerIds{
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    
    if(!layerIds || [layerIds containsObject:@"oval"]){
        CAShapeLayer * oval = self.layers[@"oval"];
        oval.lineCap     = kCALineCapRound;
        oval.fillColor   = nil;
        oval.strokeColor = [UIColor purpleColor].CGColor;
        oval.lineWidth   = 14;
        oval.strokeEnd   = 1;
    }
    if(!layerIds || [layerIds containsObject:@"oval2"]){
        CAShapeLayer * oval2 = self.layers[@"oval2"];
        oval2.lineCap     = kCALineCapRound;
        oval2.fillColor   = nil;
        oval2.strokeColor = [UIColor purpleColor].CGColor;
        oval2.lineWidth   = 14;
        oval2.strokeEnd   = 0;
    }
    if(!layerIds || [layerIds containsObject:@"path"]){
        CAShapeLayer * path = self.layers[@"path"];
        [path setValue:@(-45 * M_PI/180) forKeyPath:@"transform.rotation"];
        path.lineCap     = kCALineCapRound;
        path.fillColor   = nil;
        path.strokeColor = [UIColor purpleColor].CGColor;
        path.lineWidth   = 14;
    }
    if(!layerIds || [layerIds containsObject:@"path2"]){
        CAShapeLayer * path2 = self.layers[@"path2"];
        [path2 setValue:@(45 * M_PI/180) forKeyPath:@"transform.rotation"];
        path2.lineCap     = kCALineCapRound;
        path2.fillColor   = nil;
        path2.strokeColor = [UIColor purpleColor].CGColor;
        path2.lineWidth   = 14;
    }
    
    [CATransaction commit];
}

#pragma mark - Animation Setup

- (void)addHamburgAnimationWLAnimation{
    [self addHamburgAnimationWLAnimationCompletionBlock:nil];
}

- (void)addHamburgAnimationWLAnimationCompletionBlock:(void (^)(BOOL finished))completionBlock{
    if (completionBlock){
        CABasicAnimation * completionAnim = [CABasicAnimation animationWithKeyPath:@"completionAnim"];;
        completionAnim.duration = 0.341;
        completionAnim.delegate = self;
        [completionAnim setValue:@"HamburgAnimationWL" forKey:@"animId"];
        [completionAnim setValue:@(NO) forKey:@"needEndAnim"];
        [self.layer addAnimation:completionAnim forKey:@"HamburgAnimationWL"];
        [self.completionBlocks setObject:completionBlock forKey:[self.layer animationForKey:@"HamburgAnimationWL"]];
    }
    
    NSString * fillMode = kCAFillModeForwards;
    
    ////Oval animation
    CABasicAnimation * ovalStrokeEndAnim = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    ovalStrokeEndAnim.fromValue          = @1;
    ovalStrokeEndAnim.toValue            = @-0.1;
    ovalStrokeEndAnim.duration           = 0.341;
    
    CAAnimationGroup * ovalHamburgAnimationWLAnim = [QCMethod groupAnimations:@[ovalStrokeEndAnim] fillMode:fillMode];
    [self.layers[@"oval"] addAnimation:ovalHamburgAnimationWLAnim forKey:@"ovalHamburgAnimationWLAnim"];
    
    ////Oval2 animation
    CABasicAnimation * oval2StrokeEndAnim = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    oval2StrokeEndAnim.fromValue          = @0;
    oval2StrokeEndAnim.toValue            = @1;
    oval2StrokeEndAnim.duration           = 0.166;
    oval2StrokeEndAnim.beginTime          = 0.307;
    
    ////Oval2 animation
    CABasicAnimation * oval2StrokeStartAnim = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    oval2StrokeStartAnim.fromValue = @0;
    oval2StrokeStartAnim.toValue   = @0.63;
    oval2StrokeStartAnim.duration  = 0.19;
    oval2StrokeStartAnim.beginTime = 0.386;
    
    CAAnimationGroup * oval2HamburgAnimationWLAnim = [QCMethod groupAnimations:@[oval2StrokeEndAnim, oval2StrokeStartAnim] fillMode:fillMode];
    [self.layers[@"oval2"] addAnimation:oval2HamburgAnimationWLAnim forKey:@"oval2HamburgAnimationWLAnim"];
    
    ////Path animation
    CABasicAnimation * pathTransformAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
    pathTransformAnim.fromValue          = [NSValue valueWithCATransform3D:CATransform3DConcat(CATransform3DMakeScale(0.95, 1, 1), CATransform3DMakeRotation(-M_PI_4, 0, 0, 1))];;
    pathTransformAnim.toValue            = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, -31, -9)];;
    pathTransformAnim.duration           = 0.276;
    pathTransformAnim.beginTime          = 0.324;
    pathTransformAnim.timingFunction     = [CAMediaTimingFunction functionWithControlPoints:0.42 :0 :0.85 :1.67];
    
    CAAnimationGroup * pathHamburgAnimationWLAnim = [QCMethod groupAnimations:@[pathTransformAnim] fillMode:fillMode];
    [self.layers[@"path"] addAnimation:pathHamburgAnimationWLAnim forKey:@"pathHamburgAnimationWLAnim"];
    
    ////Path2 animation
    CABasicAnimation * path2TransformAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
    path2TransformAnim.fromValue          = [NSValue valueWithCATransform3D:CATransform3DConcat(CATransform3DMakeTranslation(0, 0, -2), CATransform3DMakeRotation(45 * M_PI/180, 0, -0, 1))];;
    path2TransformAnim.toValue            = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, 31, -3)];;
    path2TransformAnim.duration           = 0.276;
    path2TransformAnim.beginTime          = 0.324;
    path2TransformAnim.timingFunction     = [CAMediaTimingFunction functionWithControlPoints:0.42 :0 :0.793 :1.59];
    
    CAAnimationGroup * path2HamburgAnimationWLAnim = [QCMethod groupAnimations:@[path2TransformAnim] fillMode:fillMode];
    [self.layers[@"path2"] addAnimation:path2HamburgAnimationWLAnim forKey:@"path2HamburgAnimationWLAnim"];
}
- (void)addAnimationToCancleAnimation{
    [self addAnimationToCancleAnimationCompletionBlock:nil];
}

- (void)addAnimationToCancleAnimationCompletionBlock:(void (^)(BOOL finished))completionBlock{
    CAShapeLayer *Oval2 = self.layers[@"oval2"];
    [Oval2 setStrokeStart:0.63];
    [Oval2 setStrokeEnd:1];
    if (completionBlock){
        CABasicAnimation * completionAnim = [CABasicAnimation animationWithKeyPath:@"completionAnim"];;
        completionAnim.duration = 0.392;
        completionAnim.delegate = self;
        [completionAnim setValue:@"AnimationToCancle" forKey:@"animId"];
        [completionAnim setValue:@(NO) forKey:@"needEndAnim"];
        [self.layer addAnimation:completionAnim forKey:@"AnimationToCancle"];
        [self.completionBlocks setObject:completionBlock forKey:[self.layer animationForKey:@"AnimationToCancle"]];
    }
    
    NSString * fillMode = kCAFillModeForwards;
    
    ////Oval animation
    CABasicAnimation * ovalStrokeEndAnim = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    ovalStrokeEndAnim.fromValue          = @-0.1;
    ovalStrokeEndAnim.toValue            = @1;
    ovalStrokeEndAnim.duration           = 0.274;
    ovalStrokeEndAnim.beginTime          = 0.423;
    
    CAAnimationGroup * ovalAnimationToCancleAnim = [QCMethod groupAnimations:@[ovalStrokeEndAnim] fillMode:fillMode];
    [self.layers[@"oval"] addAnimation:ovalAnimationToCancleAnim forKey:@"ovalAnimationToCancleAnim"];
    
    ////Oval2 animation
    CABasicAnimation * oval2StrokeStartAnim = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    oval2StrokeStartAnim.fromValue = @0.63;
    oval2StrokeStartAnim.toValue   = @0;
    oval2StrokeStartAnim.duration  = 0.271;
    oval2StrokeStartAnim.beginTime = 0.0769;
    
    ////Oval2 animation
    CABasicAnimation * oval2StrokeEndAnim = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    oval2StrokeEndAnim.fromValue          = @1;
    oval2StrokeEndAnim.toValue            = @0;
    oval2StrokeEndAnim.duration           = 0.235;
    oval2StrokeEndAnim.beginTime          = 0.225;
    
    CAAnimationGroup * oval2AnimationToCancleAnim = [QCMethod groupAnimations:@[oval2StrokeStartAnim, oval2StrokeEndAnim] fillMode:fillMode];
    [self.layers[@"oval2"] addAnimation:oval2AnimationToCancleAnim forKey:@"oval2AnimationToCancleAnim"];
    
    ////Path animation
    CABasicAnimation * pathTransformAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
    pathTransformAnim.fromValue          = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, -31, 0)];;
    pathTransformAnim.toValue            = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_4, 0, 0, -1)];;
    pathTransformAnim.duration           = 0.392;
    pathTransformAnim.timingFunction     = [CAMediaTimingFunction functionWithControlPoints:0.42 :0 :0.85 :1.67];
    
    CAAnimationGroup * pathAnimationToCancleAnim = [QCMethod groupAnimations:@[pathTransformAnim] fillMode:fillMode];
    [self.layers[@"path"] addAnimation:pathAnimationToCancleAnim forKey:@"pathAnimationToCancleAnim"];
    
    ////Path2 animation
    CABasicAnimation * path2TransformAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
    path2TransformAnim.fromValue          = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, 31, 0)];;
    path2TransformAnim.toValue            = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(-45 * M_PI/180, 0, 0, -1)];;
    path2TransformAnim.duration           = 0.392;
    path2TransformAnim.timingFunction     = [CAMediaTimingFunction functionWithControlPoints:0.42 :0 :0.793 :1.59];
    
    CAAnimationGroup * path2AnimationToCancleAnim = [QCMethod groupAnimations:@[path2TransformAnim] fillMode:fillMode];
    [self.layers[@"path2"] addAnimation:path2AnimationToCancleAnim forKey:@"path2AnimationToCancleAnim"];

}


#pragma mark - Animation Cleanup

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    void (^completionBlock)(BOOL) = [self.completionBlocks objectForKey:anim];;
    if (completionBlock){
        [self.completionBlocks removeObjectForKey:anim];
        if ((flag && self.updateLayerValueForCompletedAnimation) || [[anim valueForKey:@"needEndAnim"] boolValue]){
            [self updateLayerValuesForAnimationId:[anim valueForKey:@"animId"]];
            [self removeAnimationsForAnimationId:[anim valueForKey:@"animId"]];
        }
        completionBlock(flag);
    }
}

- (void)updateLayerValuesForAnimationId:(NSString *)identifier{
    if([identifier isEqualToString:@"HamburgAnimationWL"]){
        [QCMethod updateValueFromPresentationLayerForAnimation:[self.layers[@"oval"] animationForKey:@"ovalHamburgAnimationWLAnim"] theLayer:self.layers[@"oval"]];
        [QCMethod updateValueFromPresentationLayerForAnimation:[self.layers[@"oval2"] animationForKey:@"oval2HamburgAnimationWLAnim"] theLayer:self.layers[@"oval2"]];
        [QCMethod updateValueFromPresentationLayerForAnimation:[self.layers[@"path"] animationForKey:@"pathHamburgAnimationWLAnim"] theLayer:self.layers[@"path"]];
        [QCMethod updateValueFromPresentationLayerForAnimation:[self.layers[@"path2"] animationForKey:@"path2HamburgAnimationWLAnim"] theLayer:self.layers[@"path2"]];
    }
    else if([identifier isEqualToString:@"AnimationToCancle"]){
        [QCMethod updateValueFromPresentationLayerForAnimation:[self.layers[@"oval"] animationForKey:@"ovalAnimationToCancleAnim"] theLayer:self.layers[@"oval"]];
        [QCMethod updateValueFromPresentationLayerForAnimation:[self.layers[@"oval2"] animationForKey:@"oval2AnimationToCancleAnim"] theLayer:self.layers[@"oval2"]];
        [QCMethod updateValueFromPresentationLayerForAnimation:[self.layers[@"path"] animationForKey:@"pathAnimationToCancleAnim"] theLayer:self.layers[@"path"]];
        [QCMethod updateValueFromPresentationLayerForAnimation:[self.layers[@"path2"] animationForKey:@"path2AnimationToCancleAnim"] theLayer:self.layers[@"path2"]];
    }

}

- (void)removeAnimationsForAnimationId:(NSString *)identifier{
    if([identifier isEqualToString:@"HamburgAnimationWL"]){
        [self.layers[@"oval"] removeAnimationForKey:@"ovalHamburgAnimationWLAnim"];
        [self.layers[@"oval2"] removeAnimationForKey:@"oval2HamburgAnimationWLAnim"];
        [self.layers[@"path"] removeAnimationForKey:@"pathHamburgAnimationWLAnim"];
        [self.layers[@"path2"] removeAnimationForKey:@"path2HamburgAnimationWLAnim"];
    }
    else if([identifier isEqualToString:@"AnimationToCancle"]){
        [self.layers[@"oval"] removeAnimationForKey:@"ovalAnimationToCancleAnim"];
        [self.layers[@"oval2"] removeAnimationForKey:@"oval2AnimationToCancleAnim"];
        [self.layers[@"path"] removeAnimationForKey:@"pathAnimationToCancleAnim"];
        [self.layers[@"path2"] removeAnimationForKey:@"path2AnimationToCancleAnim"];
    }
}

#pragma mark - Bezier Path

- (UIBezierPath*)ovalPath{
    UIBezierPath *ovalPath = [UIBezierPath bezierPath];
    [ovalPath moveToPoint:CGPointMake(71.794, 0)];
    [ovalPath addCurveToPoint:CGPointMake(0, 73.797) controlPoint1:CGPointMake(32.143, 0) controlPoint2:CGPointMake(0, 33.04)];
    [ovalPath addCurveToPoint:CGPointMake(71.794, 147.594) controlPoint1:CGPointMake(0, 114.554) controlPoint2:CGPointMake(32.143, 147.594)];
    [ovalPath addCurveToPoint:CGPointMake(143.588, 73.797) controlPoint1:CGPointMake(111.445, 147.594) controlPoint2:CGPointMake(143.588, 114.554)];
    [ovalPath addCurveToPoint:CGPointMake(71.794, 0) controlPoint1:CGPointMake(143.588, 33.04) controlPoint2:CGPointMake(111.445, 0)];
    
    return ovalPath;
}

- (UIBezierPath*)oval2Path{
    UIBezierPath *oval2Path = [UIBezierPath bezierPath];
    [oval2Path moveToPoint:CGPointMake(35.363, 0)];
    [oval2Path addCurveToPoint:CGPointMake(99.734, 45.465) controlPoint1:CGPointMake(65.248, 0) controlPoint2:CGPointMake(89.567, 18.769)];
    [oval2Path addCurveToPoint:CGPointMake(88.555, 72.809) controlPoint1:CGPointMake(103.056, 54.189) controlPoint2:CGPointMake(108.391, 72.707)];
    [oval2Path addLineToPoint:CGPointMake(0, 73.797)];
    [oval2Path moveToPoint:CGPointMake(35.363, 147.594)];
    
    return oval2Path;
}

- (UIBezierPath*)pathPath{
    UIBezierPath *pathPath = [UIBezierPath bezierPath];
    [pathPath moveToPoint:CGPointMake(0, 0.867)];
    [pathPath addCurveToPoint:CGPointMake(46.748, 0.36) controlPoint1:CGPointMake(11.687, 0.741) controlPoint2:CGPointMake(35.061, 0.487)];
    [pathPath addCurveToPoint:CGPointMake(80, 0) controlPoint1:CGPointMake(55.061, 0.27) controlPoint2:CGPointMake(71.687, 0.09)];
    
    return pathPath;
}

- (UIBezierPath*)path2Path{
    UIBezierPath *path2Path = [UIBezierPath bezierPath];
    [path2Path moveToPoint:CGPointMake(0, 0.867)];
    [path2Path addCurveToPoint:CGPointMake(46.748, 0.36) controlPoint1:CGPointMake(11.687, 0.741) controlPoint2:CGPointMake(35.061, 0.487)];
    [path2Path addCurveToPoint:CGPointMake(80, 0) controlPoint1:CGPointMake(55.061, 0.27) controlPoint2:CGPointMake(71.687, 0.09)];
    
    return path2Path;
}

@end
