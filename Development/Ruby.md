[TOC]

### 入门

[更容易入门的Rails 教程](https://legacy.gitbook.com/book/sg552/happy_book_rails/details)

#### ruby 属性和方法打印

```ruby
 # 遍历Hash,取出key,value
    target.instance_variables.each do |value|
        # 递归调用,打印Hash中的对象,名称为key，层级+1
        puts "#{value}"
    end

# 获取方法名称列表，并遍历
    target.public_methods.each do |method|
        # 打印方法名称
        puts "    ┣ #{method}"
    end
```

### cocoapods
#### gem install cocoapods

error：

```bash
ERROR:  Could not find a valid gem 'cocoapods' (>= 0), here is why:
          Unable to download data from https://gems.ruby-china.org/ - bad response Not Found 404 (https://gems.ruby-china.org/specs.4.8.gz)
```

> 因域名备案问题，.org 域名无法继续提供 RubyGems 镜像服务，我们提供 .com 代替 .org 的域名，其他一切不变！！
> 
> 详情访问 https://gems.ruby-china.com


更新方法：

```bash
gem sources --add https://gems.ruby-china.com/ --remove https://rubygems.org/ --remove https://gems.ruby-china.org/
```

查看本地镜像：
```
gem sources -l  
```


#### hooks

```ruby
# Hooks生成的Xcode project 操作前做最后的改动
post_install do |installer|
  project = installer.pods_project
  project.targets.each do |target|

    # 判断是否有source_build_phase方法
    if target.public_methods.include?(:source_build_phase)
        source_files = target.source_build_phase.files
        source_files.find do |file|
            #puts "File: #{file.display_name}"
            target_nmae = "#{target.name}-dummy.m"
            if file.display_name == target_nmae
                #file.file_ref = nil
                #file.remove_from_project
                source_files.delete file #删除 xxx-dummy.m 文件引用
                puts "Deleting source file #{target_nmae} from target #{target.name}."
            end
        end
    end
  end
end
```


```ruby
# Hooks生成的Xcode project 操作前做最后的改动
post_install do |installer|
  project = installer.pods_project
  project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['CLANG_MODULES_AUTOLINK'] = 'NO' #不自动链接系统库
    end
    #添加libEfnLogin 静态库到 Pods-EfunUniSDK
    if target.name == 'Pods-iHTCSDK'
      lib_name = loginModule_lib_name()
      if lib_name.empty?
        puts "【🚫】Pods-HTCModule 导入失败"
      else
        lib_path = "HTCModule/pod_lib/#{lib_name}"
        build_phase = target.frameworks_build_phase
        framework_group = project.frameworks_group
        file_ref = framework_group.new_reference(lib_path)
        file_ref.source_tree = '<group>'
        build_phase.add_file_reference(file_ref)
        puts "【👌】Pods-HTCModule《#{lib_name}》导入完成"
      end
    end
  end
end


# 获取 EfunLoginModule 的静态库文件
def loginModule_lib_name()
  path = Pathname.new(File.dirname(__FILE__)).realpath #当前脚本路径
  dir_path = "#{path}/Pods/HTCModule/pod_lib"
  puts "HTCModule静态库目录："
  puts dir_path
  if File.exist?(dir_path)
    Find.find(dir_path) do |path|
      if File.file?(path)
        file_name = File.basename(path)
        if (file_name.start_with? "libHTCLogin_" and file_name.end_with? ".a")
          return file_name
        end
      end
    end
  end
end
```


```ruby
  user_project = installer.aggregate_targets.first.user_project
  user_project.targets.each do |target|
    puts target.name
    # 判断是否有source_build_phase方法
    if target.public_methods.include?(:frameworks_build_phase)
      lib_nmae = "libPods-#{target.name}.a"
      build_phase = target.frameworks_build_phase
      framework_group = user_project.frameworks_group
      build_phase.files_references.each do |file|
        #puts file.display_name
        if file.display_name == lib_nmae
          puts file.display_name
          build_phase.remove_file_reference(file)
          framework_group.children.delete(file)
          puts "Deleting libraries #{lib_nmae} from target #{target.name}."
          break
        end
      end
    end
  end
```

- [CocoaPods Guides - Podfile Syntax Reference <span>v1.8.0.beta.1</span>](https://guides.cocoapods.org/syntax/podfile.html#group_hooks)
- [Xcodeproj/build_phase.rb at master · CocoaPods/Xcodeproj](https://github.com/CocoaPods/Xcodeproj/blob/master/lib/xcodeproj/project/object/build_phase.rb)