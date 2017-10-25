#import "ExchangeMoneyTitleView.h"

@interface ExchangeMoneyTitleView()
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation ExchangeMoneyTitleView

- (instancetype)init {
    if (self = [super init]) {
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.titleLabel];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        
        self.titleLabel.layer.cornerRadius = 3.5;
        self.titleLabel.layer.borderWidth = 2.0;
        self.titleLabel.layer.borderColor = [UIColor blueColor].CGColor;
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
    
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.titleLabel.frame = self.bounds;
}


@end
