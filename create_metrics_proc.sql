create or replace NONEDITIONABLE procedure prometheus_metrics IS

    cursor c_processes is
        SELECT COUNT(*) as count FROM v$process;


    cursor c_sessions is
        select con_id, username, service_name, count(*) as numer_of_sessions
        from v$session where type ='USER' group by username, con_id, service_name;

  
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

end;
/
show err
exit
