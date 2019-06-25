# Point in Polygons

[![Build Status](https://travis-ci.com/EricDuminil/point_in_polygon.svg?branch=master)](https://travis-ci.com/EricDuminil/point_in_polygon)

## Goal
This is a simple project, allowing me to play a bit with Rails/GeoJSON and 2D algorithms.

* Given a list of fixed geographical areas:
![shapes](https://raw.githubusercontent.com/EricDuminil/point_in_polygon/master/public/shapes.png)
* This API-only Rails app determines if an incoming Location is inside any of the areas.

## Info

* Written in Rails 2.5.3, with Ruby 2.6.3 on Linux.
* It doesn't use any external geo-utilities.
* It uses [Winding number](https://en.wikipedia.org/wiki/Winding_number) with this [algorithm](http://geomalgorithms.com/a03-_inclusion.html).

## Specs

`rake spec` to launch the specs

## Usage

* `rails s` to launch the server
* Go to [`http://localhost:3000/v1/areas`](http://localhost:3000/v1/areas) to get the areas as GeoJSON
* Go to [`http://localhost:3000/v1/areas/contain?latitude=35.979643&longitude=-87.920342`](http://localhost:3000/v1/areas/contain?latitude=35.979643&longitude=-87.920342) to check if the corresponding point is inside any area.
* It's also possible to send a GeoJSON string with curl:
`curl -H "Content-Type: application/json" -d '{"type":"Point","coordinates":[-118,50]}' localhost:3000/v1/areas/contain`
* Yet another alternative is to send a GeoJSON file directly with curl:
`curl http://localhost:3000/v1/areas/contain -d @paris.geojson --header "Content-Type: application/json"`

With `paris.geojson` looking like:

    {
        "type": "Feature",
    	"properties": {},
    	"geometry": {
    	    "type": "Point",
    	    "coordinates": [
    		2.3565673828124996,
    	    48.879167148960214
    	    ]
    	}
    }

* For convenience, `http://localhost:3000/v1/areas/contain` can be accessed via GET or POST.
