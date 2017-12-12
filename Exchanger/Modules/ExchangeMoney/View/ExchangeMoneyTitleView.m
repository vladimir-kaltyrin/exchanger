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
        
        self.titleLabel.layer.cornerRadius = 5.5;
        self.titleLabel.layer.backgroundColor = [UIColor whiteColor].CGColor;
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

- (void)setExchangeSourceCurrency:(Currency *)sourceCurrency
                   targetCurrency:(Currency *)targetCurrency
{
    if ((sourceCurrency == nil) || (targetCurrency == nil)) {
        return;
    }
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] init];
    
    AttributedStringStyle *stringStyle = [[AttributedStringStyle alloc] init];
    stringStyle.font = [UIFont systemFontOfSize:18];
    stringStyle.foregroundColor = [UIColor blackColor];
    
    NSString *sourceCurrencySign = sourceCurrency.currencySign;
    NSString *sourceText = [NSString stringWithFormat:@"%@1 - ", sourceCurrencySign];
    
    NSAttributedString *sourceCurrencyText = [[NSAttributedString alloc] initWithString:sourceText attributes:stringStyle.attributes];
    [string appendAttributedString:sourceCurrencyText];
    
    NSAttributedString *targetCurrencySignText = [[NSAttributedString alloc] initWithString:targetCurrency.currencySign attributes:stringStyle.attributes];
    [string appendAttributedString:targetCurrencySignText];
    
    NSString *targetText = [NSString stringWithFormat:@"%@",
                            targetCurrency.rate.stringValue];
    
    NSAttributedString *targetCurrencyText = [self.currentBalanceFormatter format:targetText].formattedString;
    [string appendAttributedString:targetCurrencyText];
    
    self.titleLabel.attributedText = string;
}

@end
