locA = locB = null
module "distanceBetween",
  setup: ->
    locA = {lat: 32.918593, lon: -96.958444}
    locB = {lat: 32.969527, lon: -96.990159}

test "distance between same with defaults", ->
  equals 0, Sensor.Geo.distanceBetween(locA,locA)

test "distance between same with miles and flat", ->
  equals 0, Sensor.Geo.distanceBetween(locA,locA, {units: 'miles', formula: 'flat'})

test "distance between same with kms and flat", ->
  equals 0, Sensor.Geo.distanceBetween(locA,locA, {units: 'kms', formula: 'flat'})

test "distance between same with miles and sphere", ->
  equals 0, Sensor.Geo.distanceBetween(locA,locA, {units: 'miles', formula: 'sphere'})

test "distance between same with kms and sphere", ->
  equals 0, Sensor.Geo.distanceBetween(locA,locA, {units: 'kms', formula: 'sphere'})

test "distance between diff with defaults", ->
  equals 3.97, Sensor.Geo.distanceBetween(locA,locB)

test "distance between diff with miles and flat", ->
  equals 3.97, Sensor.Geo.distanceBetween(locA,locB, {units: 'miles', formula: 'flat'})

test "distance between diff with kms and flat", ->
  equals 6.39, Sensor.Geo.distanceBetween(locA,locB, {units: 'kms', formula: 'flat'})

test "distance between diff with miles and sphere", ->
  equals 3.97, Sensor.Geo.distanceBetween(locA,locB, {units: 'miles', formula: 'sphere'})

test "distance between diff with kms and sphere", ->
  equals 6.39, Sensor.Geo.distanceBetween(locA,locB, {units: 'kms', formula: 'sphere'})
