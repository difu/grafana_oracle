create or replace NONEDITIONABLE procedure prometheus_metrics IS

    cursor c_processes is
        SELECT COUNT(*) as count FROM v$process;


    cursor c_sessions is
        select con_id, username, service_name, count(*) as numer_of_sessions
        from v$session where type ='USER' group by username, con_id, service_name;


--
-- Statement adapted from http://dirknachbar.blogspot.com/2020/03/generating-prometheus-metrics-directly.html
--

    cursor c_fileio is
        SELECT ddf.con_id, ddf.tablespace_name as tablespace_name, d.name as filename, f.phyblkrd as blocksread, f.phyblkwrt as blockswriten, f.phyblkrd + f.phyblkwrt as totalio 
        FROM v$filestat f, v$datafile d, cdb_data_files ddf WHERE  d.file# = f.file# and ddf.file_id = d.file# ORDER BY f.phyblkrd + f.phyblkwrt DESC;

  
begin
owa.num_cgi_vars := 0;
htp.init();
 
    htp.print('# HELP oracle_processes Current Number of processes');
    htp.print('# TYPE oracle_processes counter');
    for rec_processes in c_processes loop
        htp.print('oracle_processes ' || rec_processes.count);
    end loop;


    htp.print('# HELP oracle_sessions current number of sessions per user');
    htp.print('# TYPE oracle_sessions gauge');
    for rec_sessions in c_sessions loop
        htp.print('oracle_sessions{con_id="' || rec_sessions.con_id || '", username="' || rec_sessions.username || '", service="' || rec_sessions.service_name || '"} ' || rec_sessions.numer_of_sessions);
    end loop;

    htp.print('# HELP oracle_fileio Metrics from v$filestat, v$datafile');
    htp.print('# TYPE oracle_fileio counter');
    for rec_fileio in c_fileio loop
        htp.print('oracle_fileio{con_id="' || rec_fileio.con_id || '", tablespace_name="'||rec_fileio.tablespace_name||'",filename="'||rec_fileio.filename||'",type="blocksread"} ' || rec_fileio.blocksread);
        htp.print('oracle_fileio{con_id="' || rec_fileio.con_id || '", tablespace_name="'||rec_fileio.tablespace_name||'",filename="'||rec_fileio.filename||'",type="blockswriten"} ' || rec_fileio.blockswriten);
        htp.print('oracle_fileio{con_id="' || rec_fileio.con_id || '", tablespace_name="'||rec_fileio.tablespace_name||'",filename="'||rec_fileio.filename||'",type="totalio"} ' || rec_fileio.totalio);
    end loop;

end;
/
show err
exit