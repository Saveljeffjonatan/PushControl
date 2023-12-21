# PushControl !*WORK IN PROGRESS*!

Quick note: This is an Open Source Project created by me, Jonatan Saveljeff as to have a fun and hopefully useful tool created at the end of my learning. I am by no means any good at Elixir or Phoenix but I would like to be at some point.

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Working feature

  * Creation of single notification message, pushing to websocket and parsing the message

## Learn more

  * Tool to create push notification without having to do releases via websockets/webhooks and other services (Note still WIP)
  * You can schedule notifications to run once in the future or run at an interval between a specific start and end time
  * Setup for communication to client exists (WIP, need to setup a unique identifier for the client, currently it sends to everyone subscribed)

## Changes to come

  * Data object as JSON, currently only pass a content of string
  * Proper history search of upcomming, active and passed events (WIP-Parts of it exists)
  * (Eventually) - Have the creation of all subscriptions as a script (webhook, server to server push, websocket and so on)
  * Much much more 
