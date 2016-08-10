
# if created a plain text backup use:
# $ psql $dbname < $backupfile
#

pg_restore -U$username --dbname=$databasename $filename

# to restore just one table:
# $pg_restore -U $username --dbname=$dbname --table=$tablename

