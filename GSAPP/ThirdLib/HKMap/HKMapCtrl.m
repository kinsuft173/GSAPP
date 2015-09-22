//
//  HKMapCtrl.m
//  eCarter
//
//  Created by kinsuft173 on 15/7/7.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import "HKMapCtrl.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>
#import "HKMapManager.h"
#import "MANaviRoute.h"
#import "CommonUtility.h"
#import "CustomAnnotationView.h"
#import "CustomCalloutView.h"
#import "HKCommen.h"
#import "UserDataManager.h"
#import "MBProgressHUD.h"
#import "CustomAnnotationView.h"

#define MapKey @"43f7282f10fcb91468f352bf4dda056c"
const NSString *NavigationViewControllerStartTitle       = @"起点";
const NSString *NavigationViewControllerDestinationTitle = @"终点";

enum {
    AnnotationViewControllerAnnotationTypeRed = 0,
    AnnotationViewControllerAnnotationTypeGreen,
    AnnotationViewControllerAnnotationTypePurple
};


@interface HKMapCtrl ()<MAMapViewDelegate,AMapSearchDelegate,UIGestureRecognizerDelegate,UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSArray *_pois;
}

@property (nonatomic, strong) MAMapView* mapView;
@property (nonatomic, strong) AMapSearchAPI* search;
@property (nonatomic, strong) UIButton* btnLocation;
@property (nonatomic, strong) CLLocation *currentLocation;
@property (nonatomic, strong) MAPointAnnotation *destinationPoint;
@property (nonatomic, strong) UILongPressGestureRecognizer *longPressGesture;
@property (nonatomic, strong) NSArray *pathPolylines;

@property (nonatomic, strong) UITableView* tableViewForTint;
@property  (nonatomic, strong) NSMutableArray* arrayTint;


@property (nonatomic, strong) IBOutlet UIView* viewForTitel;
@property (nonatomic, strong) IBOutlet UIView* viewForSearch;
@property (nonatomic, strong) IBOutlet UISearchBar* searchBar;
@property (nonatomic, strong) UIView *viewForMask;
@property (nonatomic, strong) IBOutlet UIButton* btnCar;
@property (nonatomic, strong) IBOutlet UIButton* btnBus;
@property (nonatomic, strong) IBOutlet UIButton* btnWalk;
@property (nonatomic, strong) NSString* strCity;

@property (nonatomic, strong) NSMutableArray *annotations;


@property (nonatomic, strong) CLLocationManager *locationManager;

/* 用于显示当前路线方案. */
@property (nonatomic) MANaviRoute * naviRoute;

@property (nonatomic) AMapSearchType searchType;
@property (nonatomic, strong) AMapRoute *route;

/* 当前路线方案索引值. */
@property (nonatomic) NSInteger currentCourse;
/* 路线方案个数. */
@property (nonatomic) NSInteger totalCourse;

@property (nonatomic, strong) UIBarButtonItem *previousItem;
@property (nonatomic, strong) UIBarButtonItem *nextItem;

/* 起始点经纬度. */
@property (nonatomic) CLLocationCoordinate2D startCoordinate;
/* 终点经纬度. */
@property (nonatomic) CLLocationCoordinate2D destinationCoordinate;

@end

@implementation HKMapCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"长按地图即可选定相应位置";
    
    
    UIButton *rightButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setFrame:CGRectMake(0, 0, 30, 50)];
    rightButton.titleLabel.font=[UIFont systemFontOfSize:14.0];
    [rightButton setTitle:@"确定" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(commitEdit) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithCustomView:rightButton ];
    self.navigationItem.rightBarButtonItem=rightItem;
    
    [self initUI];
    [self initMap];
    
 //   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paopaoHit:) name:@"hitPaopao" object:nil];
//    [self addDefaultAnnotations];
    [self initSearch];
    [self initControls];
    [self initAttributes];
    
}

- (void)paopaoHit:(NSNotification*)notify
{
    NSLog(@"notify = %@",notify);
    
    [self.navigationController popViewControllerAnimated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addDefaultAnnotations
{
    
    CLLocationCoordinate2D point ;
    point.latitude = 23.134412;
    point.longitude = 113.401149;
    self.startCoordinate = point ;
    
    CLLocationCoordinate2D pointD ;
    pointD.latitude =   23.137888;
    pointD.longitude = 113.329231;
    self.destinationCoordinate = pointD ;
    
    
    
    MAPointAnnotation *destinationAnnotation = [[MAPointAnnotation alloc] init];
    destinationAnnotation.coordinate = self.destinationCoordinate;
    destinationAnnotation.title      = (NSString*)NavigationViewControllerDestinationTitle;
    destinationAnnotation.subtitle   = [NSString stringWithFormat:@"{%f, %f}", self.destinationCoordinate.latitude, self.destinationCoordinate.longitude];
    
    MAPointAnnotation *startAnnotation = [[MAPointAnnotation alloc] init];
    startAnnotation.coordinate = self.startCoordinate;
    startAnnotation.title      = (NSString*)NavigationViewControllerStartTitle;
    startAnnotation.subtitle   = [NSString stringWithFormat:@"{%f, %f}", self.startCoordinate.latitude, self.startCoordinate.longitude];
    

   
    [self.mapView addAnnotation:startAnnotation];
    [self.mapView addAnnotation:destinationAnnotation];

}

- (void)updateTotal
{
    NSUInteger total = 0;
    
    if (self.route != nil)
    {
        switch (self.searchType)
        {
            case AMapSearchType_NaviDrive   :
            case AMapSearchType_NaviWalking : total = self.route.paths.count;    break;
            case AMapSearchType_NaviBus     : total = self.route.transits.count; break;
            default: total = 0; break;
        }
    }
    
    self.totalCourse = total;
}

/* 更新"上一个", "下一个"按钮状态. */
- (void)updateCourseUI
{
    /* 上一个. */
    self.previousItem.enabled = (self.currentCourse > 0);
    
    /* 下一个. */
    self.nextItem.enabled = (self.currentCourse < self.totalCourse - 1);
}

/* 更新"详情"按钮状态. */
- (void)updateDetailUI
{
    self.navigationItem.rightBarButtonItem.enabled = self.route != nil;
}

/* 展示当前路线方案. */
- (void)presentCurrentCourse
{
    /* 公交导航. */
    if (self.searchType == AMapSearchType_NaviBus)
    {
        self.naviRoute = [MANaviRoute naviRouteForTransit:self.route.transits[self.currentCourse]];
    }
    /* 步行，驾车导航. */
    else
    {
        MANaviAnnotationType type = self.searchType == AMapSearchType_NaviDrive? MANaviAnnotationTypeDrive : MANaviAnnotationTypeWalking;
        self.naviRoute = [MANaviRoute naviRouteForPath:self.route.paths[self.currentCourse] withNaviType:type];
    }
    
    //    [self.naviRoute setNaviAnnotationVisibility:NO];
    
    [self.naviRoute addToMapView:self.mapView];
    
    /* 缩放地图使其适应polylines的展示. */
    [self.mapView setVisibleMapRect:[CommonUtility mapRectForOverlays:self.naviRoute.routePolylines] animated:YES];
}

/* 清空地图上已有的路线. */
- (void)clear
{
    [self.naviRoute removeFromMapView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - init and config

- (void)initUI
{
//    self.navigationItem.titleView = self.viewForTitel;
}



- (void)initMap
{
    [MAMapServices sharedServices].apiKey = MapKey;
    
    self.mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
    
    self.mapView.delegate = self;
    
    
    [self.view addSubview:self.mapView];
    

    
            CLLocationCoordinate2D co;
    
    co.latitude = [HKMapManager shareMgr].floatUserCurrentLatitude;
    co.longitude = [HKMapManager shareMgr].floatUserCurrentLongitude;
    
    NSLog(@"co = %f%f",co.latitude,co.longitude);
    
    if ([HKMapManager shareMgr].floatUserCurrentLatitude > 1) {
        
        NSLog(@"指定位置");
        
        CLLocationCoordinate2D co;
        
        co.latitude = [HKMapManager shareMgr].floatUserCurrentLatitude;
        co.longitude = [HKMapManager shareMgr].floatUserCurrentLongitude;
        
        NSLog(@"co = %f%f",co.latitude,co.longitude);
        
       // [self.mapView setCenterCoordinate:co animated:YES];
   
        
        self.mapView.zoomLevel = 16.1;
        
        self.mapView.showsUserLocation = YES;
        self.mapView.userTrackingMode = MAUserTrackingModeFollow;
           //  self.mapView.centerCoordinate = co;
        
    }else{
       self.mapView.showsUserLocation = YES;
        self.mapView.userTrackingMode = MAUserTrackingModeFollow;
     
    }
    
    
    [self.mapView setZoomLevel:16.1 animated:YES];
    
    //在map上添加了
    CGRect rect = self.viewForSearch.frame;
    
    rect.size.width = SCREEN_WIDTH;
    
    self.viewForSearch.frame = rect;
    
    self.viewForMask = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.viewForMask.backgroundColor = [UIColor blackColor];
    self.viewForMask.alpha = 0.6;
    self.viewForMask.hidden = YES;
    
    [self.view addSubview:self.viewForMask];
    [self.view addSubview:self.viewForSearch];
    
    //添加取消手势

    UIGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goCancel:)];
        
    [self.viewForMask addGestureRecognizer:tapGesture];
    
    self.tableViewForTint = [[UITableView alloc] initWithFrame:CGRectMake(0,44, SCREEN_WIDTH, SCREEN_HEIGHT - 108 - 216) style:UITableViewStylePlain];
    self.tableViewForTint.delegate = self;
    self.tableViewForTint.dataSource = self;
    
    self.tableViewForTint.hidden = YES;
    
    
    [self.view addSubview:self.tableViewForTint];
    
}

- (void)initSearch
{
    _search = [[AMapSearchAPI alloc] initWithSearchKey:MapKey Delegate:self];
}

- (void)initControls
{
    self.btnLocation = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnLocation.frame = CGRectMake(20, CGRectGetHeight(_mapView.bounds) - 80, 40, 40);
    self.btnLocation.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    self.btnLocation.backgroundColor = [UIColor whiteColor];
    self.btnLocation.layer.cornerRadius = 5;
    
    [self.btnLocation addTarget:self action:@selector(locateAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.btnLocation setImage:[UIImage imageNamed:@"location_no"] forState:UIControlStateNormal];
    
    [self.mapView addSubview:self.btnLocation];

}





#pragma mark - Handle URL Scheme

- (NSString *)getApplicationName
{
    NSDictionary *bundleInfo = [[NSBundle mainBundle] infoDictionary];
    
    NSLog(@"config.appName = %@",[bundleInfo valueForKey:@"CFBundleDisplayName"]);
    return [bundleInfo valueForKey:@"CFBundleDisplayName"];
}

- (NSString *)getApplicationScheme
{
    NSDictionary *bundleInfo    = [[NSBundle mainBundle] infoDictionary];
    NSString *bundleIdentifier  = [[NSBundle mainBundle] bundleIdentifier];
    NSArray *URLTypes           = [bundleInfo valueForKey:@"CFBundleURLTypes"];
    
    NSString *scheme;
    for (NSDictionary *dic in URLTypes)
    {
        NSString *URLName = [dic valueForKey:@"CFBundleURLName"];
        if ([URLName isEqualToString:bundleIdentifier])
        {
            scheme = [[dic valueForKey:@"CFBundleURLSchemes"] objectAtIndex:0];
            break;
        }
    }
    
    NSLog(@"config.appScheme = %@",scheme);
    
    return scheme;
}

- (void)locateAction
{
    if (self.mapView.userTrackingMode != MAUserTrackingModeFollow)
    {
        [self.mapView setUserTrackingMode:MAUserTrackingModeFollow animated:YES];
    }
}


- (void)pathAction
{
//    if (_  == nil || _currentLocation == nil || _search == nil)
//    {
//        NSLog(@"path search failed");
//        return;
//    }
    
    AMapNavigationSearchRequest *request = [[AMapNavigationSearchRequest alloc] init];
    
    // 设置为步行路径规划
    request.searchType = self.searchType;
    request.city = @"广州";

    
    request.origin = [AMapGeoPoint locationWithLatitude:self.startCoordinate.latitude longitude:self.startCoordinate.longitude];
    request.destination = [AMapGeoPoint locationWithLatitude:self.destinationCoordinate.latitude longitude:self.destinationCoordinate.longitude];
    
    
    [self clear];
    [_search AMapNavigationSearch:request];
}

- (void)initAttributes
{
    _longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    _longPressGesture.delegate = self;
    [self.mapView addGestureRecognizer:_longPressGesture];
    
    [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(goOther) name:@"goDaohang" object:nil];

}


- (void)goOther
{
    NSLog(@"goOther");


}

#pragma mark - MapView Delegate

//- (MAOverlayView *)mapView:(MAMapView *)mapView viewForOverlay:(id<MAOverlay>)overlay
//{
//    if ([overlay isKindOfClass:[MAPolyline class]])
//    {
//        MAPolylineView *polylineView = [[MAPolylineView alloc] initWithPolyline:overlay];
//        
//        polylineView.lineWidth   = 4;
//        polylineView.strokeColor = [UIColor magentaColor];
//        
//        return polylineView;
//    }
//    
//    return nil;
//}



- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    if (updatingLocation) {
        
        NSLog(@"latitude : %f,longitude: %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
        
        _currentLocation = [userLocation.location copy];
        
    }

}

- (void)mapView:(MAMapView *)mapView didChangeUserTrackingMode:(MAUserTrackingMode)mode animated:(BOOL)animated
{
    // 修改定位按钮状态
    if (mode == MAUserTrackingModeNone)
    {
        [self.btnLocation setImage:[UIImage imageNamed:@"location_no"] forState:UIControlStateNormal];
    }
    else
    {
        [self.btnLocation setImage:[UIImage imageNamed:@"location_yes"] forState:UIControlStateNormal];
    }
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
//    if ([annotation isKindOfClass:[MAPointAnnotation class]])
//    {
//        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
//        MAPinAnnotationView *annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
//        if (annotationView == nil)
//        {
//            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
//            
//
//        }
//        annotationView.canShowCallout = YES;
//        UIView* view =[[UIView alloc] initWithFrame:CGRectMake( 0, 0, 20, 45)];
//        view.backgroundColor = [UIColor redColor];
//
//        annotationView.rightCalloutAccessoryView = view;
//        
//        
//        
//        return annotationView;
//    }
//    
//    return nil;
    
//    if ([annotation isKindOfClass:[MAPointAnnotation class]])
//    {
//        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
//        CustomAnnotationView *annotationView = (CustomAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
//        if (annotationView == nil)
//        {
//            annotationView = [[CustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
//        }
//        annotationView.image = [UIImage imageNamed:@"restaurant"];
//        
//        // 设置为NO，用以调用自定义的calloutView
//        annotationView.canShowCallout = NO;
//        
//        // 设置中心点偏移，使得标注底部中间点成为经纬度对应点
//        annotationView.centerOffset = CGPointMake(0, -18);
//        return annotationView;
//    }
    
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        CustomAnnotationView *annotationView = (CustomAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[CustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
        }
        annotationView.image = [UIImage imageNamed:@"restaurant"];
        
        // 设置为NO，用以调用自定义的calloutView
        annotationView.canShowCallout = NO;
        
        // 设置中心点偏移，使得标注底部中间点成为经纬度对应点
        annotationView.centerOffset = CGPointMake(0, -18);
        return annotationView;
    }
    
    return nil;
    
    return nil;
}

- (void)goBack:(UIGestureRecognizer*)gesture
{



}

//- (void)initAnnotations:
//{
//    self.annotations = [NSMutableArray array];
//    
//    /* Red annotation. */
//    MAPointAnnotation *red = [[MAPointAnnotation alloc] init];
//    red.coordinate = CLLocationCoordinate2DMake(39.911447, 116.406026);
//    red.title      = @"Red";
//    [self.annotations insertObject:red atIndex:AnnotationViewControllerAnnotationTypeRed];
//    
//    /* Green annotation. */
//    MAPointAnnotation *green = [[MAPointAnnotation alloc] init];
//    green.coordinate = CLLocationCoordinate2DMake(39.909698, 116.296248);
//    green.title      = @"Green";
//    [self.annotations insertObject:green atIndex:AnnotationViewControllerAnnotationTypeGreen];
//    
//    /* Purple annotation. */
//    MAPointAnnotation *purple = [[MAPointAnnotation alloc] init];
//    purple.coordinate = CLLocationCoordinate2DMake(40.045837, 116.460577);
//    purple.title      = @"Purple";
//    [self.annotations insertObject:purple atIndex:AnnotationViewControllerAnnotationTypePurple];
//}

- (void)mapView:(MAMapView *)mapView annotationView:(MAAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    NSLog(@"view :%@", view);
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

- (void)mapView:(MAMapView *)mapView annotationView:(MAAnnotationView *)view didChangeDragState:(MAAnnotationViewDragState)newState fromOldState:(MAAnnotationViewDragState)oldState
{
    NSLog(@"old :%ld - new :%ld", oldState, newState);
}

//- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view
//{
//    // 选中定位annotation的时候进行逆地理编码查询
//    if ([view.annotation isKindOfClass:[MAUserLocation class]])
//    {
//        [self reGeoAction];
//    }
//}


- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view
{
    NSLog(@"hehe");
    
    // 选中定位annotation的时候进行逆地理编码查询
    if ([view.annotation isKindOfClass:[MAUserLocation class]])
    {
        [self reGeoAction];
    }
    
    // 调整自定义callout的位置，使其可以完全显示
    if ([view isKindOfClass:[CustomAnnotationView class]]) {
        CustomAnnotationView *cusView = (CustomAnnotationView *)view;
        CGRect frame = [cusView convertRect:cusView.calloutView.frame toView:_mapView];
        
        frame = UIEdgeInsetsInsetRect(frame, UIEdgeInsetsMake(kDefaultCalloutViewMargin, kDefaultCalloutViewMargin, kDefaultCalloutViewMargin, kDefaultCalloutViewMargin));
        
        if (!CGRectContainsRect(_mapView.frame, frame))
        {
            CGSize offset = [self offsetToContainRect:frame inRect:self.mapView.frame];
            
            CGPoint theCenter = _mapView.center;
            theCenter = CGPointMake(theCenter.x - offset.width, theCenter.y - offset.height);
            
            CLLocationCoordinate2D coordinate = [_mapView convertPoint:theCenter toCoordinateFromView:_mapView];
            
            [_mapView setCenterCoordinate:coordinate animated:YES];
        }
        
    }
}



#pragma mark - AMapSearchDelegate

- (void)searchRequest:(id)request didFailWithError:(NSError *)error
{
    NSLog(@"request :%@, error :%@", request, error);
}

- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    NSLog(@"response :%@", response);
    
    NSString *title = response.regeocode.addressComponent.city;
    self.strCity = title;
    
    if (title.length == 0)
    {
        // 直辖市的city为空，取province
        title = response.regeocode.addressComponent.province;
    }
    
    // 更新我的位置title
    _mapView.userLocation.title = title;
    _mapView.userLocation.subtitle = response.regeocode.formattedAddress;
    
 
        
        [HKMapManager shareMgr].address = response.regeocode.formattedAddress;
   
    
}


- (void)onNavigationSearchDone:(AMapNavigationSearchRequest *)request response:(AMapNavigationSearchResponse *)response
{
    NSLog(@"搜索回调 = %@",response);
    
    if (self.searchType != request.searchType)
    {
        return;
    }
    
    if (response.route == nil)
    {
        return;
    }
    
    self.route = response.route;
    [self updateTotal];
    self.currentCourse = 0;
    
    [self updateCourseUI];
    [self updateDetailUI];
    
    [self presentCurrentCourse];
    
}




#pragma mark - actions and funcs
- (void)reGeoAction
{
    if (_currentLocation)
    {
        AMapReGeocodeSearchRequest *request = [[AMapReGeocodeSearchRequest alloc] init];
        
        request.location = [AMapGeoPoint locationWithLatitude:_currentLocation.coordinate.latitude longitude:_currentLocation.coordinate.longitude];
        
        
        [_search AMapReGoecodeSearch:request];
    }
}

- (void)handleLongPress:(UILongPressGestureRecognizer *)gesture
{
    
    if (gesture.state == UIGestureRecognizerStateBegan)
    {
        CLLocationCoordinate2D coordinate = [_mapView convertPoint:[gesture locationInView:_mapView]
                                              toCoordinateFromView:_mapView];
        
        NSLog(@"坐标＝%f,%f",coordinate.latitude,coordinate.longitude);
        
        // 添加标注
        if (_destinationPoint != nil)
        {
            // 清理
            [_mapView removeAnnotation:_destinationPoint];
            _destinationPoint = nil;
            
            [_mapView removeOverlays:_pathPolylines];
            _pathPolylines = nil;
        }
        
        _destinationPoint = [[MAPointAnnotation alloc] init];
        _destinationPoint.coordinate = coordinate;
        _destinationPoint.title = @"Destination";
        
        
        [self reGeoAction];
        
        [_mapView addAnnotation:_destinationPoint];
    }
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}


- (NSArray *)polylinesForPath:(AMapPath *)path
{
    if (path == nil || path.steps.count == 0)
    {
        return nil;
    }
    
    NSMutableArray *polylines = [NSMutableArray array];
    
    [path.steps enumerateObjectsUsingBlock:^(AMapStep *step, NSUInteger idx, BOOL *stop) {
        
        NSUInteger count = 0;
        CLLocationCoordinate2D *coordinates = [self coordinatesForString:step.polyline
                                                         coordinateCount:&count
                                                              parseToken:@";"];
        
        MAPolyline *polyline = [MAPolyline polylineWithCoordinates:coordinates count:count];
        [polylines addObject:polyline];
        
        free(coordinates), coordinates = NULL;
    }];
    
    return polylines;
}





- (CLLocationCoordinate2D *)coordinatesForString:(NSString *)string
                                 coordinateCount:(NSUInteger *)coordinateCount
                                      parseToken:(NSString *)token
{
    if (string == nil)
    {
        return NULL;
    }
    
    if (token == nil)
    {
        token = @",";
    }
    
    NSString *str = @"";
    if (![token isEqualToString:@","])
    {
        str = [string stringByReplacingOccurrencesOfString:token withString:@","];
    }
    else
    {
        str = [NSString stringWithString:string];
    }
    
    NSArray *components = [str componentsSeparatedByString:@","];
    NSUInteger count = [components count] / 2;
    if (coordinateCount != NULL)
    {
        *coordinateCount = count;
    }
    CLLocationCoordinate2D *coordinates = (CLLocationCoordinate2D*)malloc(count * sizeof(CLLocationCoordinate2D));
    
    for (int i = 0; i < count; i++)
    {
        coordinates[i].longitude = [[components objectAtIndex:2 * i]     doubleValue];
        coordinates[i].latitude  = [[components objectAtIndex:2 * i + 1] doubleValue];
    }
    
    return coordinates;
}


#pragma mark － 切换出行方式
- (IBAction)go:(UIButton*)sender
{
    if (sender == self.btnCar) {
        
        self.searchType = AMapSearchType_NaviDrive;
        
        
    }else if (sender == self.btnBus){
    
        
        self.searchType = AMapSearchType_NaviBus;
    
    
    }else if(sender == self.btnWalk){
    
        
        self.searchType = AMapSearchType_NaviWalking;
    
    }
    
    [self pathAction];

}


- (void)commitEdit
{
    if (!_destinationPoint) {
        
//        [HKCommen addAlertViewWithTitel:@"请长按选择一个位置"];
        
        [self.delegate handleMapSelectedWithDic];
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
        return;
        
    }else{
    
        [UserDataManager shareManager].curruentCoordinate =  _destinationPoint.coordinate;
    
        [self.delegate handleMapSelectedWithDic];
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }

}

#pragma mark - SearchBar Delegate

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
    self.viewForMask.hidden = NO;
    
    
//    if (searchBar.text.length == 0) {
//        
//        
//    }else{
//        
//        
//        
//        
//    }
    
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
//    if ([searchBar.text isEqualToString:@""]) {
//        
//        self.tableViewForTint.hidden = NO;
//    }else{
//        
//            self.tableViewForTint
//    }
    
    self.viewForMask.hidden = YES;
    self.tableViewForTint.hidden = YES;
}

#pragma mark - 手势
- (IBAction)goCancel:(id)sender
{
    
    
    //    [self.delegate goCancel2];
    [self.searchBar resignFirstResponder];
    
    self.searchBar.text = @"";
    self.viewForMask.hidden = YES;
    
//    [SearchModelManager shareManager].arraySearchExpertModel = nil;
//    [SearchModelManager shareManager].arraySearchHintModel = nil;
//    [SearchModelManager shareManager].arraySearchVideoModel = nil;
//    
//    
//    self.tableviewForResult.hidden = YES;
//    self.maskView100.hidden = YES;
//    
//    [self.tableviewForHit reloadData];
//    [self.tableviewForResult reloadData];
//    self.tableviewForHit.hidden = YES;
}

#pragma mark - search delegate method

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
    if (searchText && (![searchText isEqualToString:@""])) {
        
        AMapInputTipsSearchRequest *tipsRequest= [[AMapInputTipsSearchRequest alloc] init];
        tipsRequest.searchType = AMapSearchType_InputTips;
        tipsRequest.keywords = searchText;
//        tipsRequest.city = @[@"广州"];
        
        //发起输入提示搜索
        [_search AMapInputTipsSearch: tipsRequest];
        
        self.tableViewForTint.hidden = NO;
        
        
    }else{
        
        self.arrayTint = [[NSMutableArray alloc] init];;
        
        [self.tableViewForTint reloadData];
        
        self.tableViewForTint.hidden = YES;
        
    }
    
    
}

    

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];
    NSLog(@"搜索按钮被点");
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:searchBar.text forKey:@"keyword"];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"正在加载...";
    
//    [[SearchModelManager shareManager] searchDataWithDic:dict withBlock:^{
//        
//        self.tableviewForHit.hidden = YES;
//        self.maskView100.hidden = YES;
//        
//        [self.tableviewForResult reloadData];
//        
//        self.tableviewForResult.hidden = NO;
//        
//        [hud hide:YES];
//        
//    }];
    
    [hud hide:YES];
    
    
//    /构造AMapPlaceSearchRequest对象，配置关键字搜索参数
    AMapPlaceSearchRequest *poiRequest = [[AMapPlaceSearchRequest alloc] init];
    poiRequest.searchType = AMapSearchType_PlaceKeyword;
//    poiRequest.location = [AMapGeoPoint locationWithLatitude:_currentLocation.coordinate.latitude longitude:_currentLocation.coordinate.longitude];
    poiRequest.keywords =  searchBar.text;//searchBar.text;
    // types属性表示限定搜索POI的类别，默认为：餐饮服务、商务住宅、生活服务
    // POI的类型共分为20种大类别，分别为：
    // 汽车服务、汽车销售、汽车维修、摩托车服务、餐饮服务、购物服务、生活服务、体育休闲服务、
    // 医疗保健服务、住宿服务、风景名胜、商务住宅、政府机构及社会团体、科教文化服务、
    // 交通设施服务、金融保险服务、公司企业、道路附属设施、地名地址信息、公共设施
//    poiRequest.types = @[@"餐厅"];
    poiRequest.city = @[@"广州"];
//    poiRequest.requireExtension = YES;
    
    //发起POI搜索
    [_search AMapPlaceSearch: poiRequest];
    
}


//实现POI搜索对应的回调函数
- (void)onPlaceSearchDone:(AMapPlaceSearchRequest *)request response:(AMapPlaceSearchResponse *)response
{
    NSLog(@"response = %@",response);
    
    if(response.pois.count == 0)
    {
        return;
    }
    
    if (response.pois.count > 0)
    {
        _pois = response.pois;
        
        // 清空标注
        [_mapView removeAnnotations:_annotations];
        [_annotations removeAllObjects];
        
        // 为点击的poi点添加标注
        
        BOOL hehe = NO;
            for (AMapPOI *poi in response.pois) {
                
                
                MAPointAnnotation *annotation = [[MAPointAnnotation alloc] init];
                annotation.coordinate = CLLocationCoordinate2DMake(poi.location.latitude, poi.location.longitude);
                annotation.title = poi.name;
                annotation.subtitle = poi.address;
                
                [_mapView addAnnotation:annotation];
                
                [_annotations addObject:annotation];
                
                if (hehe == NO) {
                    
                    hehe = YES;
                    
                    [HKMapManager shareMgr].floatUserCurrentLatitude  = poi.location.latitude;
                    
                    [HKMapManager shareMgr].floatUserCurrentLongitude = poi.location.longitude;
                    
                    break;
                }
                

            }
        

        
        
        [self.navigationController popViewControllerAnimated:YES];
        
        

    }else{
    
        [HKCommen addAlertViewWithTitel:@"没有搜索到相关地点"];
    
    }
    
    //通过AMapPlaceSearchResponse对象处理搜索结果
//    NSString *strCount = [NSString stringWithFormat:@"count: %d",response.count];
//    NSString *strSuggestion = [NSString stringWithFormat:@"Suggestion: %@", response.suggestion];
//    NSString *strPoi = @"";
//    for (AMapPOI *p in response.pois) {
//        strPoi = [NSString stringWithFormat:@"%@\nPOI: %@", strPoi, p.description];
//    }
//    NSString *result = [NSString stringWithFormat:@"%@ \n %@ \n %@", strCount, strSuggestion, strPoi];
//    NSLog(@"Place: %@", result);
}


#pragma mark - Helpers

- (CGSize)offsetToContainRect:(CGRect)innerRect inRect:(CGRect)outerRect
{
    CGFloat nudgeRight = fmaxf(0, CGRectGetMinX(outerRect) - (CGRectGetMinX(innerRect)));
    CGFloat nudgeLeft = fminf(0, CGRectGetMaxX(outerRect) - (CGRectGetMaxX(innerRect)));
    CGFloat nudgeTop = fmaxf(0, CGRectGetMinY(outerRect) - (CGRectGetMinY(innerRect)));
    CGFloat nudgeBottom = fminf(0, CGRectGetMaxY(outerRect) - (CGRectGetMaxY(innerRect)));
    return CGSizeMake(nudgeLeft ?: nudgeRight, nudgeTop ?: nudgeBottom);
}


- (void)mapView:(MKMapView *)mv didAddAnnotationViews:(NSArray *)views {
    
    for (MKAnnotationView *annoView in views) {
        
        MAPointAnnotation *anno = annoView.annotation;
        [mv selectAnnotation:anno animated:YES];
    }
}

//搜索提示
//实现输入提示的回调函数
-(void)onInputTipsSearchDone:(AMapInputTipsSearchRequest*)request response:(AMapInputTipsSearchResponse *)response
{
    if(response.tips.count == 0)
    {
        return;
    }
    
    //通过AMapInputTipsSearchResponse对象处理搜索结果
    NSString *strCount = [NSString stringWithFormat:@"count: %d", response.count];
    NSString *strtips = @"";
    
    self.arrayTint = [[NSMutableArray alloc] init];
    for (AMapTip *p in response.tips) {
        
        strtips = [NSString stringWithFormat:@"%@\nTip: %@", strtips, p.description];
        
        [self.arrayTint addObject:p.name];
    }
    
    NSString *result = [NSString stringWithFormat:@"%@ \n %@", strCount, strtips];
    
    [self.tableViewForTint reloadData];
    NSLog(@"arrayTint: %@", response.tips);
}

#pragma tableble datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    return self.arrayModel.count;
    return self.arrayTint.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString* cellId = @"ExpertCell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        
    }
    
    NSString* tip = [self.arrayTint objectAtIndex:indexPath.row];
    
    cell.textLabel.text = tip;
    
    
    return cell;
}

#pragma tableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSDictionary* item = [self.arrayModel objectAtIndex:indexPath.row];
    
//    GSExpert* expert = [GSExpert objectWithKeyValues:item];
//    
//    
//    [self performSegueWithIdentifier:@"goExpertDetails" sender:expert];
    
    self.searchBar.text =  [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
    
    [self searchBarSearchButtonClicked:self.searchBar];
    
}




@end
