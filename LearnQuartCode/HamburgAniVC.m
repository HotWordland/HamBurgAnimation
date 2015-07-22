//
//  HamburgAniVC.m
//  LearnQuartCode
//
//  Created by Ronaldinho on 15/7/22.
//  Copyright (c) 2015年 HotWordLand. All rights reserved.
//

#import "HamburgAniVC.h"
#import "HamburgAniView.h"
@interface HamburgAniVC ()
{
    BOOL isDone;
}
@property (weak, nonatomic) IBOutlet HamburgAniView *hamburgView;

@end

@implementation HamburgAniVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [_hamburgView addHamburgAnimationWLAnimation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)clickStart:(id)sender {
    if (isDone) {
        isDone = NO;
        [(UIButton *)sender setTitle:@"start" forState:UIControlStateNormal];
        [_hamburgView addAnimationToCancleAnimation];
        return;
    }
    isDone = YES;
    [(UIButton *)sender setTitle:@"back" forState:UIControlStateNormal];
    [_hamburgView addHamburgAnimationWLAnimation];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
