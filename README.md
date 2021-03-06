# Sched Jewels

"The Crystal Clear Way of Organization"

(BETA Version)

## Description

Sched Jewels is an organization app focused around the Google API and Google OAuth. This app helps reduce the amount of communication between groups on different platforms (ex: Facebook, iMessage, WhatsApp). Often times, Facebook events get ignored and not everyone has the same communication platforms for groups.

This app uses a gmail account. With a simple click and approval of Sched Jewels accessing calendars, users are able to create events with potential times, invite atttendees, vote on the time that works best for them and chat. Once the event has been voted on, the majority vote will get pushed to everyone's Google calendar which can by synced to Outlook, mobile devices and more.

Sched Jewels also allows users to create groups with friends, family members or a significant other. They can create lists and add items (ex: groceries, tasks). Users can also chat with each other.

## Features

Some of the key features include:
- Simple Google login
- Create events and invite attendees
- Vote on events
- Chat with members
- Create groups
- Create group lists
- Chat in groups
- Responsive design

## Getting Started

Sched Jewels uses `Rails Version 4.2.5`

##### Steps:

`$ bundle install`

`$ bundle install exec figaro install`

- Go to https://console.developers.google.com/ and make a project
- Enable and manage APIs
- Go to credentials
- Make new credentials with OAuth client ID
- In config/application.yml replace key and secret

`GOOGLE_KEY: "Client_ID"`

`GOOGLE_SECRET: "Client_Secret"`

## Creators

Feel free to contact the creators of Sched Jewels with any inquiries you may have:

[Stephanie Nguyen](http://www.stephthi.com/)

[Lauren Herdman](http://www.laurenherdman.com/)

[Colin Grenville](http://www.colingrenville.com/)

