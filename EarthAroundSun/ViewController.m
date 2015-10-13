//
//  ViewController.m
//  EarthAroundSun
//
//  Created by Do Minh Hai on 10/13/15.
//  Copyright (c) 2015 Do Minh Hai. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSTimer* timer;
    UIImageView* sun;
    UIImageView* earth;
    UIImageView* moon;
    CGPoint sunCenter;
    CGFloat distanceEarthToSun;
    CGFloat distanceMoonToEarth;
    CGFloat angle;
    
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self addSunAndEarthAndMoon];
    timer = [NSTimer scheduledTimerWithTimeInterval:0.0167 target:self selector:@selector(spinEarthAndMoon) userInfo:nil repeats:true];
}
-(void) addSunAndEarthAndMoon
{
    sun = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sun.png"]];
    earth = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"earth2.png"]];
    moon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"moon.png"]];
    CGSize mainViewSize = self.view.bounds.size;
    CGFloat statusNavigationBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.bounds.size.height;
    sunCenter = CGPointMake(mainViewSize.width * 0.5, (mainViewSize.height + statusNavigationBarHeight) * 0.5);
    distanceMoonToEarth = 40;
    distanceEarthToSun = mainViewSize.width * 0.5 - 40.0;
    sun.center = sunCenter;
    angle= 0.0;
    earth.center = [self computePositionEarth:angle];
    moon.center = [self computePositionMoon:angle];
    [self.view addSubview:sun];
    [self.view addSubview:earth];
    [self.view addSubview:moon];
}

-(CGPoint) computePositionEarth: (CGFloat) _angle
{
    return CGPointMake(sunCenter.x + distanceEarthToSun* cos(angle),
                       sunCenter.y + distanceEarthToSun* sin(angle));
}
-(CGPoint) computePositionMoon: (CGFloat) _angle
{
    return CGPointMake(earth.center.x + distanceMoonToEarth* cos(angle*13.3),
                       earth.center.y + distanceMoonToEarth* sin(angle*13.3));
}
-(void) spinEarthAndMoon
{
    angle += 0.01;
    earth.center = [self computePositionEarth:angle];
    moon.center = [self computePositionMoon:angle];
}
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [UIView animateWithDuration:0.5 animations:^{
        self->sun.alpha = 0.90;
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            
            self->sun.alpha = 1;
            
        } completion:^(BOOL finished) {
            [self viewWillAppear:(BOOL)animated];
        }];
    }];
}
@end
