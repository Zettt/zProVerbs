#import <Foundation/Foundation.h>

#ifdef DEBUG
#    define DLog(...) NSLog(__VA_ARGS__)
#else
#    define DLog(...) /* */
#endif
#define ALog(...) NSLog(__VA_ARGS__)

int main (int argc, const char * argv[]) {
	// seed random
	srandom(time(0));
	int randomNumber;
	
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	
	
    NSArray *lines;
	NSString *currentUserHomeDirectory = NSHomeDirectory();
	NSString *motivationalSentencesFile = [NSString stringWithString:@"/.zProVerbs"];
	NSString *filePath = [NSString stringWithString:[currentUserHomeDirectory stringByAppendingString:motivationalSentencesFile]];
	
	NSFileManager *manager = [NSFileManager defaultManager];
	if (![manager fileExistsAtPath:filePath isDirectory:NO]) {
		DLog(@"gibts noch nicht");
				
		NSString *proVerbs = [NSString stringWithString:@"line 1\n"
								 "line 2\n"
								 "line 3\n"];
				
		NSData *data = [proVerbs dataUsingEncoding:[NSString defaultCStringEncoding] allowLossyConversion:YES];
		[data writeToFile:filePath atomically:YES];
		
		NSLog(@"%@", proVerbs);
	}
	
    lines = [[[NSString stringWithContentsOfFile:filePath] 
			  stringByStandardizingPath] 
			 componentsSeparatedByString:@"\n"];
	
	randomNumber = random() % [lines count];
	
	printf("%s\n", [[lines objectAtIndex:randomNumber] UTF8String]);

    [pool drain];
    return 0;
}
