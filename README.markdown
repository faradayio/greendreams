![Trees](http://brighterplanet.github.com/greendreams/stylesheets/images/trees.png)

# greendreams

http://greendrea.ms

A compendium of environment-related APIs for developers to use in green apps, including sample queries that are run live in the browser.

## Rules

Yes, there are a few:

1. **Instant API key registration.** When it's 2AM and you're on the brink of something great, the last thing you need to see is an API key "approval" process. Email confirmations are fine.

1. **Free non-commercial use.** Volume limitations are fine.

1. **Client-side query support.** CORS or JSONP.

## Add an API

We've tried to make this as simple as possible.

1. Fork this project.

1. Add the API to the bottom of `apis.yml` (order is randomized on each page load, so there's no advantage to anything else)

1. Ensure that it works (just load `index.html` locally)

1. Submit a pull request

## apis.yml

Use this template to add your site:

``` yaml
# a "nickname" for the api -- lower_snake_case please
genability:
  # What the API's called
  name: Genability
  # What you can use it to do. Should fill in the blank in: "As a green developer, I want to _____ so that I can save the planet"
  action: Retrieve the price of electricity in a given region
  # The main link for the API 
  apiSite: "https://developer.genability.com"
  # The API's documentation link
  documentation: "https://developer.genability.com/documentation"
  # Where you can (instantly) register an API key
  keyRegistration: "https://developer.genability.com/signup"
  # A (real) API key that can be used in the sample query. Replaces "APIKEY" in "params," below
  apiKey: 05ba9810964c37387e30fd53b23a57da
  # Some APIs have a secondary key/token. This one replaces APIUSER in "params"
  apiUser: ca793a98
  # HTTP method used for sample query
  method: get
  # Sample query location
  location: "http://api.genability.com/rest/public/prices/729"
  # Sample query parameters
  params: "appId=APIUSER&appKey=APIKEY&fromDateTime=2012-01-01T11:25:12.0-0700"
  # Custom request headers if necessary
  headers:
    Accept: "text/javascript"
```

### Key security

Yes, we need a real API key for this project, and yes it is stored in this open source project in the clear. We only suggest that API owners watch for unusually high amounts of activity coming from these keys---there should only be traffic coming from this site and from individual developers' machines (for testing).

If anybody has any suggestions on how to handle this differently, please get in touch.

## Dreamers

This project was created by [Brighter Planet](http://brighterplanet.com) with generous help from (your wonderful name here).

### Wishlist

We'd love to see the following sites added:

* [Footprinted](http://footprinted.org) --- API key approval process
* [Tendril](http://tendrilinc.com)
* [AMEE](http://amee.com) -- currently needs HTTP basic auth