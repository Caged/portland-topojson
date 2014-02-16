SELECT row_to_json(featurecollection)
FROM
  (SELECT 'FeatureCollection' AS TYPE,
          array_to_json(array_agg(feature)) AS features
   FROM
     (SELECT 'Feature' AS TYPE,
             st_asgeojson(layer.geom)::json AS geometry,
             row_to_json(
                           (SELECT props
                            FROM
                              (SELECT name, gid) AS props)) AS properties
      FROM neighborhoods AS layer
      WHERE layer.gid = %NEIGHBORHOOD_GID%) AS feature) AS featurecollection;

