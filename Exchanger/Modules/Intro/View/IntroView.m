#import "IntroView.h"
#import "UIView+Properties.h"
#import "SafeBlocks.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface IntroView()
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIView *overlayView;
@property (nonatomic, strong) UIVisualEffectView *visualEffectView;
@property (nonatomic, strong) UIButton *resetButton;
@property (nonatomic, strong) UIButton *startButton;
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation IntroView

// MARK: - Init

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.backgroundImageView setImageWithURL:[NSURL URLWithString:@"https://picsum.photos/800/600"]];
        [self addSubview:self.backgroundImageView];
        
        self.overlayView = [[UIView alloc] initWithFrame:CGRectZero];
        self.overlayView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.5];
        [self addSubview:self.overlayView];
        
        self.visualEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
        [self addSubview:self.visualEffectView];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.font = [UIFont systemFontOfSize:34];
        self.titleLabel.numberOfLines = 2;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.titleLabel];
        
        self.resetButton = [[UIButton alloc] init];
        self.resetButton.backgroundColor = [UIColor blackColor];
        [self.resetButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.resetButton addTarget:self
                             action:@selector(onResetButtonTap:)
                   forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.resetButton];
        
        self.startButton = [[UIButton alloc] init];
        self.startButton.backgroundColor = [UIColor blackColor];
        [self.startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.startButton addTarget:self
                             action:@selector(onStartButtonTap:)
                   forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.startButton];
    }
    
    return self;
}

// MARK: - Layout

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.backgroundImageView.frame = self.bounds;
    self.overlayView.frame = self.bounds;
    self.visualEffectView.frame = self.bounds;
    
    CGSize buttonSize = CGSizeMake(160, 60);
    
    self.titleLabel.size = [self.titleLabel sizeThatFits:self.bounds.size];
    self.titleLabel.center = self.center;
    
    self.startButton.size = buttonSize;
    self.startButton.centerX = self.centerX;
    self.startButton.bottom = self.bottom - 20.f;
    
    self.resetButton.size = buttonSize;
    self.resetButton.centerX = self.centerX;
    self.resetButton.bottom = self.startButton.top - 20.f;
}

// MARK: - Public

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
}

- (void)setResetButtonTitle:(NSString *)resetButtonTitle {
    [self.resetButton setTitle:resetButtonTitle forState:UIControlStateNormal];
}

- (void)setStartButtonTitle:(NSString *)startButtonTitle {
    [self.startButton setTitle:startButtonTitle forState:UIControlStateNormal];
}

// MARK: - Actions

- (void)onResetButtonTap:(UIButton *)sender {
    block(self.onResetTap);
}

- (void)onStartButtonTap:(UIButton *)sender {
    block(self.onStartTap);
}

@end
