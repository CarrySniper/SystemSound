# SystemSound
系统声音和自定义声音播放

###百度经验
http://jingyan.baidu.com/article/ed2a5d1f656ba509f6be179e.html

###引入框架AudioToolbox.framework
```
#import <AudioToolbox/AudioToolbox.h>
````

###iOS播放系统声音:
系统自带AudioToolbox.framework框架，内置很多声音，SystemSoundID在1000~2000都是系统声音ID。<br>
当然有些声音ID是指向同一个文件，即播放同一个声音；还有iPhone和iPad同一个ID，指向的却是不同的文件，即播放不同的声音。<br>
```
SystemSoundID soundId = 1000;
AudioServicesPlaySystemSound(soundId);
```
###播放自定义声音：
自定义声音文件时长不超过30秒，格式：.caf、.aif .wav等。代码在github的cjq002的SystemSound上。<br>
```
/**
 播放自定义本地声音
 
 @param fileName 文件名 包含后缀
 */
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
```

##效果图
![](https://github.com/cjq002/SystemSound/raw/master/Media/demo1.png)

##效果图
![](https://github.com/cjq002/SystemSound/raw/master/Media/demo2.png)
