//
//  SongWordsViewController.m
//  你的思路呢#55
//
//  Created by qingyun on 15/12/25.
//  Copyright © 2015年 com.qingyun. All rights reserved.
//

#import "SongWordsViewController.h"
#import "SongPlayerSingle.h"
#import "geciModel.h"
#import "SongListSingle.h"

@interface SongWordsViewController ()<UITableViewDelegate,UITableViewDataSource,SongPlayerPro>
@property (weak, nonatomic) IBOutlet UITableView *geciTableView;
@property (weak, nonatomic) IBOutlet UIButton *playModelBtn;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UISlider *voice;
@property (weak, nonatomic) IBOutlet UISlider *progressSlider;

@end

@implementation SongWordsViewController

- (void)viewDidLoad {
    
    [SongPlayerSingle shareSongHandle].delegate = self;
    [self layoutVIEWs];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)playMusic:(UIButton *)sender
{
    if ([SongPlayerSingle shareSongHandle].playOrNot) {
        [SongPlayerSingle shareSongHandle].playOrNot = NO;
        [sender setTitle:@"播放" forState:UIControlStateNormal];
    }else{
        [SongPlayerSingle shareSongHandle].playOrNot = YES;
        [sender setTitle:@"暂停" forState:UIControlStateNormal];
    }
}
- (IBAction)prepareSong:(UIButton *)sender
{
    [[SongPlayerSingle shareSongHandle]prepare];
}

- (IBAction)nextSong:(UIButton *)sender
{
    [[SongPlayerSingle shareSongHandle]nextSong];
}

- (IBAction)playModelChange:(UIButton *)sender
{
    switch ([SongPlayerSingle shareSongHandle].playtype) {
        case orderLoop:
            [SongPlayerSingle shareSongHandle].playtype = singelLoop;
        [ _playModelBtn setTitle:@"单曲循环" forState:UIControlStateNormal];
            
            break;
            
        case singelLoop:
            [SongPlayerSingle shareSongHandle].playtype = randowLoop;
            [ _playModelBtn setTitle:@"随机播放" forState:UIControlStateNormal];
            break;
            
        case randowLoop:
            [SongPlayerSingle shareSongHandle].playtype = orderLoop;
            [ _playModelBtn setTitle:@"顺序播放" forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
    
}
- (IBAction)voiceChange:(UISlider *)sender
{
    [SongPlayerSingle shareSongHandle].voice = sender.value;
}
- (IBAction)progressChange:(UISlider *)sender
{
    [SongPlayerSingle shareSongHandle].currentTime = sender.value;
}



-(void)updateLrcNotifi
{
    [_geciTableView reloadData];
}

-(void)layoutVIEWs
{
    if ([SongPlayerSingle shareSongHandle].playOrNot) {
        [_playBtn setTitle:@"暂停" forState:UIControlStateNormal];
    }else{
        
        [_playBtn setTitle:@"播放" forState:UIControlStateNormal];
    }

    _voice.maximumValue = 1;
    
    _voice.value = [SongPlayerSingle shareSongHandle].voice;
    
    _progressSlider.maximumValue = [SongPlayerSingle shareSongHandle].durition;
    
    _progressSlider.value = [SongPlayerSingle shareSongHandle].currentTime;
    
    switch ([SongPlayerSingle shareSongHandle].playtype) {
        case orderLoop:
            [_playModelBtn setTitle:@"顺序播放" forState:UIControlStateNormal];
            break;
            
        case singelLoop:
            [_playModelBtn setTitle:@"单曲循环" forState:UIControlStateNormal];
            break;
            
        case randowLoop:
            [_playModelBtn setTitle:@"随机播放" forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
    
}

#pragma mark 自定义协议
//接受到当前传过来的播放进度  和歌词匹配
-(void)sendCurrentTime:(NSTimeInterval)current
{
    _progressSlider.value = current;//刷新UI
    
    NSArray *keyList = [SongPlayerSingle shareSongHandle].gcModel.keyArr;
    
    int index = 0;
    for (NSNumber *number in keyList) {
        if (number.floatValue < current) {
            index += 1;
        }else{
            break;
        }
    }
    
    //刷新歌词tableView
    if (index < 1) {
        return;
    }
    
    [_geciTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index -1 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    
}



#pragma mark --datesource
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [SongPlayerSingle shareSongHandle].gcModel.keyArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    geciModel *model = [SongPlayerSingle shareSongHandle].gcModel;
    
    cell.textLabel.text = model.lrcDic[model.keyArr[indexPath.row]];
    
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
