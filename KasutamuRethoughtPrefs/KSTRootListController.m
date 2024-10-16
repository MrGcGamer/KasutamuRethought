#import "KSTRootListController.h"

@implementation KSTRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	}

	return _specifiers;
}

@end

@interface KSTImageCell : PSTableCell
@end

@implementation KSTImageCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier {
  [specifier setProperty:@200 forKey:@"height"];
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier specifier:specifier];

	UIImageView *imageView = [UIImageView new];
	imageView.contentMode = UIViewContentModeScaleAspectFill;
	[self.contentView addSubview:imageView];

	imageView.translatesAutoresizingMaskIntoConstraints = NO;
	[NSLayoutConstraint activateConstraints:@[
		[self.topAnchor constraintEqualToAnchor:imageView.topAnchor constant:0],
		[self.leadingAnchor constraintEqualToAnchor:imageView.leadingAnchor constant:0],
		[self.bottomAnchor constraintEqualToAnchor:imageView.bottomAnchor constant:0],
		[self.trailingAnchor constraintEqualToAnchor:imageView.trailingAnchor constant:0]
	]];
	imageView.image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",[[[specifier target] bundle] bundlePath],@"Icons/Banner.png"]];

  return self;
}
@end