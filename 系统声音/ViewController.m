//
//  ViewController.m
//  系统声音
//
//  Created by 思久科技 on 16/9/20.
//  Copyright © 2016年 思久科技. All rights reserved.
//

#import "ViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import "SystemSoundModel.h"

@interface ViewController (){
    
    NSMutableArray *_dataArray;      //返回数据
}

@property (weak, nonatomic) IBOutlet UITextField *nameTF;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"SystemSound" ofType:@"plist"];
    NSMutableArray *sound = [NSMutableArray arrayWithContentsOfFile:path];
    
    _dataArray = [NSMutableArray array];
    
    [sound enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SystemSoundModel *model = [SystemSoundModel new];
        [model setValuesForKeysWithDictionary:obj];
        [_dataArray addObject:model];
        
        [self.tableView reloadData];
    }];
    
}

- (IBAction)playSound:(id)sender {
    if ([self.nameTF.text length]> 0) {
        [self playSoundWithFileName:self.nameTF.text];
    }else{
        NSLog(@"音频文件名不能为空！");
    }
}

#pragma mark - UITableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(_dataArray != nil && _dataArray.count != 0){
        return _dataArray.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"UITableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    SystemSoundModel *model = _dataArray[indexPath.row];
    cell.textLabel.text = model.Category;
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SystemSoundModel *model = _dataArray[indexPath.row];
    SystemSoundID soundId = [model.SoundID intValue];
    AudioServicesPlaySystemSound(soundId);
    
}

- (void)playSoundWithFileName:(NSString *)fileName
{
    SystemSoundID soundID;
    NSURL *url = [[NSBundle mainBundle] URLForResource:fileName withExtension:nil];
    OSStatus errorCode = AudioServicesCreateSystemSoundID((__bridge CFURLRef)(url) , &soundID);
    if (errorCode != 0) {
        NSLog(@"create sound failed");
    }else{
        AudioServicesPlaySystemSound(soundID);
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self.view endEditing:YES];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
