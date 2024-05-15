#!/bin/sh

CURRENTDATETIME=`date +'%Y-%m-%d-%H-%M-%S'`
BACKUPDIR="/mnt/md0/backups/latest"
BACKUPDAYSLIMIT=14

for d in /mnt/md0/data-storage-owncloud-pvc-* ; do
	rsync -av --delete --exclude 'apps' --exclude 'sessions' $d ${BACKUPDIR}
done

echo "Create tar in /mnt/md0/backups/archive/$CURRENTDATETIME.tar.gz"

tar czf /mnt/md0/backups/archive/$CURRENTDATETIME.tar.gz $BACKUPDIR

echo "Tar created"

echo "Check for backups older than $BACKUPDAYSLIMIT"

find /mnt/md0/backups/archive -name "*.tar.gz" -type f -mtime +$BACKUPDAYSLIMIT -delete