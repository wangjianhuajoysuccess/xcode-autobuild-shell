#工程名
project_name=Runner

#打包模式 Debug/Release
development_mode=Release

#scheme名
scheme_name=Runner

#plist文件所在路径
exportOptionsPlistPath=./DevelopmentExportOptionsPlist.plist

# 开始时间
# shellcheck disable=SC2006
beginTime=`date +%s`

# 开始时间 - 到处ipa文件用
# shellcheck disable=SC2006
ipabeginTime=`date +%Y-%m-%d%H:%M:%S`

#导出.ipa文件所在路径
exportFilePath=/XcodeExportProject/$project_name/$project_name-$ipabeginTime-adhoc-ipa


#echo '*** 正在 清理工程 ***'
#xcodebuild \
#clean -configuration ${development_mode} -quiet  || exit
#echo '*** 清理完成 ***'


echo '*** Compiling project For '${development_mode} '正在 编译工程 ***'
xcodebuild \
archive -workspace ${project_name}.xcworkspace \
-scheme ${scheme_name} \
-configuration ${development_mode} \
-archivePath build/${project_name}.xcarchive -quiet  || exit
echo '*** Compile completed ***  编译完成 😄 😄 😄 ***'


echo '*** Packaging *** 正在 打包 ***'
xcodebuild -exportArchive -archivePath build/${project_name}.xcarchive \
-configuration ${development_mode} \
-exportPath ${exportFilePath} \
-exportOptionsPlist ${exportOptionsPlistPath} \
-quiet || exit

# 删除build包
if [[ -d build ]]; then
    rm -rf build -r
fi

if [ -e $exportFilePath/$scheme_name.ipa ]; then
    echo "*** .ipa File exported *** .ipa文件已导出 ***"
    # shellcheck disable=SC2164
    cd ${exportFilePath}
    echo "*** Start upload .ipa file *** 开始上传.ipa文件 ***"
    #此处上传分发应用


    echo "*** .ipa File uploaded successfully *** .ipa文件上传成功 ***"
else
    echo "*** creat .ipa File failed *** 创建.ipa文件失败 ***"
fi

# 结束时间
# shellcheck disable=SC2006
endTime=`date +%s`

echo '*** Packaging is complete *** 打包完成 ***'
# shellcheck disable=SC2007
echo -e "Packing time $[ endTime - beginTime ] s"

