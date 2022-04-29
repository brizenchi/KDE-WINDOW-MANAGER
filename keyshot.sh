#!/bin/bash


APP_NAME="$1"
echo $APP_NAME


function myShortcuts() {
    # 判断窗口是否存在
    if isExsit 
    then
        # 判断当前窗口是否是需要激活的窗口
        if isActive      
        then       
            # 激活窗口
            # minimize
            active
        else
            # 最小化窗口
            minimize
        fi
    else
        # todo 启动进程，并激活窗口
        active
    fi
}
function isExsit() {
    
    wids=$(wmctrl -l |grep  $APP_NAME | awk '{print $1}')
    if [ -z "$wid" ]; then
        return 0
    fi
    return 1
}

function isActive() {

    wids=$(wmctrl -l |grep  $APP_NAME | awk '{print $1}')
    xwid=$(xdotool getactivewindow)
    widArr=($wids)
    for element in ${widArr[@]}
    do
        if [ $(printf '%d\n' $element) -eq $xwid ]; then
            return 1
        fi
    done
    return 0
}
function active() {
    wids=$(wmctrl -l |grep  $APP_NAME | awk '{print $1}')
    xdotool windowactivate $wids
}
function minimize() {
    wids=$(wmctrl -l |grep  $APP_NAME | awk '{print $1}')
    xwid=$(xdotool getactivewindow)
    widArr=($wids)
    for element in ${widArr[@]}
    do
        xdotool windowminimize $element
    done
}

myShortcuts $APP_NAME

