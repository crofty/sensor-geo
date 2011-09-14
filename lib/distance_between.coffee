Sensor.Geo.DEFAULT_UNITS = 'miles'
Sensor.Geo.DEFAULT_FORMULA = 'flat'

PI_DIV_RAD = 0.0174
KMS_PER_MILE = 1.609
NMS_PER_MILE = 0.868976242
EARTH_RADIUS_IN_MILES = 3963.19
EARTH_RADIUS_IN_KMS = EARTH_RADIUS_IN_MILES * KMS_PER_MILE
EARTH_RADIUS_IN_NMS = EARTH_RADIUS_IN_MILES * NMS_PER_MILE
MILES_PER_LATITUDE_DEGREE = 69.1
KMS_PER_LATITUDE_DEGREE = MILES_PER_LATITUDE_DEGREE * KMS_PER_MILE
NMS_PER_LATITUDE_DEGREE = MILES_PER_LATITUDE_DEGREE * NMS_PER_MILE
LATITUDE_DEGREES = EARTH_RADIUS_IN_MILES / MILES_PER_LATITUDE_DEGREE

Sensor.Geo.distanceBetween = (from,to,options={}) ->
  return 0 if from.lat == to.lat and from.lon == to.lon
  formula = options.formula || Sensor.Geo.DEFAULT_FORMULA
  units = options.formula || Sensor.Geo.DEFAULT_UNITS
  switch formula
    when "sphere"
      units_sphere_multiplier(units) *
        Math.acos( Math.sin(deg2rad(from.lat)) * Math.sin(deg2rad(to.lat)) +
        Math.cos(deg2rad(from.lat)) * Math.cos(deg2rad(to.lat)) *
        Math.cos(deg2rad(to.lon) - deg2rad(from.lon)))
    when 'flat'
      Math.sqrt(Math.pow(units_per_latitude_degree(units)*(from.lat-to.lat),2)) +
        Math.pow((units_per_longitude_degree(from.lat, units)*(from.lon-to.lon)),2)

units_sphere_multiplier = (units) ->
  switch units
    when 'kms' then EARTH_RADIUS_IN_KMS
    when 'miles' then EARTH_RADIUS_IN_MILES

deg2rad  = (degrees) ->
  degrees / 180.0 * Math.PI

units_per_latitude_degree = (units) ->
  switch units
    when 'kms' then KMS_PER_LATITUDE_DEGREE
    else  MILES_PER_LATITUDE_DEGREE

units_per_longitude_degree = (lat, units) ->
  miles_per_longitude_degree = Math.abs(LATITUDE_DEGREES * Math.cos(lat * PI_DIV_RAD))
  switch units
    when 'kms' then miles_per_longitude_degree * KMS_PER_MILE
    else  miles_per_longitude_degree
