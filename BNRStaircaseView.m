//
//  BNRStaircaseView.m
//  FeelTheBurn
//
//  Created by Richmond on 12/15/14.
//  Copyright (c) 2014 Jonathan Blocksom. All rights reserved.
//

#import "BNRStaircaseView.h"
#import "BNRStaircaseLayer.h"
@implementation BNRStaircaseView

+ (Class)layerClass {
    return [BNRStaircaseLayer class];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.layer.backgroundColor = [UIColor clearColor].CGColor;
    }
    return self;
}


@end
