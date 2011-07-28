#!/usr/bin/lua
-- ------------------------------------------------------------------------- --
-- example_02.lua
-- ~~~~~~~~~~~~~~
-- Please do not remove the following notices.
-- Copyright (c) 2011 by Geekscape Pty. Ltd.
-- Documentation: http://http://geekscape.github.com/lua_mqtt_client
-- License: GPLv3 http://geekscape.org/static/aiko_license.html
-- Version: 0.0
--
-- Description
-- ~~~~~~~~~~~
-- Publish a sequence of messages to a specified topic.
-- Used to control some coloured RGB LEDs.
--
-- ToDo
-- ~~~~
-- - On failure, automatically reconnect to MQTT server.
-- ------------------------------------------------------------------------- --

function is_openwrt()
  return(os.getenv("USER") == "root")  -- Assume logged in as "root" on OpenWRT
end

-- ------------------------------------------------------------------------- --

if (not is_openwrt()) then require("luarocks.require") end
require("lapp")

local args = lapp [[
  Subscribe to topic1 and publish all messages on topic2
  -h,--host   (default localhost)   MQTT server hostname
  -i,--id     (default example_02)  MQTT client identifier
  -p,--port   (default 1883)        MQTT server port number
  -s,--sleep  (default 5.0)         Sleep time between commands
  -t,--topic  (default test/2)      Topic on which to publish
]]

local MQTT = require("mqtt_library")

local mqtt_client = MQTT.client.create(args.host, args.port)

mqtt_client:connect(args.id)

local index = 1
local messages = { "c010000", "c000100", "c000001" }

while (true) do
  mqtt_client:handler()
  socket.sleep(0.1)  -- seconds

  socket.sleep(args.sleep)  -- seconds
  mqtt_client:publish(args.topic, messages[index]);

  index = index + 1
  if (index > #messages) then index = 1 end
end

mqtt_client:destroy()

-- ------------------------------------------------------------------------- --