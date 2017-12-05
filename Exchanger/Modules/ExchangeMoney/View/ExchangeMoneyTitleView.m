#import "ExchangeMoneyTitleView.h"
#import "FormatterFactoryImpl.h"
#import "AttributedStringStyle.h"

@interface ExchangeMoneyTitleView()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) id<NumbersFormatter> numbersFormatter;
@property (nonatomic, strong) id<BalanceFormatter> currentBalanceFormatter;
@end

@implementation ExchangeMoneyTitleView

// MARK: - Init

- (instancetype)init {
    if (self = [super init]) {
        self.numbersFormatter = [[FormatterFactoryImpl instance] numbersFormatter];
        self.currentBalanceFormatter = [[FormatterFactoryImpl instance] currentBalanceFormatter];
        
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

// MARK: - Layout

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.titleLabel.frame = self.bounds;
}

- (CGSize)sizeThatFits:(CGSize)size {
    return [self.titleLabel sizeThatFits:size];
}

// MARK: - Public

- (void)setExchangeSourceCurrency:(NSString *)sourceCurrency
                   targetCurrency:(NSString *)targetCurrency
{
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] init];
    
    AttributedStringStyle *stringStyle = [[AttributedStringStyle alloc] init];
    stringStyle.font = [UIFont systemFontOfSize:18];
    stringStyle.foregroundColor = [UIColor blackColor];
    
    NSString *formattedString = [NSString stringWithFormat:@"%@ - ", sourceCurrency];
    
    NSAttributedString *sourceCurrencyText = [[NSAttributedString alloc] initWithString:formattedString attributes:stringStyle.attributes];
    [string appendAttributedString:sourceCurrencyText];
    
    NSString *numberText = [self.numbersFormatter format:targetCurrency];
    NSAttributedString *targetCurrencyText = [self.currentBalanceFormatter attributedFormatBalance:numberText];
    [string appendAttributedString:targetCurrencyText];
    
    self.titleLabel.attributedText = string;
}

@end
