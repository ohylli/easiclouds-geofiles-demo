# Where are my cloud files stored?

This is a quick demo for ITEA EASI-CLOUDS that demonstrates a service in which the user can query for the geographical location of their files in a cloud service.

## Getting started

    git clone git@github.com:leonidas/easiclouds-geofiles-demo
    npm install
    npm start
    iexplore http://localhost:9001

## Mock API

Parameters should be URL encoded into the query string. All content is JSON.

* `GET /api/v1/servers`
  * Get the list of all servers in our storage cloud

```json
{
  "servers": [
    {
      "hostname": "foo-west.s3.amazonaws.com",
      "coordinates": {
        "lat": 61.525,
        "lng": 24.254
      }
    },
    {
      "hostname": "foo-east.s3.amazonaws.com",
      "coordinates": {
        "lat": 61.525,
        "lng": 21.254
      }
    }
  ]
}
```

* `GET /api/v1/files?url=...`
  * Get the list of servers that host a particular file
  * `url`: The URL of the file whose location you wish to check

```json
{
  "url": "https://s3.amazonaws.com/foobucket/barfile.mp3",
  "servers": [
    {
      "hostname": "foo-west.s3.amazonaws.com",
      "coordinates": {
        "lat": 61.525,
        "lng": 24.254,
        "active": true
      }
    }
  ]
}
```

## Commands

* `npm install`
  * Installs server-side dependencies from NPM and client-side dependencies from Bower
* `npm start`
  * Compiles your files, starts watching files for changes, runs the mock API and servers static files at port 9001
* `npm run build`
  * Builds & minifies everything
* `npm run deploy`
  * Deploy the demo on `staging.leonidasoy.fi`.
  * Asks for a sudo password - this means your password on `staging`.
  * Uses [Ansible](https://github.com/ansible/ansible). Installed during the first run using `pip` if you don't have it, provided that you have Python 2.7.
  * Requires that your SSH key is setup on your own user account and the `leonidas` user account.

## Enable LiveReload

Install [LiveReload for Chrome](https://chrome.google.com/webstore/detail/livereload/jnihajbhpnppcggbcgedagnkighmdlei?hl=en)
