#import "IntroView.h"
#import "UIView+Properties.h"
#import "SafeBlocks.h"

@interface IntroView()
@property (nonatomic, strong) UIButton *resetButton;
@property (nonatomic, strong) UIButton *startButton;
@property (nonatomic, strong) UIStackView *horizontalStackView;
@property (nonatomic, strong) UIStackView *stackView;
@end

@implementation IntroView

// MARK: - Init

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
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
    
    CGSize buttonSize = CGSizeMake(160, 60);
    
    self.resetButton.size = buttonSize;
    self.resetButton.centerX = self.centerX;
    self.resetButton.centerY = self.centerY - buttonSize.height;
    
    self.startButton.size = self.resetButton.size;
    self.startButton.centerX = self.centerX;
    self.startButton.top = self.resetButton.bottom + 20.f;
}

// MARK: - Public

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
