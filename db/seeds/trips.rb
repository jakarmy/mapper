#!/bin/env ruby
# encoding: utf-8

t = Trip.new(name: 'Night Life in Santiago', cover_image_url:'http://oldtownsaloonclovis.com/wp-content/uploads/2011/11/OldTownSaloonBar.jpg')
t.places << Place.create(name: "Tangkak", longitude: "-75.9375", latitude: "-27.059126")
t.places << Place.create(name: "La Encantada", longitude: "-74.93958215", latitude: "-14.82832")
t.places << Place.create(name: "A La Chucha", longitude: "-75.865219", latitude: "-33.819991")
t.places << Place.create(name: "Buddha Lounge Club", longitude: "-66.342506", latitude: "-33.300713")
t.places << Place.create(name: "Mystico Club", address: "Rivadavia", longitude: "-65.4943652178", latitude: "-27.1676998481")
t.places << Place.create(name: "Guantanamo Dance Club", address: "Sargento Candelaria", longitude: "-73.7895011902", latitude: "-42.6199388928")
t.save

t = Trip.new(name: 'Restaurants in Santiago', cover_image_url:'http://www.cafeitalialeeds.co.uk/cms_media/images/flash.jpg')
t.places << Place.create(name: "Restaurant Maritimo", longitude: "-72.5012781077", latitude: "-51.7277712214")
t.places << Place.create(name: "Café Restaurant El Mirador", longitude: "-73.5380274288", latitude: "-47.8034123845")
t.places << Place.create(name: "Restaurant El Madero", address: "Freire 430", longitude: "-73.617289", latitude: "-43.117023")
t.places << Place.create(name: "Restaurant La Olla", address: "R-225, Km. 1 (Camino a Ensenada)", longitude: "-72.9512840509", latitude: "-41.3273988316")
t.places << Place.create(name: "Restorant Boca Budi", longitude: "-73.3983461605", latitude: "-38.7966536953")
t.places << Place.create(name: "Restaurant D' Lastra", longitude: "-73.3974137374", latitude: "-37.7976775718")
t.save

t = Trip.new(name: 'Playas', cover_image_url:'http://www.maison1601.com/wp-content/themes/wonderwhite/images/maison1601-beaches.jpg')
t.places << Place.create(name: "Playa Tumbes", address: "Caleta Tumbes", longitude: "-73.0936077222", latitude: "-36.6417336068")
t.places << Place.create(name: "Playa Chica", address: "Panamericana Sur Km. 620.5", longitude: "-74.248374939", latitude: "-15.8645429611")
t.places << Place.create(name: "Playa Tanaka", longitude: "-74.4600129999", latitude: "-15.7266057862")
t.places << Place.create(name: "Playa Blanca", longitude: "-73.1422729492", latitude: "-52.9563560486")
t.places << Place.create(name: "Playa Hermosa", longitude: "-72.8896148633", latitude: "-41.3091535651")
t.places << Place.create(name: "Playa Frutillar", address: "Av. Bernardo Philippi", longitude: "-73.0274497046", latitude: "-41.1340416493")
t.save