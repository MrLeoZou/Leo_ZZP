//
//  Deal.m
///

#import "TGDeal.h"
#import "NSString+ZP.h"
#import "TGRestriction.h"
#import "NSObject+Value.h"
#import "TGBusiness.h"
#import "TGCategory.h"
#import "TGDistrict.h"

@implementation TGDeal

+ (NSDictionary *)objectClassInArray
{

    return @{@"regions":[TGDistrict class],@"businesses":[TGBusiness class]};
}

// 实现这个方法的目的：告诉MJExtension框架模型中的属性名对应着字典的哪个key
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"ID" : @"id",
             @"desc" : @"description"
             };
}

//内部把double装成字符串，提供给外界使用
- (void)setList_price:(double)list_price
{
    _list_price = list_price;
    
    _list_price_text = [NSString stringWithDouble:list_price fractionCount:2];
}

- (void)setCurrent_price:(double)current_price
{
    _current_price = current_price;
    
    _current_price_text = [NSString stringWithDouble:current_price fractionCount:2];
}

//解析限制模型的属性
- (void)setRestrictions:(TGRestriction *)restrictions
{
    if ([restrictions isKindOfClass:[NSDictionary class]]) {
        _restrictions = [[TGRestriction alloc] init];
//        [_restrictions setValues:(NSDictionary *)restrictions];
        _restrictions = [TGRestriction objectWithKeyValues:(NSDictionary *)restrictions];
    } else {
        _restrictions = restrictions;
    }
}

//解析商家信息模型属性
- (void)setBusinesses:(NSArray *)businesses
{
    NSDictionary *obj = [businesses lastObject];
    if ([obj isKindOfClass:[NSDictionary class]]) {
        
        NSMutableArray *temp = [NSMutableArray array];
        for (NSDictionary *dict in businesses) {
            
            TGBusiness *b = [TGBusiness objectWithKeyValues:dict];
            [temp addObject:b];
        }
        
        _businesses = temp;
        
    } else {
        _businesses = businesses;
    }
}

- (BOOL)isEqual:(TGDeal *)other
{
    return [other.deal_id isEqualToString:_deal_id];
}

//归档属性
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:_title forKey:@"_title"];
    [encoder encodeDouble:_list_price forKey:@"_list_price"];
    
    [encoder encodeObject:_purchase_deadline forKey:@"_purchase_deadline"];
    [encoder encodeObject:_deal_id forKey:@"_deal_id"];
    [encoder encodeObject:_image_url forKey:@"_image_url"];
    [encoder encodeObject:_desc forKey:@"_desc"];
    [encoder encodeDouble:_current_price forKey:@"_current_price"];
    [encoder encodeInt:_purchase_count forKey:@"_purchase_count"];
}

//解析属性
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.title = [decoder decodeObjectForKey:@"_title"];
        self.purchase_deadline = [decoder decodeObjectForKey:@"_purchase_deadline"];
        self.deal_id = [decoder decodeObjectForKey:@"_deal_id"];
        self.image_url = [decoder decodeObjectForKey:@"_image_url"];
        self.desc = [decoder decodeObjectForKey:@"_desc"];
        self.current_price = [decoder decodeDoubleForKey:@"_current_price"];
        self.list_price = [decoder decodeDoubleForKey:@"_list_price"];
        self.purchase_count = [decoder decodeIntForKey:@"_purchase_count"];
    }
    return self;
}

@end
