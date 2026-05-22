#import <Foundation/Foundation.h>
#import <sys/time.h>
#import "JSONKit.h"

static double now_seconds(void)
{
    struct timeval tv;
    gettimeofday(&tv, NULL);
    return (double)tv.tv_sec + ((double)tv.tv_usec / 1000000.0);
}

static NSDictionary *CreateBenchmarkObject(void)
{
    NSMutableArray *items = [NSMutableArray array];

    int i;
    for (i = 0; i < 250; i++) {
        NSDictionary *item = [NSDictionary dictionaryWithObjectsAndKeys:
            [NSString stringWithFormat:@"item-%03d", i], @"id",
            [NSString stringWithFormat:@"Grüße vom G5 #%03d", i], @"title",
            [NSNumber numberWithInt:i], @"index",
            [NSNumber numberWithDouble:(double)i * 1.25], @"score",
            [NSArray arrayWithObjects:@"leopard", @"ppc", @"json", @"plist", nil], @"tags",
            nil];

        [items addObject:item];
    }

    return [NSDictionary dictionaryWithObjectsAndKeys:
        @"LeoJSON benchmark object", @"name",
        @"Mac OS X 10.5.8 PowerPC", @"target",
        [NSNumber numberWithInt:1], @"version",
        items, @"items",
        nil];
}

static void PrintResult(const char *name, int iterations, double seconds)
{
    double per_second = (seconds > 0.0) ? ((double)iterations / seconds) : 0.0;
    printf("%-34s %8d iterations  %10.4f sec  %10.2f ops/sec\n",
           name, iterations, seconds, per_second);
}

static void RunJSONParse(NSData *jsonData, int iterations)
{
    int i;
    double start = now_seconds();

    for (i = 0; i < iterations; i++) {
        NSError *error = nil;
        id object = [jsonData objectFromJSONDataWithParseOptions:JKParseOptionStrict
                                                           error:&error];
        if (object == nil) {
            fprintf(stderr, "JSON parse failed: %s\n", [[error description] UTF8String]);
            exit(1);
        }
    }

    PrintResult("JSONKit parse", iterations, now_seconds() - start);
}

static void RunJSONSerialize(id object, int iterations)
{
    int i;
    double start = now_seconds();

    for (i = 0; i < iterations; i++) {
        NSData *data = [object JSONData];
        if (data == nil || [data length] == 0) {
            fprintf(stderr, "JSON serialize failed\n");
            exit(1);
        }
    }

    PrintResult("JSONKit serialize", iterations, now_seconds() - start);
}

static void RunPlistParse(NSData *plistData, NSPropertyListFormat expectedFormat,
                          const char *label, int iterations)
{
    int i;
    double start = now_seconds();

    for (i = 0; i < iterations; i++) {
        NSString *errorString = nil;
        NSPropertyListFormat format = 0;

        id object = [NSPropertyListSerialization propertyListFromData:plistData
                                                     mutabilityOption:NSPropertyListImmutable
                                                               format:&format
                                                     errorDescription:&errorString];

        if (object == nil || format != expectedFormat) {
            fprintf(stderr, "%s parse failed: %s\n",
                    label,
                    errorString ? [errorString UTF8String] : "unknown error");
            [errorString release];
            exit(1);
        }

        [errorString release];
    }

    PrintResult(label, iterations, now_seconds() - start);
}

static void RunPlistSerialize(id object, NSPropertyListFormat format,
                              const char *label, int iterations)
{
    int i;
    double start = now_seconds();

    for (i = 0; i < iterations; i++) {
        NSString *errorString = nil;

        NSData *data = [NSPropertyListSerialization dataFromPropertyList:object
                                                                  format:format
                                                        errorDescription:&errorString];

        if (data == nil || [data length] == 0) {
            fprintf(stderr, "%s serialize failed: %s\n",
                    label,
                    errorString ? [errorString UTF8String] : "unknown error");
            [errorString release];
            exit(1);
        }

        [errorString release];
    }

    PrintResult(label, iterations, now_seconds() - start);
}

int main(int argc, const char *argv[])
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

    int iterations = 1000;

    if (argc > 1) {
        iterations = atoi(argv[1]);
        if (iterations <= 0) {
            iterations = 1000;
        }
    }

    NSDictionary *object = CreateBenchmarkObject();

    NSData *jsonData = [object JSONData];

    NSString *xmlError = nil;
    NSData *xmlPlistData =
        [NSPropertyListSerialization dataFromPropertyList:object
                                                   format:NSPropertyListXMLFormat_v1_0
                                         errorDescription:&xmlError];

    if (xmlPlistData == nil) {
        fprintf(stderr, "XML plist setup failed: %s\n",
                xmlError ? [xmlError UTF8String] : "unknown error");
        [xmlError release];
        [pool drain];
        return 1;
    }
    [xmlError release];

    NSString *binaryError = nil;
    NSData *binaryPlistData =
        [NSPropertyListSerialization dataFromPropertyList:object
                                                   format:NSPropertyListBinaryFormat_v1_0
                                         errorDescription:&binaryError];

    if (binaryPlistData == nil) {
        fprintf(stderr, "Binary plist setup failed: %s\n",
                binaryError ? [binaryError UTF8String] : "unknown error");
        [binaryError release];
        [pool drain];
        return 1;
    }
    [binaryError release];

    printf("LeoJSON JSONKit / plist benchmark\n");
    printf("Iterations: %d\n", iterations);
    printf("Payload sizes:\n");
    printf("  JSON:         %lu bytes\n", (unsigned long)[jsonData length]);
    printf("  XML plist:    %lu bytes\n", (unsigned long)[xmlPlistData length]);
    printf("  Binary plist: %lu bytes\n", (unsigned long)[binaryPlistData length]);
    printf("\n");

    RunJSONParse(jsonData, iterations);
    RunJSONSerialize(object, iterations);

    RunPlistParse(xmlPlistData, NSPropertyListXMLFormat_v1_0,
                  "XML plist parse", iterations);
    RunPlistSerialize(object, NSPropertyListXMLFormat_v1_0,
                      "XML plist serialize", iterations);

    RunPlistParse(binaryPlistData, NSPropertyListBinaryFormat_v1_0,
                  "Binary plist parse", iterations);
    RunPlistSerialize(object, NSPropertyListBinaryFormat_v1_0,
                      "Binary plist serialize", iterations);

    [pool drain];
    return 0;
}
