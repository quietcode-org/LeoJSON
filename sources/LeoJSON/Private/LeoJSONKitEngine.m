#import "LeoJSONKitEngine.h"
#import "JSONKit.h"

static void LeoJSONKitEngineSetError(NSString **errorString, NSString *message)
{
    if (errorString != NULL) {
        *errorString = message;
    }
}

static NSString *LeoJSONKitEngineExceptionMessage(NSString *operation,
                                                  NSException *exception)
{
    NSString *name = [exception name] ? [exception name] : @"unknown exception";
    NSString *reason = [exception reason] ? [exception reason] : @"no reason";

    return [NSString stringWithFormat:@"LeoJSON: %@ raised %@: %@",
                                      operation,
                                      name,
                                      reason];
}

id LeoJSONKitEngineObjectFromData(NSData *data, NSString **errorString)
{
    NSError *jsonKitError = nil;
    id object = nil;

    if (errorString != NULL) {
        *errorString = nil;
    }

    @try {
        object = [data objectFromJSONDataWithParseOptions:JKParseOptionStrict
                                                    error:&jsonKitError];
    }
    @catch (NSException *exception) {
        LeoJSONKitEngineSetError(errorString,
                                 LeoJSONKitEngineExceptionMessage(@"JSON parse",
                                                                  exception));
        return nil;
    }

    if (object == nil) {
        NSString *message = @"LeoJSON: JSON parse failed";

        if (jsonKitError != nil) {
            message = [NSString stringWithFormat:@"LeoJSON: JSON parse failed: %@",
                       [jsonKitError description]];
        }

        LeoJSONKitEngineSetError(errorString, message);
        return nil;
    }

    return object;
}

NSData *LeoJSONKitEngineDataFromObject(id object, NSString **errorString)
{
    NSData *data = nil;

    if (errorString != NULL) {
        *errorString = nil;
    }

    if (![object respondsToSelector:@selector(JSONData)]) {
        LeoJSONKitEngineSetError(errorString,
                                 @"LeoJSON: object cannot be serialized as JSON");
        return nil;
    }

    @try {
        data = [object JSONData];
    }
    @catch (NSException *exception) {
        LeoJSONKitEngineSetError(errorString,
                                 LeoJSONKitEngineExceptionMessage(@"JSON serialization",
                                                                  exception));
        return nil;
    }

    if (data == nil || [data length] == 0) {
        LeoJSONKitEngineSetError(errorString,
                                 @"LeoJSON: JSON serialization failed");
        return nil;
    }

    return data;
}

