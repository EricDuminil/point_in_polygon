# Point in Polygons
## Goal
This is a simple project, allowing me to play a bit with Rails/RGeo/GeoJSON.

* Given a list of fixed geographical areas:
![shapes](https://i.imgur.com/h469F87.png)
* This API-only Rails app determines if an incoming Location is inside any of the areas.

## Info

Written in Rails 2.5.3, with Ruby 2.4.1 on Linux.
It uses [RGeo](https://github.com/rgeo/rgeo) for geometry calculations.

## Specs

`rake spec` to launch the specs

## Usage

* `rails s` to launch the server
* Go to [`http://localhost:3000/v1/areas`](http://localhost:3000/v1/areas) to get the areas as GeoJSON
* Go to [`http://localhost:3000/v1/areas/contain?latitude=35.979643&longitude=-87.920342`](http://localhost:3000/v1/areas/contain?latitude=35.979643&longitude=-87.920342) to check if the corresponding point is inside any area.
* It's also possible to send a GeoJSON string with curl:
`curl -X GET -H "Content-Type: application/json" -d '{"type":"Point","coordinates":[-118,50]}' localhost:3000/v1/areas/contain`
* Yet another alternative is to send a GeoJSON file directly with curl:
`curl -vX GET http://localhost:3000/v1/areas/contain -d @paris.geojson --header "Content-Type: application/json"`

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

* Note that the HTTP request method is `GET`, since it is a read-only request.


