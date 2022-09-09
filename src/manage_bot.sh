BOT_BASE_PATH=/opt/apps/hello-bot
PYTHON_INTERPRETER=/opt/apps/hello-bot/.venv/bin/python3
USAGE="hello-bot ... [Usage: $0 { start | restart } OR $0 { stop | status }]"

get_PID() {
    if [ `uname -s` = 'Linux' ]; then
        pslist=`/bin/ps -elf | grep 'app.py'`
    elif [ `uname -s` = 'FreeBSD' ]; then
        pslist=`/bin/ps ajxw | grep 'app.py'`
    else
        pslist=`/bin/ps -ef | grep 'app.py'`
    fi

    if [ `uname -s` = 'Linux' ]; then
        PID=`echo "$pslist" | grep -v grep | awk '{ print $4 }'`
    else
        PID=`echo "$pslist" | grep -v grep | awk '{ print $2 }'`
    fi
}

stop_process () {
    get_PID
    if [ ! -z "$PID" ]; then
        echo "hello-bot ... [attempting to stop bot with PID(s): $PID.]"
        /bin/kill ${PID} > /dev/null 2>&1
        echo "hello-bot ... [stopped]"
    else
        echo "hello-bot ... [no running bot processes.]"
    fi
}

status_process () {
    get_PID
    if [ ! -z "$PID" ]; then
        echo "hello-bot ... [process(es) running with PID(s): $PID.]"
    else
        echo "hello-bot ... [no running bot processes.]"
    fi
}

start_process () {
    
    get_PID
    if [ ! -z "$PID" ]
    then
        echo "hello-bot ... [bot process(es) already running with PID(s): $PID.]"
    else
        nohup $PYTHON_INTERPRETER $BOT_BASE_PATH/app.py &
        echo "hello-bot ... [started]"
    fi
}

restart_process () {
    stop_process
    sleep 1
    start_process
}

case "$1" in
'start')
    start_process
    ;;
'status')
    status_process
    ;;
'stop')
    stop_process
    ;;
'restart')
    restart_process
    ;;
*)
    echo $USAGE
    ;;
esac
