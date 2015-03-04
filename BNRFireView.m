//
//  BNRFireView.m
//  FeelTheBurn
//
//  Created by Richmond on 12/15/14.
//  Copyright (c) 2014 Jonathan Blocksom. All rights reserved.
//

#import "BNRFireView.h"

@implementation BNRFireView

+ (Class)layerClass {
    return [CAEmitterLayer class];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        CAEmitterLayer *particleLayer = (CAEmitterLayer *)self.layer;
        particleLayer.emitterPosition = CGPointMake(CGRectGetMidX(self.bounds), self.bounds.size.height);
        particleLayer.emitterSize = CGSizeMake(300, 0);
        particleLayer.emitterShape = kCAEmitterLayerLine;
        particleLayer.backgroundColor = [UIColor clearColor].CGColor;
    }

    return self;
}

- (void)startBurn{
    CAEmitterCell *cell = [[CAEmitterCell alloc] init];
    cell.contents = (__bridge id)[UIImage imageNamed:@"flameParticle.png"].CGImage;
    cell.birthRate = 200;
    cell.lifetime = 1.5;
    cell.lifetimeRange = 0.8;
    cell.velocity = 100;
    cell.velocityRange = 20;
    cell.emissionRange = M_PI/6.0;
    cell.emissionLongitude = 0.0;
    cell.redRange = 0.0;
    cell.redSpeed = 0.0;
    cell.greenRange = 0.3;
    cell.blueRange = 0.3;
    cell.alphaSpeed = 0.0;
    cell.scaleSpeed = -0.5;
    cell.spin = M_PI_2;
    cell.color = [UIColor colorWithRed:1.0 green:0.7 blue:0.3 alpha:0.5].CGColor;
    cell.name = @"fire";

    cell.scale = 1.0;
    cell.scaleRange = 0.25;
    ((CAEmitterLayer *)self.layer).emitterCells = @[cell];

    UIInterpolatingMotionEffect *fireMove = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"layer.emitterCells.fire.velocity" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    fireMove.minimumRelativeValue = @1.0;
    fireMove.maximumRelativeValue = @200.0;
    [self addMotionEffect:fireMove];
}

- (void)stopBurn {
    ((CAEmitterLayer *)self.layer).emitterCells = nil;
}

@end
