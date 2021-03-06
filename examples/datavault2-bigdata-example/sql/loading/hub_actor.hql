INSERT INTO TABLE dv_raw.hub_actor
SELECT DISTINCT
      a.dv__bk as hkey_actor
    , a.dv__rec_source as rec_source
    , from_unixtime(unix_timestamp(a.dv__load_dtm, "yyyy-MM-dd'T'HH:mm:ss")) as load_dtm
    , a.first_name
    , a.last_name
FROM
    staging_dvdrentals.actor_{{ts_nodash}} a
WHERE
    NOT EXISTS (
        SELECT 
                hub.hkey_actor
        FROM 
                dv_raw.hub_actor hub
        WHERE
                hub.first_name = a.first_name
        AND     hub.last_name = a.last_name
    )
