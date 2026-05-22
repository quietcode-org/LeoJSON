#import <Foundation/Foundation.h>
#import "JSONKit.h"

static int fail(NSString *message)
{
    fprintf(stderr, "FAIL: %s\n", [message UTF8String]);
    return 1;
}

int main(int argc, const char *argv[])
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

    NSString *jsonString =
        @"{"
         "\"name\":\"LeoJSON\","
         "\"target\":\"Mac OS X 10.5.8 PowerPC\","
         "\"values\":[1,2,3],"
         "\"unicode\":\"Grüße vom G5\""
        "}";

    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];

    NSError *error = nil;
    id object = [jsonData objectFromJSONDataWithParseOptions:JKParseOptionStrict
                                                       error:&error];

    if (object == nil) {
        NSString *message = [NSString stringWithFormat:@"parse error: %@", error];
        [pool drain];
        return fail(message);
    }

    if (![object isKindOfClass:[NSDictionary class]]) {
        [pool drain];
        return fail(@"parsed root object is not an NSDictionary");
    }

    NSDictionary *dict = (NSDictionary *)object;

    if (![[dict objectForKey:@"name"] isEqualToString:@"LeoJSON"]) {
        [pool drain];
        return fail(@"unexpected name field");
    }

    NSData *roundtrip = [dict JSONData];

    if (roundtrip == nil || [roundtrip length] == 0) {
        [pool drain];
        return fail(@"serialization returned empty data");
    }

    NSString *roundtripString =
        [[NSString alloc] initWithData:roundtrip encoding:NSUTF8StringEncoding];

    printf("OK: JSONKit smoke probe passed\n");
    printf("Roundtrip JSON: %s\n", [roundtripString UTF8String]);

    [roundtripString release];
    [pool drain];

    return 0;
}
