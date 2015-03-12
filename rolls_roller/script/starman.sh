#!/bin/sh
#plackup --server Starman --workers=5 -D --port 5000  --app /home/giftec/site2/giftec.pl

SITENAME=Regfactura

DIR=/home/pavel/regfactura_wsrv
SCRIPT=invapp.pl
USER=pavel

WORKERS=5
LISTEN=*:8090
ERROR_LOG=/home/pavel/regfactura_wsrv/log/error.log

PIDFILE=$DIR/site-$SITENAME.pid



case "$1" in
  start)
    plackup --server Starman --workers=$WORKERS -D --listen $LISTEN  \
    --app $DIR/$SCRIPT --pidfile=$PIDFILE \
    --pid $PIDFILE \
    --error-log $ERROR_LOG
    ;;
  stop)
    /sbin/start-stop-daemon --stop --pidfile $PIDFILE
    ;;
  *)
    echo "Usage: $SCRIPTNAME {start|stop}" >&2
    exit 3
    ;;
esac
