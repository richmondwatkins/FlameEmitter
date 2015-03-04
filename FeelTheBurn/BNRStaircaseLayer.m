//
//  BNRStaircaseLayer.m
//  FeelTheBurn
//
//  Created by Richmond on 12/15/14.
//  Copyright (c) 2014 Jonathan Blocksom. All rights reserved.
//

#import "BNRStaircaseLayer.h"

@interface BNRStaircaseLayer ()

@end

@implementation BNRStaircaseLayer

- (id)init {
    NSLog(@"init stair layer");
    self = [super init];

    if (self) {
        _stepCount = 11;
        self.needsDisplayOnBoundsChange = YES;
    }
    return self;
}

- (void)drawInContext:(CGContextRef)ctx{
    NSLog(@"Draw that layer");
    UIGraphicsPushContext(ctx);

    CGSize currentSize = self.bounds.size;
    CGFloat stepHeight = currentSize.height / self.stepCount;
    CGFloat stepWidth = currentSize.width / self.stepCount;

    UIBezierPath *stepPath = [UIBezierPath bezierPath];
    //start at lower left
    CGPoint currentPoint = CGPointMake(0.0, currentSize.height - 3.0);
    [stepPath moveToPoint:currentPoint];
    for (int i = 0; i < self.stepCount; i++) {
        currentPoint.x += stepWidth;
        [stepPath addLineToPoint:currentPoint];
        currentPoint.y -= stepHeight;
        [stepPath addLineToPoint:currentPoint];
    }
    stepPath.lineWidth = 3.0;
    [[UIColor blackColor] setStroke];
    [stepPath stroke];

    //Draw dot
    CGPoint center = CGPointMake(stepWidth * (self.dottedStepIndex + 0.5), stepHeight * (self.stepCount - self.dottedStepIndex - 0.5));
    CGFloat dotSize = stepHeight / 4.0;
    UIBezierPath *dotPath = [UIBezierPath bezierPathWithArcCenter:center radius:dotSize startAngle:0.0 endAngle:2.0 * M_PI clockwise:YES];
    [dotPath fill];

    UIGraphicsPopContext()
    ;
}

- (id)initWithLayer:(id)layer{
    self = [super initWithLayer:layer];
    if (self) {
        if ([self isKindOfClass:[BNRStaircaseLayer class]]) {
            BNRStaircaseLayer *copyFrom = layer;
            _stepCount = copyFrom.stepCount;
            _dottedStepIndex = copyFrom.dottedStepIndex;
            self.frame = copyFrom.frame;
        }
    }
    return self;
}

//tells system to redraw for changes in the number of stairs or the dot position and sends the message
//up the inheritance chain for an answer to the other keys
+ (BOOL)needsDisplayForKey:(NSString *)key{
    if ([key isEqualToString:@"stepCount"]) {
        return YES;
    }
    if ([key isEqualToString:@"dottedStepIndex"]) {
        return YES;
    }

    return [super needsDisplayForKey:key];
}

@end
