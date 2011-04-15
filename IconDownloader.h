


@protocol IconDownloaderDelegate;

@interface IconDownloader : NSObject
{
    NSMutableDictionary *feedItem;
    NSIndexPath *indexPathInTableView;
    id <IconDownloaderDelegate> delegate;
    
    NSMutableData *activeDownload;
    NSURLConnection *imageConnection;
	
	UIImage *icon;
}

@property (nonatomic,retain) UIImage *icon;

@property (nonatomic, retain) NSMutableDictionary *feedItem;
@property (nonatomic, retain) NSIndexPath *indexPathInTableView;
@property (nonatomic, assign) id <IconDownloaderDelegate> delegate;

@property (nonatomic, retain) NSMutableData *activeDownload;
@property (nonatomic, retain) NSURLConnection *imageConnection;

- (void)startDownload;
- (void)cancelDownload;

@end

@protocol IconDownloaderDelegate 

- (void)appImageDidLoad:(NSIndexPath *)indexPath image:(UIImage *)image;

@end