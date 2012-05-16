#!/usr/bin/lua
--[[
Karl Palsson, ReMake Electric, 2012.
Considered to be released into the public domain

This provides a bare minimum example of using the mqtt library.
(It doesn't require lapp for command line parsing)
]]-- 

function callback(                                                             
  topic,    -- string
  message)  -- string
  print("Topic: " .. topic .. ", message: '" .. message .. "'")
end

local MQTT = require("mqtt_library")
local mqtt_client = MQTT.client.create("localhost", 1883, callback)
mqtt_client:connect("lua mq sample")
mqtt_client:subscribe({"#"})

local err = nil
while (err == nil) do
	err = mqtt_client:handler()
	socket.sleep(1.0)
end
