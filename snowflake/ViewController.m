//
//  ViewController.m
//  snowflake
//

#import "ViewController.h"
//雪花量1秒钟生成数量
#define SNOW_COUNT 10
//雪花的尺寸（10~10*2）
#define SNOW_SIZE 10
//雪花的融化时间（3~3*2）
#define SNOW_MELTTIME 3




@interface ViewController ()
@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) NSString *imageName;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //雪花生成的计时器
    [NSTimer scheduledTimerWithTimeInterval:1.0/SNOW_COUNT target:self selector:@selector(snowFlake:) userInfo:nil repeats:YES];
}
-(void)snowFlake:(NSTimer *)timer{
    UIImageView *snowView = [self imageV];
    //雪花落到地面的时间
    NSInteger flakeSpeed = arc4random() % 5 + 3;
    [UIView animateWithDuration:flakeSpeed animations:^{
        
        snowView.center = CGPointMake(snowView.center.x, self.view.frame.size.height - 50);
        //自由旋转
        CGFloat angle = arc4random() % 360 * 5;
        snowView.transform = CGAffineTransformRotate(snowView.transform, M_PI / 180 * angle);
    } completion:^(BOOL finished) {
        //雪花融化时间
        NSInteger meltTime = arc4random() % SNOW_MELTTIME + SNOW_MELTTIME;
        [UIView animateWithDuration:meltTime delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            snowView.alpha = 0;
        } completion:^(BOOL finished) {
            //移除雪花
            [snowView removeFromSuperview];
        }];
    }];
    
}

//创建雪花
- (UIImageView *)imageV {
    _imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:self.imageName]];
    [self.view addSubview:_imageV];
    
    CGFloat size = arc4random() % SNOW_SIZE + SNOW_SIZE;
    //控制不超出右边屏幕
    NSInteger width = self.view.frame.size.width - size;
    //雪花的初始位置和大小
    _imageV.frame = CGRectMake(arc4random() % width, -size, size, size);
    return _imageV;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)imageName {
    _imageName = [NSString stringWithFormat:@"%d", arc4random()%28];
    return _imageName;
}

@end
















